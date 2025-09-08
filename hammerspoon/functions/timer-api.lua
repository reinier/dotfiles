-- timer-api.lua - Main orchestrator for modular timer API
local M = {}

-- Import modules
local config = require("functions.timer-api.config")
local apiClient = require("functions.timer-api.api-client")
local userManager = require("functions.timer-api.user-manager")
local uiChoosers = require("functions.timer-api.ui-choosers")
local timerOperations = require("functions.timer-api.timer-operations")

-- Private helper functions

function M.handleActiveTimerFound(activeTimer, callback)
    local startTime = activeTimer.started_at or "Unknown"
    local description = activeTimer.description or "No description"
    local duration = timerOperations.calculateRunningDuration(startTime)
    
    local message = string.format(
        "⏱️ Timer already running!\n\n" ..
        "Description: %s\n" ..
        "Started: %s\n" ..
        "Duration: %s\n\n" ..
        "Stop the current timer before starting a new one.",
        description,
        timerOperations.formatStartTime(startTime),
        duration
    )
    
    -- Only show the message via callback - MenuHammer will display it
    callback(nil, message)
end

function M.proceedWithTimerStart(apiConfig, adminId, callback)
    -- Get/set user ID first (will show chooser if needed)
    userManager.getUserId(apiConfig, adminId, function(userId, userError)
        if userError then
            callback(nil, userError)
            return
        end
        
        -- Don't show loading message here - getClients will show appropriate message
        
        uiChoosers.showClientChooser(apiConfig, adminId, function(clientId, clientError)
            if clientError then
                callback(nil, clientError)
                return
            end
            
            -- Don't show loading message here - getProjects will show appropriate message
            
            uiChoosers.showProjectChooser(apiConfig, adminId, function(projectId, projectError)
                if projectError then
                    callback(nil, projectError)
                    return
                end
                
                uiChoosers.showDescriptionInput(function(description, descriptionError)
                    if descriptionError then
                        callback(nil, descriptionError)
                        return
                    end
                    
                    timerOperations.createTimeEntry(apiConfig, adminId, projectId, clientId, description, function(timeEntry, entryError)
                        if entryError then
                            callback(nil, entryError)
                            return
                        end
                        
                        local successMsg = "✅ Timer started!"
                        callback(timeEntry, successMsg)
                    end)
                end)
            end)
        end)
    end)
end

-- Public API Functions (maintain backward compatibility)

function M.resetTimerSettings()
    config.resetTimerSettings()
end

function M.debugActiveTimers(callback)
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
            
            timerOperations.debugActiveTimers(apiConfig, adminId, callback)
        end)
    end)
end

function M.startTimer(callback)
    config.getApiConfig(function(apiConfig, configError)
        if configError then
            callback(nil, configError)
            return
        end
        
        -- Check if we have user ID stored, if not show user chooser first
        local storedUserId = hs.settings.get("timer.userId")
        if not storedUserId then
            hs.alert.show("ℹ️ Select your user account", 2)
        end
        
        apiClient.getAdministrationId(apiConfig, function(adminId, adminError)
            if adminError then
                callback(nil, adminError)
                return
            end
            
            -- NEW: Check for active timers first
            timerOperations.getActiveTimers(apiConfig, adminId, {perPage = 1}, function(activeTimers, activeError)
                -- If active timer check fails, proceed with normal flow (graceful degradation)
                if activeError then
                    print("Warning: Active timer check failed, proceeding with timer start:", activeError)
                    M.proceedWithTimerStart(apiConfig, adminId, callback)
                    return
                end
                
                -- If active timers found, abort and show info
                if activeTimers and #activeTimers > 0 then
                    M.handleActiveTimerFound(activeTimers[1], callback)
                    return
                end
                
                -- No active timers - proceed with normal timer start flow
                M.proceedWithTimerStart(apiConfig, adminId, callback)
            end)
        end)
    end)
end

return M