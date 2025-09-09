---
status: done
date_created: 2025-09-08
date_modified: 2025-09-09
---

# Interactive Timer Management Enhancement

## Problem Statement

Currently, when a user tries to start a new timer while one is already running, the system shows information about the active timer but only provides one option: abort and manually stop the current timer elsewhere. This creates a poor user experience that requires multiple steps and context switching.

**Current Flow:**
1. User: F19 → Scripts → T (Start Timer)
2. System: "⏱️ Timer already running! Description: X, Started: Y, Duration: Z. Stop the current timer before starting a new one."
3. User: Must go to Moneybird web interface to stop timer
4. User: Return to Hammerspoon and retry timer start

## Proposed Enhancement

Replace the simple abort message with an interactive chooser that gives users multiple options when an active timer is detected.

### User Interface Design

**Interactive Chooser Options:**
```
⏱️ Active Timer Detected

Current: "Project work" (Started: 19:15, Duration: 2h 15m)

Choose action:
▶ Stop current & start new timer
  Cancel (keep current timer running)  
  View timer details
```

### Technical Implementation Plan

#### Phase 1: Core Stop Timer Functionality
1. **Add `stopTimer()` function** to timer-operations.lua
   - API endpoint: `PATCH /time_entries/{id}.json` with `ended_at` timestamp
   - Proper error handling and validation
   - Return stopped timer details

2. **Add `stopAndStartNewTimer()` workflow function**
   - Stop current active timer
   - Immediately proceed with new timer creation flow
   - Handle errors gracefully (if stop fails, don't start new)

#### Phase 2: Interactive User Interface  
3. **Create `showActiveTimerOptions()` chooser**
   - Replace current `handleActiveTimerFound()` function
   - Use `hs.chooser` for interactive menu
   - Display current timer info in chooser subtitle/context

4. **Implement user choice handlers**
   - **Stop & Start**: Call stop-and-start workflow
   - **Cancel**: Simple abort (current behavior)
   - **View Details**: Enhanced timer info display

#### Phase 3: Enhanced Features (Future)
5. **Add timer switching capabilities**
   - Show list of all active timers (if multiple)
   - Allow selective stopping of specific timers

6. **Add confirmation dialogs**
   - Confirm before stopping timer with significant duration
   - Show summary of stopped timer (time tracked, etc.)

### API Integration Requirements

#### New Timer Operations Needed
- **Stop Timer**: `PATCH /time_entries/{id}.json`
  ```json
  {
    "time_entry": {
      "ended_at": "2025-09-08T21:30:00.000Z"
    }
  }
  ```

- **Get Timer Details**: Enhanced active timer info
- **Batch Operations**: Stop multiple timers if needed

### User Experience Goals

#### Primary Benefits
1. **Seamless Workflow**: Complete timer management within Hammerspoon
2. **Reduced Context Switching**: No need to visit Moneybird web interface  
3. **Better Control**: Clear options instead of error-like abortion
4. **Time Savings**: One-click stop-and-start functionality

#### User Flow Examples

**Scenario A - Stop & Start New:**
1. F19 → Scripts → T
2. Chooser: Select "Stop current & start new timer"  
3. System: Stops active timer, proceeds with client/project selection
4. Result: New timer started, previous timer properly stopped

**Scenario B - Keep Current Timer:**
1. F19 → Scripts → T  
2. Chooser: Select "Cancel"
3. Result: Current timer continues, no new timer started

**Scenario C - Check Timer Details:**
1. F19 → Scripts → T
2. Chooser: Select "View timer details"
3. System: Shows enhanced timer info with duration, project, client
4. User can then choose to stop, continue, or cancel

### Technical Considerations

#### Error Handling
- **Stop API Failure**: Inform user, don't proceed with new timer
- **Network Issues**: Graceful degradation with clear error messages  
- **Invalid Timer State**: Handle timers that are already stopped

#### Performance
- **Chooser Response**: Keep chooser lightweight and fast
- **API Efficiency**: Minimize additional API calls
- **Caching**: Leverage existing timer cache for details

#### Compatibility
- **MenuHammer Integration**: Maintain existing F19 → Scripts → T workflow
- **Existing Functions**: Keep current `startTimer()` API for other integrations
- **Settings**: No breaking changes to stored user preferences

### Success Criteria

1. **Functional**: All timer operations work reliably (stop, start, view)
2. **User Experience**: Intuitive chooser interface with clear options
3. **Performance**: Chooser appears quickly, actions execute promptly  
4. **Reliability**: Proper error handling for all failure scenarios
5. **Integration**: Seamless integration with existing MenuHammer workflow

### Future Enhancements

- **Bulk Timer Management**: Stop/manage multiple active timers
- **Timer Templates**: Quick-start with recent timer configurations  
- **Time Tracking Analytics**: Show daily/weekly timer summaries
- **Smart Suggestions**: Suggest stopping timers over certain duration thresholds

## Context

This enhancement builds on the recently implemented active timer detection functionality. The current system successfully prevents multiple concurrent timers but with a poor user experience. By adding interactive options, we transform a blocking error into an empowering workflow tool, significantly improving time tracking efficiency within the Hammerspoon environment.

## Implementation Notes

### API Research Required
- **Stop Timer Endpoint**: Verify exact API endpoint and payload format for stopping timers
- **Timer Details**: Determine what additional timer information is available via API
- **Error Responses**: Document possible error conditions when stopping timers

### UI/UX Considerations  
- **Chooser Design**: Ensure chooser fits well with existing MenuHammer aesthetic
- **Keyboard Navigation**: Support arrow keys and Enter for quick selection
- **Visual Feedback**: Clear indication of current timer status and available actions

This enhancement represents a significant improvement to the timer management user experience, transforming a frustrating interruption into a smooth, integrated workflow.