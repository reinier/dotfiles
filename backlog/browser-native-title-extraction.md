---
status: done
date_created: 2025-09-17
date_modified: 2025-09-17
---

# Browser-Native Title Extraction for Authenticated Content

## Problem Statement

The current implementation fetches page titles via HTTP requests using `hs.http.asyncGet`, which loses the browser's authentication context. This causes several critical issues:

**Current Limitations:**
- **Authentication Loss**: HTTP requests don't include browser session cookies or authentication tokens
- **Generic Titles**: Protected pages return "Login Page" or "Sign In" titles instead of actual page titles
- **Missing Context**: Browser-specific state (logged-in status, personalization) is not available
- **User Experience**: Markdown links show misleading titles that don't match what users see in their browser

**Examples of Affected Sites:**
- Social media platforms (Twitter, LinkedIn, Facebook)
- Work applications (Slack, Notion, Jira, GitHub private repos)
- Banking and financial sites
- Any site requiring authentication

## Proposed Solution

Revert to browser-native title extraction while maintaining the multi-browser URL extraction architecture. Each browser should provide both URL and title using their respective automation capabilities.

**Key Requirements:**
1. **Authenticated Context**: Titles should reflect what the user actually sees in their browser
2. **Browser Consistency**: Each browser should provide both URL and title using the same method
3. **Fallback Strategy**: Graceful degradation when browser title extraction fails
4. **Performance**: Avoid double-browser interaction (URL then title)

## Technical Architecture

### Browser Handler Refactor

Update each browser handler to return both URL and title in a single operation:

```lua
local browserHandlers = {
    Safari = function()
        -- Single AppleScript call for both URL and title
        local as = [[
        try
            tell application "Safari"
                set u to URL of front document
                set t to name of front document
            end tell
            return u & "¶" & t
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]
        -- Parse both URL and title from result
    end,

    Arc = function()
        -- JavaScript execution for both URL and title
        local urlScript = "window.location.href"
        local titleScript = "document.title"
        -- Execute both and combine results
    end,

    Orion = function()
        -- Single AppleScript call for both URL and title
        local as = [[
        try
            tell application "Orion"
                set u to URL of current tab of window 1
                set t to name of current tab of window 1
            end tell
            return u & "¶" & t
        on error errMsg
            return "ERROR:" & errMsg
        end try
        ]]
    end,

    zen = function()
        -- GUI automation to get both URL and title
        -- Preferred option: Parse page source for title tag
        -- Alternative 1: Extract title from window title
        -- Alternative 2: Use JavaScript injection if possible
    end
}
```

### Browser-Specific Implementation Strategies

#### 1. **Safari & Orion (Native AppleScript)**
- **Advantage**: Both URL and title available via AppleScript
- **Implementation**: Single AppleScript call returning both values
- **Reliability**: High - native browser support

#### 2. **Arc (JavaScript via AppleScript)**
- **URL**: `execute front window's active tab javascript "window.location.href"`
- **Title**: `execute front window's active tab javascript "document.title"`
- **Challenge**: Requires two separate JavaScript executions
- **Solution**: Combine into single JavaScript call returning both

