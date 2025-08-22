-- config.lua - Timer API configuration management
local M = {}

-- Public API Functions

function M.resetTimerSettings()
    -- Get all timer-related settings
    local timerKeys = {}
    for _, key in ipairs(hs.settings.getKeys()) do
        if string.match(key, "^timer%.") then
            table.insert(timerKeys, key)
        end
    end
    
    -- Remove all timer settings
    for _, key in ipairs(timerKeys) do
        hs.settings.set(key, nil)
    end
    
    local itemTypes = {}
    local hasUserId = false
    local hasClientCache = false
    local hasProjectCache = false
    local hasUsageCache = false
    local hasDescriptions = false
    local hasApiToken = false
    
    for _, key in ipairs(timerKeys) do
        if key == "timer.userId" then
            hasUserId = true
        elseif key == "timer.cachedClients" then
            hasClientCache = true
        elseif key == "timer.cachedProjects" then
            hasProjectCache = true
        elseif key == "timer.cachedClientUsage" then
            hasUsageCache = true
        elseif key == "timer.lastDescription" or key == "timer.recentDescriptions" then
            hasDescriptions = true
        elseif key == "timer.apiToken" then
            hasApiToken = true
        end
    end
    
    local message = "✅ Timer settings reset! (" .. #timerKeys .. " items cleared)"
    if hasApiToken then message = message .. "\n• API token cleared" end
    if hasUserId then message = message .. "\n• User ID cleared" end
    if hasClientCache then message = message .. "\n• Client cache cleared" end
    if hasProjectCache then message = message .. "\n• Project cache cleared" end
    if hasUsageCache then message = message .. "\n• Usage data cleared" end
    if hasDescriptions then message = message .. "\n• Description history cleared" end
    
    hs.alert.show(message, 4)
end

function M.getApiConfig(callback)
    -- First check if we have stored API token
    local storedToken = hs.settings.get("timer.apiToken")
    if storedToken then
        local config = {API_AUTH_TOKEN = storedToken}
        
        -- Try to get default description from secrets if available
        local secrets = hs.settings.get("secrets")
        if secrets and secrets.moneybird and secrets.moneybird.TIMER_DESCRIPTION then
            config.TIMER_DESCRIPTION = secrets.moneybird.TIMER_DESCRIPTION
        else
            config.TIMER_DESCRIPTION = "Work Timer Entry"
        end
        
        callback(config, nil)
        return
    end
    
    -- If not stored, show token input
    M.showApiTokenInput(function(token, tokenError)
        if tokenError then
            callback(nil, tokenError)
            return
        end
        
        local config = {API_AUTH_TOKEN = token}
        
        -- Try to get default description from secrets if available
        local secrets = hs.settings.get("secrets")
        if secrets and secrets.moneybird and secrets.moneybird.TIMER_DESCRIPTION then
            config.TIMER_DESCRIPTION = secrets.moneybird.TIMER_DESCRIPTION
        else
            config.TIMER_DESCRIPTION = "Work Timer Entry"
        end
        
        callback(config, nil)
    end)
end

-- Private Helper Functions

function M.showApiTokenInput(callback)
    local chooser = hs.chooser.new(function(choice)
        if choice then
            local token = choice.text
            -- Save the API token for future use
            hs.settings.set("timer.apiToken", token)
            callback(token, nil)
        else
            callback(nil, "❌ API token input cancelled")
        end
    end)
    
    chooser:placeholderText("Enter your Moneybird API token...")
    chooser:queryChangedCallback(function(query)
        if query and query ~= "" then
            chooser:choices({{text = query, subText = "API Token"}})
        else
            chooser:choices({})
        end
    end)
    
    chooser:show()
end

-- Constants and Defaults

M.DEFAULT_TIMER_DESCRIPTION = "Work Timer Entry"

return M