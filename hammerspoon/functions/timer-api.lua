-- timer-api.lua - Main orchestrator for modular timer API
local M = {}

-- Import modules
local config = require("functions.timer-api.config")
local apiClient = require("functions.timer-api.api-client")
local userManager = require("functions.timer-api.user-manager")
local uiChoosers = require("functions.timer-api.ui-choosers")
local timerOperations = require("functions.timer-api.timer-operations")
local utils = require("functions.timer-api.utils")

-- Private helper functions

function M.handleActiveTimerFound(activeTimer, apiConfig, adminId, callback)
    -- Show interactive chooser for timer actions
    uiChoosers.showTimerActionChooser(activeTimer, function(action, actionError)
        if actionError then
            callback(nil, actionError)
            return
        end
        
        -- Handle the selected action
        if action == "stop_and_start" then
            M.stopAndStartNewTimer(apiConfig, adminId, activeTimer, callback)
        elseif action == "stop_only" then
            M.stopTimerOnly(apiConfig, adminId, activeTimer, callback)
        elseif action == "view_details" then
            -- Show detailed timer information
            local startTime = activeTimer.started_at or "Unknown"
            local description = activeTimer.description or "No description"
            local duration = timerOperations.calculateRunningDuration(startTime)
            local startTimeFormatted = timerOperations.formatStartTime(startTime)
            
            local detailMessage = string.format(
                "⏱️ Timer Details\n\n" ..
                "Description: %s\n" ..
                "Started: %s\n" ..
                "Duration: %s\n" ..
                "Timer ID: %s",
                description,
                startTimeFormatted,
                duration,
                activeTimer.id or "Unknown"
            )
            
            callback(nil, detailMessage)
        elseif action == "cancel" then
            -- Just return with a cancel message
            callback(nil, "Timer start cancelled. Current timer continues running.")
        else
            callback(nil, "❌ Unknown action selected")
        end
    end)
end

function M.proceedWithTimerStart(apiConfig, adminId, callback)
    -- Get/set user ID first (will show chooser if needed)
    userManager.getUserId(apiConfig, adminId, function(userId, userError)
        if userError then
            callback(nil, userError)
            return
        end
        
        -- Debug logging
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        print(string.format("[%s] Moneybird Timer: Using user ID %s for timer operations", timestamp, tostring(userId)))
        
        -- NOW: Check for active timers AFTER user selection (with proper user context)
        timerOperations.getActiveTimers(apiConfig, adminId, {perPage = 1}, function(activeTimers, activeError)
            -- If active timer check fails, proceed with normal flow (graceful degradation)
            if activeError then
                local timestamp = os.date("%Y-%m-%d %H:%M:%S")
                print(string.format("[%s] Moneybird Timer Warning: Active timer check failed, proceeding with timer start: %s", timestamp, activeError))
            else
                -- If active timers found, show interactive chooser
                if activeTimers and #activeTimers > 0 then
                    M.handleActiveTimerFound(activeTimers[1], apiConfig, adminId, callback)
                    return
                end
            end
            
            -- No active timers (or check failed) - proceed with normal timer creation
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
    end)
end

function M.stopAndStartNewTimer(apiConfig, adminId, activeTimer, callback)
    -- Stop the current timer first
    timerOperations.stopTimer(apiConfig, adminId, activeTimer.id, function(stoppedTimer, stopError)
        if stopError then
            callback(nil, stopError)
            return
        end
        
        -- Debug logging
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        print(string.format("[%s] Moneybird Timer: Timer stopped, proceeding with new timer creation", timestamp))
        
        -- Proceed with normal timer creation flow
        M.proceedWithTimerStart(apiConfig, adminId, callback)
    end)
end

function M.stopTimerOnly(apiConfig, adminId, activeTimer, callback)
    -- Stop the timer and complete
    timerOperations.stopTimer(apiConfig, adminId, activeTimer.id, function(stoppedTimer, stopError)
        if stopError then
            callback(nil, stopError)
            return
        end
        
        local duration = timerOperations.calculateRunningDuration(activeTimer.started_at)
        local successMsg = string.format("✅ Timer stopped!\n\nDescription: %s\nDuration: %s", 
            activeTimer.description or "No description", 
            duration)
        
        callback(stoppedTimer, successMsg)
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
            
            -- Proceed with timer start flow (active timer check now happens after user selection)
            M.proceedWithTimerStart(apiConfig, adminId, callback)
        end)
    end)
end

return M