#### 3. **Zen Browser (GUI Automation)**
- **Option A**: Extract from window title (limited by browser's title format)
- **Option B**: Use accessibility APIs to read page title
- **Option C**: Inject JavaScript if browser supports it
- **Fallback**: HTTP title fetch as last resort

### Enhanced Data Structure

```lua
-- Return structure from browser handlers
{
    url = "https://example.com/page",
    title = "Actual Page Title",
    source = "browser", -- vs "http" for fallback
    success = true
}
```

## Implementation Strategy

### Phase 1: Core Browser Handler Refactor
1. **Update Safari Handler**
   - Modify to return both URL and title in single AppleScript call
   - Test with authenticated sites (GitHub, Twitter, etc.)

2. **Update Orion Handler**
   - Similar to Safari approach
   - Ensure compatibility with Orion's AppleScript implementation

3. **Update Arc Handler**
   - Create combined JavaScript execution for both URL and title
   - Handle potential execution failures gracefully

### Phase 2: Zen Browser Enhancement
1. **Research Zen Browser Capabilities**
   - Test if Zen supports JavaScript injection
   - Explore accessibility API options for title extraction
   - Document window title parsing patterns

2. **Implement Fallback Strategy**
   - Window title parsing as primary method
   - HTTP title fetch as absolute fallback
   - Clear indication to user about title source

### Phase 3: Error Handling & Fallbacks
1. **Cascading Fallback System**
   - Browser-native title (preferred)
   - HTTP title fetch (fallback for Zen)
   - Domain name (last resort)

2. **User Feedback**
   - Indicate title source in notifications
   - Alert user when fallback methods are used

## Browser-Specific Research Needed

### Safari & Orion
- ✅ **Known**: Both support `name of front document` via AppleScript
- ✅ **Implementation**: Straightforward single-call approach

### Arc Browser
- 🔍 **Research**: Can JavaScript calls be combined for efficiency?
- 🔍 **Test**: Reliability of `document.title` vs browser's displayed title
- 🔍 **Investigate**: Any authentication context issues with JavaScript execution

### Zen Browser
- 🔍 **Research**: Does Zen support JavaScript injection like Arc?
- 🔍 **Test**: Window title parsing patterns and reliability
- 🔍 **Explore**: Alternative automation approaches (accessibility APIs)
- 🔍 **Document**: When to fall back to HTTP vs when to fail

## Error Handling Strategy

### Browser-Level Failures
- **AppleScript Errors**: Clear user messaging about browser state
- **JavaScript Execution Failures**: Fallback to alternative methods
- **GUI Automation Failures**: Retry mechanism with user notification

### Title Extraction Failures
- **Empty Titles**: Use domain name as fallback
- **Generic Titles**: Detect common patterns ("Login", "Sign In") and warn user
- **Encoding Issues**: Ensure proper HTML entity decoding still works

### Fallback Hierarchy
1. **Primary**: Browser-native title extraction
2. **Secondary**: HTTP title fetch (with warning about authentication)
3. **Tertiary**: Domain name extraction
4. **Final**: User-provided title (manual input)

## User Experience Enhancements

### Title Source Indicators
- **Success Messages**: "Copied: [Page Title] (from Safari)"
- **Fallback Warnings**: "Used public title (not logged in): [Title]"
- **Failure Handling**: "Title unavailable, using domain: [domain.com]"

### Browser-Specific Optimizations
- **Safari/Orion**: Fast, reliable single-call approach
- **Arc**: Optimized JavaScript execution
- **Zen**: Clear indication when using fallback methods

## Testing Strategy

### Authentication Test Cases
1. **GitHub Private Repository**: Should show repo name, not "GitHub Login"
2. **Twitter Timeline**: Should show "Home / Twitter", not "Twitter Login"
3. **Slack Workspace**: Should show channel/workspace name
4. **Banking Sites**: Should show account page title, not "Login Portal"

### Cross-Browser Validation
- Test same authenticated page across all supported browsers
- Verify title consistency between browser display and extracted title
- Validate special character handling in browser-native titles

### Error Scenario Testing
- Browser not responding to automation
- Network disconnection during HTTP fallback
- Pages with dynamic titles (JavaScript-generated)
- Pages with unusual character encodings

## Migration Strategy

### Backward Compatibility
- **Function Signature**: Keep `getBrowserMarkdownLink()` interface unchanged
- **Fallback Behavior**: HTTP fetching still available as fallback
- **Configuration**: Optional setting to prefer browser-native vs HTTP titles

### Rollout Approach
1. **Phase 1**: Implement browser-native extraction alongside existing HTTP method
2. **Phase 2**: Switch default to browser-native with HTTP fallback
3. **Phase 3**: Remove HTTP-only mode after validation

## Success Metrics

### Functionality Goals
- 95%+ accuracy for authenticated page titles
- <3 second response time for browser-native extraction
- Graceful fallback in <1% of cases

### User Experience Goals
- Titles match what user sees in browser tab
- Clear indication of title source and reliability
- No authentication-related title mismatches

### Technical Goals
- Minimal browser interaction overhead
- Robust error handling across all browser types
- Maintainable code structure for future browser additions

## Future Enhancements

### Advanced Title Extraction
- **Dynamic Title Detection**: Handle JavaScript-updated titles
- **Custom Title Rules**: User-defined patterns for specific sites
- **Title History**: Remember titles for frequently accessed URLs

### Browser Integration
- **Deep Browser APIs**: Explore additional browser automation capabilities
- **Extension Support**: Consider browser extensions for enhanced integration
- **Cross-Browser Sync**: Coordinate title extraction across multiple open browsers

### Performance Optimizations
- **Title Caching**: Cache titles for recently accessed URLs
- **Batch Operations**: Handle multiple URLs efficiently
- **Background Processing**: Non-blocking title extraction for better UX