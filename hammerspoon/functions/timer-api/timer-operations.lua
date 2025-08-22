-- timer-operations.lua - Timer business logic and operations
local M = {}

-- Dependencies 
local apiClient = require("functions.timer-api.api-client")
local userManager = require("functions.timer-api.user-manager")

-- Public API Functions

function M.createTimeEntry(config, adminId, projectId, clientId, description, callback)
    userManager.getUserId(config, adminId, function(userId, userError)
        if userError then
            callback(nil, userError)
            return
        end
        
        local headers = {
            ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
            ["Content-Type"] = "application/json",
            ["Accept"] = "application/json"
        }
        
        local timeEntry = {
            time_entry = {
                description = description,
                contact_id = tostring(clientId),
                project_id = tostring(projectId),
                user_id = tostring(userId),
                started_at = apiClient.getCurrentUTCTimestamp(),
                billable = true
            }
        }
        
        local url = "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json"
        local body = hs.json.encode(timeEntry)
        
        hs.http.doAsyncRequest(url, "POST", body, headers, function(status, responseBody, responseHeaders)
            if status ~= 201 and status ~= 200 then
                local errorMsg = "❌ Failed to create time entry. Status: " .. status
                if responseBody then
                    errorMsg = errorMsg .. "\n" .. responseBody
                end
                callback(nil, errorMsg)
                return
            end
            
            local success, response = pcall(hs.json.decode, responseBody)
            if not success or not response then
                callback(nil, "❌ Invalid response from time entry creation")
                return
            end
            
            callback(response, nil)
        end)
    end)
end

function M.debugActiveTimers(config, adminId, callback)
    hs.alert.show("ℹ️ Fetching active timers for debugging...", 2)
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    -- Try different URL parameter approaches
    local urls = {
        -- Basic without filters
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json",
        -- With include_active only
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?include_active=true",
        -- With different date formats
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?include_active=true&day=" .. os.date("!%Y-%m-%d"),
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?include_active=true&day=" .. os.date("!%Y%m%d"),
        -- With limit to reduce results
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?include_active=true&per_page=10",
    }
    
    local function testUrl(index)
        if index > #urls then
            callback(nil, "All URL tests completed - check console")
            return
        end
        
        local url = urls[index]
        
        print("\n=== TESTING URL " .. index .. " ===")
        print("URL:", url)
        
        hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
            print("Status:", status)
            
            if status ~= 200 then
                print("Failed with status:", status)
                print("Response:", responseBody or "nil")
            else
                local success, timeEntries = pcall(hs.json.decode, responseBody)
                if success and timeEntries then
                    print("Total entries returned:", #timeEntries)
                    
                    -- Show first 3 entries with key details
                    for i, entry in ipairs(timeEntries) do
                        if i <= 3 then
                            print(string.format("\n--- Entry %d ---", i))
                            print("ID:", entry.id or "nil")
                            print("Description:", entry.description or "nil") 
                            print("Started at:", entry.started_at or "nil")
                            print("Ended at:", entry.ended_at or "nil")
                            
                            -- Check if this looks like an active timer
                            local isActive = entry.started_at and not entry.ended_at
                            print("APPEARS ACTIVE:", tostring(isActive))
                        end
                    end
                else
                    print("Failed to parse JSON")
                end
            end
            
            -- Test next URL after a delay
            hs.timer.doAfter(1, function() testUrl(index + 1) end)
        end)
    end
    
    testUrl(1)
end

-- Constants

M.DEFAULT_BILLABLE = true

return M