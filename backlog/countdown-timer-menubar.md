---
status: in progress
date_created: 2025-10-27
date_modified: 2025-10-28
---

# Countdown Timer with Menu Bar Display

## Problem Statement

Users need a simple, visible countdown timer for time-boxing tasks, meetings, and focused work sessions (similar to a pomodoro timer). Currently, there's no easy way to track elapsed time visually without switching away from active work.

**Current Limitations:**
- No countdown timer functionality in the Hammerspoon setup
- No visual timer display in the menu bar
- Existing timer-api.lua is for Moneybird project time tracking (different use case)
- No quick way to set and monitor a simple countdown

## Proposed Solution

Create a standalone countdown timer module that displays remaining time in the macOS menu bar, with simple minute-based input via Hammerspoon's native dialog.

Key improvements:
1. **Menu Bar Integration**: Visible countdown display using `hs.menubar` API
2. **Chooser Interface**: Hammerspoon chooser showing history of last 10 durations + custom input
3. **History Management**: Persistent storage of recent timer durations for quick access
4. **Visual Feedback**: Timer updates every second in menu bar (MM:SS format)
5. **Visual Alert**: Silent notification when timer completes
6. **Timer Controls**: Start, pause, resume, cancel functionality

## Technical Architecture

### Countdown Timer Module (`functions/countdown-timer.lua`)

The module will provide a clean API for timer management:

```lua
local M = {}
local menubarItem = nil
local timerObject = nil
local remainingSeconds = 0
local isPaused = false

-- Public API
function M.startTimer(minutes)
  -- Initialize and start countdown
end

function M.pauseTimer()
  -- Pause active countdown
end

function M.resumeTimer()
  -- Resume paused countdown
end

function M.cancelTimer()
  -- Stop and clear timer
end

function M.getStatus()
  -- Return current timer state
end

return M
```

### Menu Bar Display

- **Format**: `⏱ MM:SS` (e.g., `⏱ 25:00`, `⏱ 04:32`)
- **Click Actions**: Right-click menu with Pause/Resume/Cancel options
- **Color Coding** (future): Change color when < 5 minutes remaining
- **Cleanup**: Remove from menu bar when timer completes or is cancelled

### User Interface Flow

```
User: F19 → Scripts → Start Countdown Timer
  ↓
System: Shows chooser with recent durations + "Custom duration..."
  ↓
User: Selects from history (e.g., "25 minutes") OR chooses "Custom duration..."
  ↓
If Custom: Shows input dialog "Enter minutes:"
  ↓
System:
  - Creates menu bar item showing "⏱ 25:00"
  - Updates every second
  - Adds duration to history
  - Shows notification when complete
```

## Implementation Strategy

### Phase 1: Core Timer Functionality
1. **Create countdown-timer.lua module**
   - Basic timer state management
   - Minute-to-seconds conversion
   - Countdown logic with `hs.timer.doEvery()`

2. **Implement menu bar display**
   - Use `hs.menubar.new()` to create menu item
   - Format time as MM:SS
   - Update display every second
   - Remove from menu bar when done

3. **Add chooser interface with history**
   - Use `hs.chooser` to show recent durations
   - Load history from `hs.settings` (last 10 used durations)
   - Add "Custom duration..." option for new values
   - Use `hs.dialog.textPrompt()` for custom input
   - Validate input (positive integers only)
   - Handle cancel/empty input gracefully
   - Save selected/entered duration to history

4. **Implement completion notification**
   - Use `hs.notify.new()` for silent completion alert
   - Flash menu bar or show alert
   - No sound (intentionally silent for non-disruptive notification)

### Phase 2: Enhanced Controls
5. **Add menu bar click actions**
   - Right-click menu with:
     - Pause/Resume option
     - Cancel timer option
     - Show remaining time (if not visible)

6. **Implement pause/resume functionality**
   - Pause countdown and timer updates
   - Visual indicator in menu bar (e.g., `⏸ 15:30`)
   - Resume from paused state

7. **Add keyboard shortcuts** (optional)
   - Quick pause/resume via hotkey
   - Cancel timer via hotkey

