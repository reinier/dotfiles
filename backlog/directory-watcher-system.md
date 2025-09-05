# Directory Watcher System for Hammerspoon

## Problem Statement

Currently, there is no automated way to move files between directories when they are added to specific watched folders. This leads to:

- Manual file organization tasks that could be automated
- Inconsistent file management across different workflows
- No easy way to set up automatic file routing based on directory monitoring
- Difficulty managing different directory structures across multiple computers when sharing dotfiles

For example, files downloaded to `~/misc/downloads` should automatically be moved to `~/misc/movies`, but this requires manual intervention each time. Additionally, when sharing dotfiles across multiple computers, each machine may have different directory structures, making a one-size-fits-all solution impractical.

## Proposed Solution

### 1. YAML-Based Configuration System

Create a human-readable YAML configuration file that defines directory watchers with computer-specific targeting:

```yaml
watchers:
  - source: "~/misc/downloads"
    target: "~/misc/movies"
    computer: "MacBook-Pro"
    enabled: true
    description: "Auto-move downloads to movies folder"
  
  - source: "/Users/user/temp"
    target: "/Users/user/archive"
    computer: "iMac-Office"
    enabled: true
    description: "Archive temporary files"
    
  - source: "~/Desktop/screenshots"
    target: "~/Pictures/Screenshots"
    computer: "MacBook-Pro"
    enabled: false
    description: "Organize desktop screenshots"
```

### 2. Core Directory Watcher Module

Implement a robust directory monitoring system using Hammerspoon's `hs.pathwatcher`:

```lua
-- hammerspoon/functions/directory-watchers.lua
local M = {}

-- Configuration and state management
local config = {}
local activeWatchers = {}
local currentComputer = nil

-- Load and parse YAML configuration
function M.loadConfig()
    -- Parse YAML file and filter by current computer
    -- Handle path expansion (~, relative paths)
    -- Validate source and target directories
end

-- Create pathwatcher for a single directory
function M.createWatcher(watcherConfig)
    -- Create hs.pathwatcher instance
    -- Handle file/directory addition events
    -- Execute move operations with error handling
end

-- Initialize all watchers
function M.start()
    -- Get current computer identifier
    -- Load configuration
    -- Create and start all applicable watchers
end
```

### 3. MenuHammer Integration

Add a convenient MenuHammer script to help with configuration setup:

```lua
-- In hammerspoon/menus/scripts.lua
{
    text = "Copy Computer Name",
    subText = "Copy the computer identifier needed for directory watcher config",
    fn = function()
        local computerName = hs.host.localizedName()
        hs.pasteboard.setContents(computerName)
        hs.alert.show("Computer name copied: " .. computerName)
    end
}
```

### 4. Multi-Computer Support Architecture

```lua
-- Computer identification and filtering
function M.getCurrentComputer()
    return hs.host.localizedName()
end

function M.filterConfigForCurrentComputer(allWatchers)
    local computerName = M.getCurrentComputer()
    local filtered = {}
    
    for _, watcher in ipairs(allWatchers) do
        if watcher.computer == computerName and (watcher.enabled ~= false) then
            table.insert(filtered, watcher)
        end
    end
    
    return filtered
end
```

## Implementation Strategy

### Phase 1: Core Functionality
1. **YAML Configuration Parser**
   - Create configuration file structure
   - Implement basic YAML parsing (or simple key-value parsing if YAML is complex)
   - Add path expansion utilities (`~` and relative paths)
   - Add configuration validation

2. **Basic Directory Watcher**
   - Implement `hs.pathwatcher` integration
   - Handle file addition events
   - Create move operation with basic error handling
   - Add console logging for debugging

3. **Computer Identification**
   - Use `hs.host.localizedName()` for computer identification
   - Filter configuration by current computer
   - Safe fallback if computer name doesn't match any config

### Phase 2: MenuHammer Integration
1. **Computer Name Script**
   - Add MenuHammer menu item to copy computer name
   - Integrate into existing scripts menu structure
   - Provide clear feedback when name is copied

2. **Configuration Management**
   - Add menu items for reloading watcher configuration
   - Add menu item to show active watchers status
   - Add menu item to temporarily disable/enable all watchers

### Phase 3: Enhanced Features (Future)
1. **Advanced Filtering**
   - File extension filtering (e.g., only move .mp4 files)
   - File size filtering
   - Pattern matching for file names

2. **Recursive Watching**
   - Option to watch subdirectories
   - Maintain directory structure in target

3. **Move Operations Enhancement**
   - Handle file conflicts (duplicate names)
   - Option to copy instead of move
   - Backup/undo functionality

4. **Notification System**
   - Visual notifications when files are moved
   - Summary notifications (X files moved in last hour)
   - Error notifications for failed operations

## Technical Details

### File Structure
```
hammerspoon/
├── directory-watchers-config.yaml          # Configuration file
├── functions/
│   └── directory-watchers.lua              # Main module
├── menus/
│   └── scripts.lua                         # MenuHammer integration
└── init.lua                               # Integration point
```

### API Integration Points
- **Entry Point**: `hammerspoon/init.lua` - Add `require('functions/directory-watchers')`
- **Configuration**: `hammerspoon/directory-watchers-config.yaml` - YAML config file
- **MenuHammer**: `hammerspoon/menus/scripts.lua` - Computer name utility
- **Core Module**: `hammerspoon/functions/directory-watchers.lua` - Main implementation

