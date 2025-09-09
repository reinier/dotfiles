-- utils.lua - Timer API utility functions
local M = {}

-- Error logging utility that both shows alert and logs to console
function M.logError(message, alertDuration)
    alertDuration = alertDuration or 5
    
    -- Log to Hammerspoon console with timestamp
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    print(string.format("[%s] Moneybird Timer Error: %s", timestamp, message))
    
    -- Also show the alert (existing behavior)
    hs.alert.show(message, alertDuration)
end

-- Success logging utility (optional - for consistency)
function M.logSuccess(message, alertDuration)
    alertDuration = alertDuration or 3
    
    -- Log to Hammerspoon console with timestamp
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    print(string.format("[%s] Moneybird Timer Success: %s", timestamp, message))
    
    -- Also show the alert (existing behavior)
    hs.alert.show(message, alertDuration)
end

return M