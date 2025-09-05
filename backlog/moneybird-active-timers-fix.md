# Fix Moneybird Active Timers API Parameter Format

## Problem Statement

The current implementation of active timer retrieval in the Hammerspoon timer API is using an incorrect parameter format for the Moneybird API. According to Moneybird support, the `include_active` parameter should be part of the `filter` parameter, not a separate query parameter.

### Current Incorrect Format
```
?include_active=true&filter=period:this_month
```

### Required Correct Format
```
?filter=period:this_month,include_active:true
```

### Custom Date Range Format
For filtering the last 21 days, use Moneybird's custom period format:
```
?filter=period:YYYYMMDD..YYYYMMDD,include_active:true
```

Example for last 21 days:
```
?filter=period:20241204..20241225,include_active:true
```

## Affected Code

- `hammerspoon/functions/timer-api/timer-operations.lua` lines 66-77 in the `debugActiveTimers` function
- Multiple hardcoded URL strings that use the incorrect parameter format

## Proposed Solution

### 1. Fix debugActiveTimers Function
Replace the hardcoded URLs in the `urls` array with properly formatted filter parameters:

- Change: `?include_active=true` 
- To: `?filter=include_active:true`

- Change: `?include_active=true&day=YYYY-MM-DD`
- To: `?filter=include_active:true,period:YYYYMMDD..YYYYMMDD`

Example test cases to add:
- `?filter=include_active:true` (active timers only)
- `?filter=period:this_month,include_active:true` (this month + active)
- `?filter=period:[21_day_range],include_active:true` (last 21 days + active)

### 2. Create Production getActiveTimers Function
Add a new function specifically for retrieving active timers in production:
- Use correct filter parameter format: `?filter=include_active:true`
- Include proper error handling and response parsing
- Return only active timers (those with `started_at` but no `ended_at`)

### 3. API Parameter Utility
Consider creating utility functions to build filter parameters correctly:
```lua
local function buildFilterParam(filters)
    if not filters or #filters == 0 then return "" end
    return "?filter=" .. table.concat(filters, ",")
end

local function getLast21DaysFilter()
    local today = os.date("!%Y%m%d")
    local twentyOneDaysAgo = os.date("!%Y%m%d", os.time() - (21 * 24 * 60 * 60))
    return twentyOneDaysAgo .. ".." .. today
end

-- Usage example:
-- local period = getLast21DaysFilter()  -- "20241204..20241225"
-- local url = buildFilterParam({"period:" .. period, "include_active:true"})
```

## Implementation Strategy

1. **Phase 1**: Fix the existing `debugActiveTimers` function with correct parameter format
2. **Phase 2**: Add production `getActiveTimers` function with proper error handling
3. **Phase 3**: Test with actual API calls to verify the fix works
4. **Phase 4**: Consider refactoring other API calls to use consistent parameter building

## Testing Requirements

- Verify API calls succeed with new parameter format
- Confirm active timers are properly retrieved and identified
- Test edge cases (no active timers, multiple active timers)
- Validate that combined filters work (e.g., `period:this_month,include_active:true`)
- Test custom date range filters with 21-day periods
- Verify that the date range calculation utility works correctly across month boundaries

## Context

This fix addresses a bug report response from Moneybird support regarding the correct usage of their time entries API. The `include_active` parameter must be included within the `filter` parameter according to their API documentation and support team clarification.