-- timer-api.lua - Main orchestrator for modular timer API
local M = {}

-- Import modules
local config = require("functions.timer-api.config")
local apiClient = require("functions.timer-api.api-client")
local userManager = require("functions.timer-api.user-manager")
local uiChoosers = require("functions.timer-api.ui-choosers")
local timerOperations = require("functions.timer-api.timer-operations")

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
        end)
    end)
end

return M