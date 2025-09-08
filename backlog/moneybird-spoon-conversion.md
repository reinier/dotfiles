---
status: todo
date_created: 2025-09-08
date_modified: 2025-09-08
---

# Moneybird Spoon Conversion

## Problem Statement

The Moneybird timer functionality is currently implemented as a collection of modular Lua files within the `functions/timer-api/` directory. While this provides good organization, it lacks the portability and standardization benefits of a proper Hammerspoon Spoon. The current implementation:

- Is tightly coupled to the dotfiles repository structure
- Requires manual require path management
- Cannot be easily shared or installed independently
- Lacks the standard Spoon lifecycle and configuration patterns

## Current Architecture

### File Structure
```
hammerspoon/
├── functions/
│   ├── timer-api.lua                    # Main orchestrator
│   └── timer-api/
│       ├── config.lua                   # Configuration and settings management
│       ├── api-client.lua               # HTTP client and base API utilities
│       ├── user-manager.lua             # User selection and storage
│       ├── cache.lua                    # Data caching with TTL for projects/clients
│       ├── ui-choosers.lua              # Chooser interfaces for clients/projects/descriptions
│       └── timer-operations.lua         # Core timer business logic
└── menus/
    └── scripts.lua                      # MenuHammer integration (lines 6, 34-60)
```

### Integration Points
- **MenuHammer Actions**: Start Timer (T), Reset Settings (R), Debug Timers (D)
- **Main API**: `functions/timer-api.lua` provides backward-compatible interface
- **Settings Storage**: Uses `hs.settings` with "timer." prefix for persistence

### Key Features
- **Complete Timer Workflow**: Client → Project → Description → Time Entry Creation
- **Smart Caching**: TTL-based caching for clients/projects with usage tracking
- **User Management**: Persistent user selection with chooser interface
- **Configuration Management**: API token storage and configuration handling
- **Recent Usage Tracking**: Smart sorting by recent client usage and description history
- **Debug Capabilities**: Comprehensive API debugging tools

## Proposed Solution

Convert the existing modular timer functionality into a proper `Moneybird.spoon` package following Hammerspoon Spoon conventions.

### Target Architecture
```
hammerspoon/Spoons/Moneybird.spoon/
├── init.lua                            # Main spoon interface with metadata
├── lib/
│   ├── config.lua                      # Configuration management (adapted)
│   ├── api-client.lua                  # HTTP client utilities (adapted)
│   ├── user-manager.lua                # User selection logic (adapted)
│   ├── cache.lua                       # Data caching system (adapted)
│   ├── ui-choosers.lua                 # User interface components (adapted)
│   └── timer-operations.lua            # Core business logic (adapted)
└── docs.json                           # API documentation (optional)
```

## Implementation Plan

### Phase 1: Research and Design
1. **Study Existing Spoons**: Analyze MenuHammer.spoon and other spoons for patterns
   - Understand spoon metadata requirements (`name`, `version`, `author`, etc.)
   - Review standard spoon lifecycle methods (`init()`, `start()`, `stop()`)
   - Study spoon configuration patterns and settings management

2. **Design Spoon API**: Define clean public interface
   - `Moneybird:start()` - Initialize the spoon
   - `Moneybird:startTimer(callback)` - Main timer creation workflow
   - `Moneybird:debugActiveTimers(callback)` - Debug functionality
   - `Moneybird:resetSettings()` - Clear cached settings
   - `Moneybird:bindHotkeys(mapping)` - Standard spoon hotkey binding

### Phase 2: Core Migration
3. **Create Spoon Structure**: Set up proper directory and metadata
   ```lua
   -- init.lua structure
   local obj = {}
   obj.__index = obj
   obj.name = "Moneybird"
   obj.version = "1.0"
   obj.author = "Your Name"
   obj.license = "MIT"
   ```

4. **Migrate Core Modules**: Move existing functionality to spoon lib directory
   - Update all internal require paths to use relative spoon paths
   - Maintain existing functionality without breaking changes
   - Preserve all current features (caching, UI choosers, API operations)

5. **Create Public API**: Design clean interface that wraps existing functionality
   - Maintain backward compatibility with current `timer-api.lua` interface
   - Add standard spoon methods and lifecycle hooks
   - Implement configuration through spoon settings pattern

### Phase 3: Integration and Testing
6. **Update MenuHammer Integration**: Modify `menus/scripts.lua`
   - Change from `require('functions.timer-api')` to spoon usage pattern
   - Test all menu actions (Start Timer, Reset Settings, Debug Timers)
   - Ensure no functionality regression

7. **Create Migration Path**: Handle transition from old to new system
   - Preserve existing settings and cached data
   - Provide deprecation notices for old require paths
   - Document migration steps for users

### Phase 4: Enhancement and Documentation
8. **Add Spoon Documentation**: Create comprehensive API docs
   - Document all public methods with parameters and return values
   - Provide configuration examples and usage patterns
   - Include installation and setup instructions

9. **Enhance Configurability**: Leverage spoon configuration patterns
   - Move hardcoded defaults to configurable spoon variables
   - Add customizable hotkey bindings support
   - Implement spoon-standard configuration management

## Benefits

### Immediate Benefits
- **Standardization**: Follows Hammerspoon Spoon conventions and patterns
- **Portability**: Easy to share, install, and distribute independently
- **Encapsulation**: Clean separation from dotfiles-specific configuration
- **Reusability**: Others can easily adopt the Moneybird functionality

### Long-term Benefits
- **Maintainability**: Standard structure makes code easier to understand and maintain
- **Extensibility**: Spoon pattern makes it easier to add new features and integrations
- **Community**: Potential for community contributions and improvements
- **Documentation**: Standard spoon docs make usage and configuration clearer

## Risk Assessment

### Low Risk
- **Existing functionality**: All current features will be preserved
- **Backward compatibility**: Can maintain existing MenuHammer integration
- **Settings preservation**: Existing cached data and settings can be migrated

### Medium Risk
- **Require path changes**: Internal modules will need updated import paths
- **Testing complexity**: Need to verify all workflows continue working properly

### Mitigation Strategies
- **Gradual migration**: Keep old system working during transition
- **Comprehensive testing**: Test all MenuHammer menu actions and workflows
- **Rollback plan**: Maintain ability to revert to current implementation if needed

## Success Criteria

1. **Functional Parity**: All existing timer functionality works identically
2. **MenuHammer Integration**: All menu actions continue to work without changes
3. **Clean API**: Spoon provides intuitive public interface following conventions
4. **Proper Documentation**: Clear installation, configuration, and usage instructions
5. **Settings Migration**: Existing user settings and cached data are preserved
6. **Spoon Standards**: Follows all Hammerspoon Spoon conventions and patterns

## Timeline Estimate

- **Phase 1-2**: 4-6 hours (Research, design, core migration)
- **Phase 3**: 2-3 hours (Integration updates and testing)
- **Phase 4**: 2-4 hours (Documentation and enhancement)
- **Total**: 8-13 hours of development time

## Future Enhancements

Once converted to a spoon, additional features become easier to implement:
- **Hotkey customization**: User-configurable hotkeys for common actions
- **Multiple administrations**: Support for multiple Moneybird accounts
- **Time tracking**: Built-in timer display and management
- **Reporting**: Time entry summaries and reporting features
- **Integration plugins**: Extensions for other productivity tools