### Phase 3: MenuHammer Integration
8. **Add to scripts menu**
   - Entry: `F19 → Scripts → N` (or appropriate key)
   - Label: "Start Countdown Timer"
   - Function call to `countdownTimer.startTimer()`

9. **Add timer management entries**
   - Pause/Resume entry (only visible when timer active)
   - Cancel timer entry (only visible when timer active)
   - Show timer status entry

## Error Handling Strategy

### Invalid Input
- **Problem**: User enters non-numeric or negative values
- **Solution**: Show error dialog and re-prompt
- **Fallback**: Allow cancellation to exit flow

### Multiple Timers
- **Problem**: User tries to start timer while one is running
- **Solution**: Show dialog asking to cancel current timer or abort
- **Fallback**: Default to keeping current timer

### Timer Failure
- **Problem**: hs.timer fails or stops unexpectedly
- **Solution**: Log error, show notification, clean up menu bar
- **Fallback**: Allow user to restart

## User Experience Enhancements

### Completion Alert
- **Description**: Visual alert when timer reaches 00:00
- **Benefit**: Non-disruptive notification that user can notice when ready
- **Implementation**:
  - Silent system notification (no sound)
  - Menu bar flash/animation
  - Optional: Keep "⏱ 00:00" visible briefly before removing

### Quick Presets (Future)
- **Description**: Common timer durations (5, 15, 25, 45 minutes)
- **Benefit**: Faster timer starts for common use cases
- **Implementation**: Chooser menu with preset options + custom entry

### Timer History (Future)
- **Description**: Track completed timers and durations
- **Benefit**: Understand time usage patterns
- **Implementation**: Log to file, show summary via menu

## Testing Strategy

### Manual Testing in Hammerspoon Console
Since standalone Lua runtime is not available, all testing must be done through Hammerspoon:

1. **Basic Countdown**
   - Start timer with various minute values (1, 5, 25)
   - Verify menu bar updates every second
   - Confirm timer completes and notifies correctly

2. **Edge Cases**
   - Zero minutes input
   - Very large values (> 60 minutes)
   - Invalid input (letters, negative numbers, empty)
   - Rapid start/cancel cycles

3. **Pause/Resume**
   - Pause mid-countdown, verify timer stops
   - Resume, verify countdown continues from paused time
   - Multiple pause/resume cycles

4. **Cleanup**
   - Cancel timer, verify menu bar item removed
   - Complete timer, verify menu bar item removed
   - Hammerspoon reload with active timer (graceful handling)

### Integration Testing
- Test from MenuHammer (F19 → Scripts → N)
- Verify no conflicts with existing timer-api.lua (Moneybird tracking)
- Test alongside other active menu bar items

## Migration Path

### Backward Compatibility
- **No conflicts**: This is a new feature, completely separate from existing Moneybird timer system
- **Independent module**: Can be enabled/disabled independently
- **No settings migration**: Fresh implementation

## Future Enhancements

### Potential Extensions
- **Pomodoro Mode**: Automatic work/break cycles (25/5 minutes)
- **Timer Presets**: Save and name common timer configurations
- **Statistics**: Track completed timers, total focus time
- **Multiple Timers**: Run concurrent countdown timers with labels
- **Countdown Sounds**: Optional ticking sound or ambient noise
- **Custom Alerts**: Different sounds/notifications for different timer types
- **Integration**: Link with Moneybird timer (start countdown when project timer starts)

## Technical Considerations

### Performance
- **Update Frequency**: 1-second intervals is standard and performant
- **Menu Bar Overhead**: Minimal, text-only display
- **Cleanup**: Ensure timer stops and menu item removed on completion

### Memory Management
- **Timer Cleanup**: Stop and nil timer objects when done
- **Menu Bar Cleanup**: Remove menu bar item reference
- **No Leaks**: Proper cleanup on cancel/completion/reload

