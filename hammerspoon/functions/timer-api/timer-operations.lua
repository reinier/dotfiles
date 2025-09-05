-- timer-operations.lua - Timer business logic and operations
local M = {}

-- Dependencies 
local apiClient = require("functions.timer-api.api-client")
local userManager = require("functions.timer-api.user-manager")

-- Utility Functions

local function buildFilterParam(filters)
    if not filters or #filters == 0 then return "" end
    return "?filter=" .. table.concat(filters, ",")
end

local function getLast21DaysFilter()
    local today = os.date("!%Y%m%d")
    local twentyOneDaysAgo = os.date("!%Y%m%d", os.time() - (21 * 24 * 60 * 60))
    return twentyOneDaysAgo .. ".." .. today
end

local function getDateRangeFilter(startDate, endDate)
    -- Accepts dates in YYYY-MM-DD format or timestamp
    if type(startDate) == "number" then
        startDate = os.date("!%Y%m%d", startDate)
    else
        startDate = startDate:gsub("-", "")
    end
    
    if type(endDate) == "number" then
        endDate = os.date("!%Y%m%d", endDate)
    else
        endDate = endDate:gsub("-", "")
    end
    
    return startDate .. ".." .. endDate
end

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

function M.getActiveTimers(config, adminId, options, callback)
    -- Handle optional options parameter
    if type(options) == "function" then
        callback = options
        options = {}
    end
    options = options or {}
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    -- Build filter parameters
    local filters = {"include_active:true"}
    
    if options.includePeriod then
        if options.includePeriod == "last_21_days" then
            local today = os.date("!%Y%m%d")
            local twentyOneDaysAgo = os.date("!%Y%m%d", os.time() - (21 * 24 * 60 * 60))
            table.insert(filters, "period:" .. twentyOneDaysAgo .. ".." .. today)
        elseif options.includePeriod == "this_month" then
            table.insert(filters, "period:this_month")
        elseif type(options.includePeriod) == "string" then
            table.insert(filters, "period:" .. options.includePeriod)
        end
    end
    
    local filterParam = "?filter=" .. table.concat(filters, ",")
    if options.perPage then
        filterParam = filterParam .. "&per_page=" .. options.perPage
    end
    
    local url = "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json" .. filterParam
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            local errorMsg = "❌ Failed to get active timers. Status: " .. status
            if responseBody then
                errorMsg = errorMsg .. "\n" .. responseBody
            end
            callback(nil, errorMsg)
            return
        end
        
        local success, timeEntries = pcall(hs.json.decode, responseBody)
        if not success or not timeEntries then
            callback(nil, "❌ Invalid response from active timers API")
            return
        end
        
        -- Filter for truly active timers (started but not ended)
        local activeTimers = {}
        for _, entry in ipairs(timeEntries) do
            if entry.started_at and not entry.ended_at then
                table.insert(activeTimers, entry)
            end
        end
        
        callback(activeTimers, nil)
    end)
end

function M.debugActiveTimers(config, adminId, callback)
    hs.alert.show("ℹ️ Fetching active timers for debugging...", 2)
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    -- Helper function to get last 21 days range
    local function getLast21DaysFilter()
        local today = os.date("!%Y%m%d")
        local twentyOneDaysAgo = os.date("!%Y%m%d", os.time() - (21 * 24 * 60 * 60))
        return twentyOneDaysAgo .. ".." .. today
    end
    
    -- Try different URL parameter approaches with correct filter format
    local last21Days = getLast21DaysFilter()
    local urls = {
        -- Basic without filters
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json",
        -- With include_active only (CORRECT FORMAT)
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?filter=include_active:true",
        -- With this month + active (CORRECT FORMAT)
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?filter=period:this_month,include_active:true",
        -- With last 21 days + active (CORRECT FORMAT)
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?filter=period:" .. last21Days .. ",include_active:true",
        -- With limit to reduce results + active
        "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json?filter=include_active:true&per_page=10",
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

-- Utility Functions (exported)

M.buildFilterParam = buildFilterParam
M.getLast21DaysFilter = getLast21DaysFilter
M.getDateRangeFilter = getDateRangeFilter

-- Constants

M.DEFAULT_BILLABLE = true

return M