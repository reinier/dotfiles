---
status: done
date_created: 2025-09-17
date_modified: 2025-09-17
---

# Browser Chooser Refactor for Markdown Link Generator

## Problem Statement

The current markdown link generation script (`hammerspoon/functions/markdown-utils.lua`) is hardcoded to work with a single browser (currently Safari). This limits flexibility for users who work with multiple browsers or prefer different browsers for different tasks.

**Current Limitations:**
- Single browser support only
- Browser-specific title extraction tied to browser API
- No fallback mechanisms for unsupported browsers
- User must manually edit code to change browser

## Proposed Solution

Refactor the `getBrowserMarkdownLink()` function to support multiple browsers with:

1. **Interactive Browser Selection**: Use `hs.chooser` for dynamic browser selection
2. **Universal Title Fetching**: Fetch page titles via HTTP requests instead of browser APIs
3. **Modular Browser Support**: Browser-specific URL extraction methods
4. **Graceful Fallbacks**: GUI automation for browsers without AppleScript support

## Technical Architecture

### Browser Support Matrix

| Browser | URL Extraction Method | AppleScript Support | Fallback Required |
|---------|----------------------|-------------------|-------------------|
| Safari | `URL of front document` | Full | No |
| Orion | `URL of current tab of window 1` | Full | No |
| Arc | JavaScript: `window.location.href` | Partial | No |
| Zen Browser | GUI automation (Cmd+L, Cmd+C) | None | Yes |

### Core Components

#### 1. Browser Chooser Interface
```lua
-- Use hs.chooser for browser selection
local browserChooser = hs.chooser.new(function(choice)
    if choice then
        getBrowserUrl(choice.browserName)
    end
end)

local browsers = {
    {text = "Safari", subText = "Native AppleScript support", browserName = "Safari"},
    {text = "Arc", subText = "JavaScript execution via AppleScript", browserName = "Arc"},
    {text = "Orion", subText = "Native AppleScript support", browserName = "Orion"},
    {text = "Zen Browser", subText = "GUI automation fallback", browserName = "Zen Browser"}
}
```

#### 2. Browser-Specific URL Extractors
```lua
local browserHandlers = {
    Safari = function()
        -- AppleScript: tell application "Safari" to return URL of front document
    end,

    Orion = function()
        -- AppleScript: tell application "Orion" to return URL of current tab of window 1
    end,

    Arc = function()
        -- AppleScript + JavaScript: execute front window's active tab javascript "window.location.href"
    end,

    ["Zen Browser"] = function()
        -- GUI automation: Cmd+L, Cmd+C, clipboard extraction
    end
}
```

#### 3. HTTP Title Fetcher
```lua
local function fetchWebTitle(url, callback)
    hs.http.asyncGet(url, {}, function(status, body, headers)
        if status == 200 and body then
            -- Extract title using Lua patterns
            local title = body:match("<title>(.-)</title>") or
                         body:match("<title[^>]*>(.-)</title>") or
                         body:match('<title[^>]*>(.-)</title>')

            if title then
                -- Decode HTML entities
                title = hs.http.convertHtmlEntities(title)
                -- Clean up whitespace
                title = title:gsub("^%s*(.-)%s*$", "%1")
            end

            callback(title or "Unknown Title")
        else
            callback("Failed to fetch title")
        end
    end)
end
```

## Implementation Strategy

### Phase 1: Core Refactor
1. **Extract Browser Selection Logic**
   - Create `chooseBrowser()` function with `hs.chooser`
   - Implement browser detection and availability checking

2. **Modularize URL Extraction**
   - Create browser-specific handler functions
   - Implement error handling for each method
   - Add fallback mechanisms for unsupported browsers

### Phase 2: HTTP Title Fetching
1. **Replace Browser Title APIs**
   - Implement `fetchWebTitle()` with `hs.http.asyncGet`
   - Add HTML parsing with Lua patterns
   - Handle HTML entity decoding

2. **Async Flow Management**
   - Chain browser URL extraction → HTTP title fetch → markdown generation
   - Implement proper error handling throughout the async chain