### Hammerspoon API Usage
- **`hs.menubar.new()`**: Create menu bar item
- **`hs.menubar:setTitle()`**: Update displayed text
- **`hs.menubar:setMenu()`**: Add right-click actions
- **`hs.menubar:delete()`**: Remove from menu bar
- **`hs.timer.doEvery()`**: Update countdown every second
- **`hs.timer:stop()`**: Pause/cancel timer
- **`hs.dialog.textPrompt()`**: Get minute input
- **`hs.notify.new()`**: Show completion notification

## Success Metrics

### Functionality Goals
- Timer starts within 2 seconds of user input
- Menu bar updates reliably every second
- Zero dropped updates or display glitches
- Clean removal from menu bar on completion/cancel

### User Experience Goals
- < 5 seconds from F19 to timer running (including input)
- Clear, readable menu bar display
- Non-disruptive visual notification on completion
- Intuitive pause/resume/cancel controls

### Maintainability Goals
- < 200 lines of code for core functionality
- Clear separation from existing timer-api.lua
- Easy to extend with new features
- Well-documented API for future enhancements

## Code Organization

### File Structure
```
hammerspoon/functions/countdown-timer.lua     # Main module
hammerspoon/menus/scripts.lua                 # Add menu entry
```

### Integration Point
Update `menus/scripts.lua` to include:
```lua
local countdownTimer = require('functions.countdown-timer')

{cons.cat.action, '', 'N', "Start Countdown Timer", {
    {cons.act.func, function()
        countdownTimer.promptAndStart()
    end }
}}
```

## Implementation Notes

### Design Decisions
- **Simple Input**: Text input is faster than chooser for known values
- **Minute-Based**: Most use cases are whole minutes (5, 15, 25, etc.)
- **Always Visible**: Menu bar ensures timer is never "forgotten"
- **No Persistence**: Timer resets on Hammerspoon reload (intentional simplicity)

### User Workflow Example
```
1. User: F19 → Scripts → N
2. Dialog: "Enter timer duration in minutes:"
3. User types: "25"
4. Menu bar shows: ⏱ 25:00
5. Timer counts down: ⏱ 24:59, ⏱ 24:58, ...
6. At 00:00: Silent notification + Brief flash
7. Menu bar item removed
```

This feature complements the existing Moneybird time tracking system by providing a simple, visual countdown for time-boxing work, completely independent of project/client tracking.

## Implementation Status

### Completed Features ✅
- **Core countdown functionality** - Timer state management and countdown logic
- **Menu bar display** - Real-time MM:SS format with pause indicator
- **Chooser interface** - Shows history of last 10 durations
- **History management** - Persistent storage using `hs.settings`
- **Custom input** - Text prompt for entering new durations
- **Pause/resume** - Right-click menu bar controls
- **Cancel timer** - Clean resource management
- **Mac native notification** - Silent, persistent notification on completion
- **MenuHammer integration** - F19 → Scripts → N

### Implementation Details

**Chooser Interface:**
```
25 minutes          ⏱ 25:00
15 minutes          ⏱ 15:00
5 minutes           ⏱ 05:00
────────────────
Custom duration...  Enter a custom timer duration
```

**History Management:**
- Stored in Hammerspoon settings: `countdownTimerHistory`
- Maximum 10 items (oldest removed when limit reached)
- Deduplicates: selecting existing duration moves it to top
- Persists across Hammerspoon restarts

**User Workflow:**
1. F19 → Scripts → N
2. Chooser appears with recent durations
3. Select from history or choose "Custom duration..."
4. If custom: Enter minutes in dialog
5. Timer starts, shows in menu bar
6. Duration added to history for future use

### Testing Checklist
- [ ] Chooser displays on F19 → Scripts → N
- [ ] First use shows only "Custom duration..." option
- [ ] Custom input dialog appears when selected
- [ ] Timer starts and displays in menu bar
- [ ] Duration appears in history on next use
- [ ] Selecting history item starts timer immediately
- [ ] History limited to 10 items
- [ ] Duplicate selections move item to top
- [ ] History persists after Hammerspoon reload
- [ ] Pause/resume/cancel work from menu bar
- [ ] Silent notification on completion
