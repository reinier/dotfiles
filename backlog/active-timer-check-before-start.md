---
status: done
date_created: 2025-08-25
date_modified: 2025-09-08
---

# Active Timer Check Before Starting New Timer

## Problem Statement

Currently, the timer start flow (`timerApi.startTimer()`) does not check if there's already an active timer running before creating a new time entry. This can lead to:

- Multiple concurrent timers running simultaneously
- Accidental double-billing of time
- Confusion about which timer is actually active
- Data integrity issues in time tracking

The Moneybird API allows multiple active timers, but from a user experience perspective, it's better to have only one active timer at a time.

## Proposed Solution

### 1. Pre-Start Active Timer Check

Modify the `startTimer` flow to check for active timers before proceeding with the timer creation process:

```lua
function M.startTimer(callback)
    config.getApiConfig(function(apiConfig, configError)
        if configError then
            callback(nil, configError)
            return
        end
        
        apiClient.getAdministrationId(apiConfig, function(adminId, adminError)
            if adminError then
                callback(nil, adminError)
                return
            end
            
            -- NEW: Check for active timers first
            timerOperations.getActiveTimers(apiConfig, adminId, function(activeTimers, activeError)
                if activeError then
                    callback(nil, activeError)
                    return
                end
                
                if #activeTimers > 0 then
                    -- Active timer found - abort and show info
                    M.handleActiveTimerFound(activeTimers[1], callback)
                    return
                end
                
                -- No active timers - proceed with normal flow
                M.proceedWithTimerStart(apiConfig, adminId, callback)
            end)
        end)
    end)
end
```

### 2. Active Timer Information Display

When an active timer is found, show comprehensive information about the running timer:

```lua
function M.handleActiveTimerFound(activeTimer, callback)
    local startTime = activeTimer.started_at or "Unknown"
    local description = activeTimer.description or "No description"
    local duration = M.calculateRunningDuration(startTime)
    
    local message = string.format(
        "⏱️ Timer already running!\n\n" ..
        "Description: %s\n" ..
        "Started: %s\n" ..
        "Duration: %s\n\n" ..
        "Stop the current timer before starting a new one.",
        description,
        M.formatStartTime(startTime),
        duration
    )
    
    hs.alert.show(message, 8)
    callback(nil, message)
end
```

### 3. User Flow Options

Provide users with clear options when an active timer is detected:

**Option A: Simple Abort (Recommended)**
- Show active timer info
- Abort the new timer creation
- User manually stops current timer before starting new one

**Option B: Interactive Choice (Future Enhancement)**
- Show active timer info
- Offer choices: "Stop current & start new", "Cancel", "View details"
- Implement stop-and-start flow

### 4. Utility Functions to Add

```lua
-- Calculate duration of running timer
function M.calculateRunningDuration(startTime)
    local start = M.parseTimestamp(startTime)
    local now = os.time()
    local duration = now - start
    return M.formatDuration(duration)
end

-- Format start time for display
function M.formatStartTime(timestamp)
    local parsed = M.parseTimestamp(timestamp)
    return os.date("%H:%M on %d/%m", parsed)
end

-- Format duration in human readable format
function M.formatDuration(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    
    if hours > 0 then
        return string.format("%dh %dm", hours, minutes)
    else
        return string.format("%dm", minutes)
    end
end
```

## Implementation Strategy

### Phase 1: Core Active Timer Check
1. Integrate `getActiveTimers` call into `startTimer` function
2. Add simple abort logic when active timers are found
3. Create basic active timer information display

### Phase 2: Enhanced User Experience
1. Add duration calculation utilities
2. Improve active timer information formatting
3. Add better timestamp parsing and display

### Phase 3: Advanced Features (Future)
1. Add user choice dialog (stop current, cancel, view details)
2. Implement automatic stop-and-start workflow
3. Add timer switching capabilities

## Technical Details

### API Integration Points
- **Entry Point**: `functions/timer-api.lua` - `startTimer()` function
- **Active Timer Check**: Use existing `timerOperations.getActiveTimers()`
- **Display Logic**: Add new utility functions for formatting timer information

### Error Handling
- Handle API errors gracefully during active timer check
- Provide fallback behavior if active timer check fails
- Ensure original timer start flow works if active timer check is unavailable

### Performance Considerations
- Active timer check adds one additional API call to timer start flow
- Use `perPage: 1` option to minimize data transfer
- Consider caching active timer status for very short periods

## Testing Requirements

- **No Active Timers**: Verify normal timer start flow works unchanged
- **One Active Timer**: Confirm abort behavior and information display
- **Multiple Active Timers**: Handle edge case of multiple concurrent timers
- **API Errors**: Ensure graceful degradation when active timer check fails
- **Duration Calculations**: Test duration formatting across different time ranges
- **Timestamp Parsing**: Verify correct handling of Moneybird timestamp formats

## User Experience Goals

1. **Prevention**: Stop users from accidentally creating multiple timers
2. **Transparency**: Show clear information about currently running timers
3. **Simplicity**: Keep the flow straightforward - check, inform, abort
4. **Consistency**: Maintain existing timer start UX when no conflicts exist

## Context

This enhancement addresses a common user experience issue in time tracking applications where users accidentally start multiple timers. By leveraging the newly fixed `getActiveTimers` functionality with correct API parameter formatting, we can provide a better, more reliable timer management experience.