### Configuration Format Specification
```yaml
watchers:                           # Array of watcher configurations
  - source: "string"               # Required: Source directory path
    target: "string"               # Required: Target directory path  
    computer: "string"             # Required: Computer identifier
    enabled: boolean               # Optional: Defaults to true
    description: "string"          # Optional: Human-readable description
```

### Error Handling Strategy

1. **Configuration Errors**
   - Invalid YAML format: Log error, skip configuration
   - Missing required fields: Log error, skip specific watcher
   - Invalid paths: Log warning, skip specific watcher

2. **Runtime Errors**
   - Source directory doesn't exist: Log warning, skip watcher creation
   - Target directory doesn't exist: Attempt to create, log if fails
   - Permission errors: Log error, notify user
   - Move operation fails: Log error, leave file in source

3. **Graceful Degradation**
   - If configuration file missing: Log info, continue without watchers
   - If no watchers match current computer: Log info, continue without watchers
   - If pathwatcher creation fails: Log error, continue with other watchers

### Performance Considerations

1. **Memory Usage**
   - Each pathwatcher uses system resources
   - Limit number of concurrent watchers
   - Clean up watchers on configuration reload

2. **CPU Usage**
   - Directory scanning is event-driven (efficient)
   - Move operations are batched if multiple files added simultaneously
   - Avoid recursive watching of large directory trees

3. **I/O Considerations**
   - Use atomic move operations when possible
   - Handle large file moves gracefully
   - Add progress feedback for large operations

## Testing Requirements

### Configuration Testing
- **Valid YAML**: Verify correct parsing of well-formed configuration
- **Invalid YAML**: Ensure graceful handling of malformed configuration
- **Missing Fields**: Test behavior when required fields are missing
- **Path Expansion**: Verify `~` and relative path expansion works correctly
- **Computer Filtering**: Confirm only current computer's watchers are loaded

### Core Functionality Testing  
- **File Addition**: Test detection and moving of newly added files
- **Directory Addition**: Test handling of directories added to watched folders
- **Multiple Files**: Test simultaneous addition of multiple files
- **Large Files**: Test move operations with large files
- **Nested Directories**: Test behavior with nested directory structures

### Error Condition Testing
- **Missing Source**: Behavior when source directory doesn't exist
- **Missing Target**: Behavior when target directory doesn't exist or can't be created
- **Permission Errors**: Handling of insufficient permissions for move operations
- **Disk Space**: Behavior when target disk is full
- **File Conflicts**: Handling of duplicate file names in target directory

### Integration Testing
- **Hammerspoon Startup**: Verify watchers start correctly on Hammerspoon launch
- **Configuration Reload**: Test dynamic reloading of configuration changes
- **MenuHammer Integration**: Verify computer name script works correctly
- **Multi-Computer**: Test configuration filtering across different computer names

### Performance Testing
- **Resource Usage**: Monitor memory and CPU usage with multiple active watchers
- **Large Directory**: Test performance with directories containing many files
- **Rapid File Addition**: Test behavior when many files are added quickly
- **Long Running**: Test stability over extended periods

## User Experience Goals

### Simplicity and Ease of Use
1. **Human-Readable Configuration**: YAML format is intuitive and easy to edit
2. **Clear Documentation**: Configuration options are well-documented with examples
3. **Helpful Utilities**: MenuHammer script makes finding computer name effortless
4. **Sensible Defaults**: Minimal configuration required for basic use cases

### Transparency and Control
1. **Visible Logging**: Clear console output showing what actions are being taken
2. **Status Visibility**: Easy way to see which watchers are active
3. **Enable/Disable Control**: Ability to temporarily disable watchers without removing configuration
4. **Error Reporting**: Clear error messages when things go wrong

### Reliability and Safety
1. **Non-Destructive**: Move operations preserve files and can be undone manually
2. **Computer Isolation**: Each computer only processes its own watchers
3. **Graceful Failure**: System continues working even if some watchers fail
4. **Validation**: Configuration is validated before creating watchers

### Maintainability
1. **Version Control Friendly**: YAML configuration works well in git
2. **Shared Configuration**: Same config file works across multiple computers
3. **Easy Updates**: Adding new watchers is straightforward
4. **Clear Structure**: Organized code structure following existing patterns

## Context and Integration

This directory watcher system is designed to integrate seamlessly with your existing Hammerspoon configuration:

- **Follows Existing Patterns**: Uses same `functions/` directory structure as `timer-api.lua`
- **MenuHammer Consistent**: Computer name script follows existing menu item patterns
- **Configuration Management**: YAML config file placed in hammerspoon root like other configs
- **Startup Integration**: Simple `require()` call in `init.lua` like other modules
- **Logging Consistency**: Uses Hammerspoon console for output like existing functions

The system provides automated file management capabilities while maintaining the flexibility and organization principles already established in your dotfiles repository. It addresses the specific need for computer-aware configuration management, making it safe to share this enhancement across multiple machines with different directory structures.

## Future Enhancement Opportunities

1. **Integration with Existing Functions**
   - Combine with timer functionality for time-based move operations
   - Integration with existing secrets management for secure configurations

2. **Advanced Automation**
   - Integration with file type detection
   - Smart target directory selection based on file content
   - Integration with cloud storage sync detection

3. **User Interface Enhancements**
   - MenuHammer submenu for watcher management
   - Real-time status display of active operations
   - Configuration editing interface through Hammerspoon

This comprehensive plan provides a roadmap for implementing a robust, flexible directory watcher system that enhances your automation capabilities while maintaining compatibility with your multi-computer dotfiles setup.