### Phase 3: Enhanced User Experience
1. **Browser Availability Detection**
   - Check if browsers are installed and running
   - Filter chooser list to show only available browsers
   - Add visual indicators for running vs. installed browsers

2. **Improved Error Handling**
   - Graceful degradation when HTTP requests fail
   - Fallback to browser-provided titles when web fetch fails
   - User-friendly error messages

## Error Handling Strategy

### Browser URL Extraction Failures
- **Safari/Orion AppleScript fails**: Show error alert, suggest checking browser is running
- **Arc JavaScript fails**: Fallback to GUI automation method
- **Zen Browser GUI automation fails**: Retry mechanism with user notification

### HTTP Title Fetching Failures
- **Network errors**: Fallback to URL as title
- **HTML parsing failures**: Use domain name as title
- **Timeout errors**: Show loading indicator, allow user cancellation

### Fallback Hierarchy
1. Primary method (browser-specific)
2. GUI automation (universal fallback)
3. Manual clipboard content (last resort)

## User Experience Enhancements

### Browser Chooser Features
- **Search functionality**: Built-in with `hs.chooser`
- **Keyboard shortcuts**: Number keys for quick selection
- **Visual indicators**: Icons or symbols for browser types
- **Recent browser memory**: Remember last selected browser

### Async Feedback
- **Loading indicators**: Show progress for HTTP requests
- **Cancellation support**: Allow users to cancel long-running requests
- **Success notifications**: Confirm markdown link copied to clipboard

## Testing Strategy

### Unit Testing Approach
- **Mock browser applications**: Test AppleScript handlers without requiring browsers
- **HTTP request mocking**: Test title extraction with known HTML samples
- **Error simulation**: Test error handling paths with simulated failures

### Integration Testing
- **Multi-browser verification**: Test with all supported browsers installed
- **Network condition testing**: Test with slow/failed HTTP requests
- **Edge case handling**: Test with unusual HTML structures and encodings

## Migration Path

### Backward Compatibility
- **Configuration option**: Allow users to set default browser to skip chooser
- **Legacy function preservation**: Keep original `getBrowserMarkdownLink()` as fallback
- **Gradual rollout**: Phase implementation to minimize disruption

### User Communication
- **Documentation updates**: Update CLAUDE.md with new capabilities
- **Change notifications**: Alert users to new browser chooser functionality
- **Migration guide**: Help users adapt existing workflows

## Future Enhancements

### Potential Extensions
- **Browser-specific preferences**: Remember preferred browsers for different URL patterns
- **Bulk operations**: Support for generating multiple markdown links
- **Custom title formatting**: Allow users to customize title extraction and formatting
- **Integration hooks**: API for other Hammerspoon scripts to use browser data

### Advanced Features
- **Smart browser detection**: Automatically detect which browser has the target URL open
- **Cross-browser tab search**: Find and focus tabs across all browsers
- **Bookmark integration**: Generate markdown links from browser bookmarks
- **History integration**: Quick access to recently visited URLs

## Technical Considerations

### Performance Optimization
- **Async operations**: Ensure UI remains responsive during HTTP requests
- **Caching**: Consider caching recently fetched titles
- **Request throttling**: Limit concurrent HTTP requests

### Security Considerations
- **HTTPS handling**: Properly handle SSL certificates and redirects
- **Content filtering**: Sanitize extracted titles to prevent injection
- **Privacy protection**: Avoid logging sensitive URLs or content

### Cross-Platform Compatibility
- **macOS focus**: Leverage macOS-specific features (AppleScript, accessibility)
- **Browser version compatibility**: Handle differences between browser versions
- **System integration**: Work well with macOS security and privacy settings

## Success Metrics

### Functionality Goals
- Support for 4+ major browsers
- <2 second average response time for markdown link generation
- <5% failure rate across all browser/network combinations

### User Experience Goals
- Single-action workflow (one hotkey press → browser chooser → result)
- Clear error messages and recovery suggestions
- Consistent behavior across all supported browsers

### Maintainability Goals
- Modular code structure for easy browser addition
- Comprehensive error logging for troubleshooting
- Clear documentation for future development