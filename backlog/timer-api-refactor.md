# Timer API Refactoring Plan

**Status**: Planned  
**Priority**: Medium  
**Estimated Effort**: 2-3 hours  
**Created**: 2025-08-22  
**Last Updated**: 2025-08-22

## Recent Changes

**2025-08-22**: Fixed callback scoping bug in `startTimer()` function (lines 713-774). The issue was that `config` variable was being used outside the `getApiConfig()` callback scope, causing "attempt to index a nil value" error. All timer logic was moved inside the callback, creating even deeper nesting (now 6 levels deep in some areas). This fix actually **reinforces** the need for the planned refactoring by demonstrating how callback complexity has grown unwieldy.

## Problem Statement

The current `hammerspoon/functions/timer-api.lua` file is a 776-line monolith that handles all timer-related functionality. While it works correctly, it's difficult to read, understand, and maintain due to:

- Mixed concerns (API calls, UI, caching, settings)
- Long functions with deeply nested callbacks
- No clear separation between public and private interfaces
- Difficult to test individual components

## Current Structure Analysis

### Functional Areas Identified:
1. **User Management** (lines 3-89): User fetching, selection, storage
2. **Settings Management** (lines 92-202): API tokens, configuration, reset functionality  
3. **API Core Functions** (lines 204-234): Base API utilities, admin ID retrieval
4. **Data Fetching & Caching** (lines 236-379): Projects, clients, usage data with caching
5. **UI Choosers** (lines 373-625): Client, project, description selection interfaces
6. **Timer Operations** (lines 543-589): Time entry creation
7. **Public Interface** (lines 628-776): Main exported functions

## Proposed Modular Structure

```
hammerspoon/functions/
├── timer-api.lua              # Main orchestrator (public interface)
└── timer-api/
    ├── config.lua             # Settings & API token management
    ├── api-client.lua         # HTTP requests & base API calls
    ├── cache.lua              # Data caching with TTL
    ├── user-manager.lua       # User selection & storage
    ├── ui-choosers.lua        # Client/project/description choosers
    └── timer-operations.lua   # Timer CRUD operations
```

### Module Responsibilities

**config.lua** (~120 lines):
- `getApiConfig()` - retrieve/prompt for API configuration
- `showApiTokenInput()` - API token input UI
- `resetTimerSettings()` - clear all timer settings
- Constants and default values

**api-client.lua** (~100 lines):
- `makeAPIRequest()` - generic HTTP wrapper
- `getAdministrationId()` - get admin ID from API
- `getCurrentUTCTimestamp()` - timestamp utility
- Base API communication patterns

**cache.lua** (~150 lines):
- `getProjects()` - fetch/cache projects with TTL
- `getClients()` - fetch/cache clients with TTL  
- `getRecentClientUsage()` - fetch/cache usage statistics
- Cache management utilities

**user-manager.lua** (~120 lines):
- `getAllUsers()` - fetch users from API
- `showUserChooser()` - user selection UI
- `getUserId()` - get stored or prompt for user ID
- User preference storage

**ui-choosers.lua** (~180 lines):
- `showClientChooser()` - client selection with usage sorting
- `showProjectChooser()` - project selection interface
- `showDescriptionInput()` - description input with history
- Common chooser utilities

**timer-operations.lua** (~100 lines):
- `createTimeEntry()` - create new timer entry
- `debugActiveTimers()` - debugging functionality
- Timer-specific business logic

**timer-api.lua** (~80 lines):
- `M.startTimer()` - main public interface
- `M.resetTimerSettings()` - public reset function
- `M.debugActiveTimers()` - public debug function
- Module orchestration

## Implementation Strategy

### Phase 1: Setup & Foundation
1. Create `timer-api/` directory structure
2. Create `config.lua` module (settings & API token management)
3. Create `api-client.lua` module (base HTTP functionality)
4. Test basic configuration loading

### Phase 2: Data Layer
1. Create `cache.lua` module (projects, clients, usage caching)
2. Create `user-manager.lua` module (user selection & storage)
3. Test data fetching and caching functionality

### Phase 3: UI Layer  
1. Create `ui-choosers.lua` module (all chooser interfaces)
2. Create `timer-operations.lua` module (timer CRUD)
3. Test individual UI components

### Phase 4: Integration
1. Refactor main `timer-api.lua` to orchestrate modules
2. Update all require statements and dependencies
3. Comprehensive testing of full workflow
4. Remove old monolithic code

## Key Design Principles

### 1. Clear Separation of Concerns
- Each module has single, well-defined responsibility
- Minimal cross-module dependencies
- Clear public/private interface boundaries

### 2. Consistent Code Organization
- **Public API first** - exported functions at top of each module
- **Private helpers second** - internal functions below
- **Constants/config** - module-level configuration
- **Consistent naming** - descriptive, intention-revealing names

### 3. Improved Error Handling
- Consistent callback patterns: `(result, error)`
- Centralized error message formatting
- Clear error propagation through call chains

### 4. Better Testability
- Dependency injection where appropriate
- Smaller, focused functions easier to test
- Clear module boundaries enable unit testing

### 5. Maintained Backwards Compatibility
- All existing public functions remain unchanged
- Same callback signatures and behavior
- No breaking changes to consumers

## Benefits

### Immediate Benefits:
- **Readability**: Smaller files, focused responsibilities
- **Maintainability**: Easier to locate and modify specific functionality
- **Debugging**: Clear module boundaries make issue isolation simpler
- **Code Review**: Smaller changesets, focused context

### Long-term Benefits:
- **Extensibility**: Easy to add new features in appropriate modules
- **Testability**: Individual modules can be unit tested
- **Reusability**: Modules can potentially be used in other contexts
- **Documentation**: Each module can have focused documentation

## Testing Strategy

1. **Preserve Original**: Keep `timer-api.lua.backup` during development
2. **Incremental Testing**: Test each module as it's created
3. **Integration Testing**: Full workflow testing after integration
4. **Regression Testing**: Ensure all existing features work identically

## Success Criteria

- [ ] All existing functionality preserved
- [ ] No breaking changes to public API
- [ ] Each module < 200 lines
- [ ] Clear, descriptive function names throughout
- [ ] Consistent error handling patterns
- [ ] Comprehensive testing completed
- [ ] Documentation updated

## Future Enhancements (Enabled by Refactoring)

- Unit tests for individual modules
- Enhanced caching strategies
- Additional timer operations (stop, edit, list active)
- Better error handling and user feedback
- Configuration validation
- API rate limiting