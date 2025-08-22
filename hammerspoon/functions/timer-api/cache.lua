-- cache.lua - Data caching with TTL for projects, clients, and usage
local M = {}

-- Public API Functions

function M.getProjects(config, adminId, callback)
    -- Check if we have cached projects
    local cachedProjects = hs.settings.get("timer.cachedProjects")
    if cachedProjects then
        print("DEBUG: Using cached projects, count:", #cachedProjects)
        callback(cachedProjects, nil)
        return
    end
    
    -- If not cached, fetch from API
    hs.alert.show("ℹ️ Fetching projects from API...", 2)
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    local url = "https://moneybird.com/api/v2/" .. adminId .. "/projects.json"
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            callback(nil, "❌ Failed to get projects. Status: " .. status)
            return
        end
        
        local success, projects = pcall(hs.json.decode, responseBody)
        if not success or not projects then
            callback(nil, "❌ Invalid projects response")
            return
        end
        
        -- Cache the projects for future use
        hs.settings.set("timer.cachedProjects", projects)
        hs.settings.set("timer.projectsCachedAt", os.time())
        print("DEBUG: Cached", #projects, "projects at", os.time())
        
        callback(projects, nil)
    end)
end

function M.getClients(config, adminId, callback)
    -- Check if we have cached clients
    local cachedClients = hs.settings.get("timer.cachedClients")
    if cachedClients then
        print("DEBUG: Using cached clients, count:", #cachedClients)
        callback(cachedClients, nil)
        return
    end
    
    -- If not cached, fetch from API
    hs.alert.show("ℹ️ Fetching clients from API...", 2)
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    local url = "https://moneybird.com/api/v2/" .. adminId .. "/contacts.json"
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            callback(nil, "❌ Failed to get clients. Status: " .. status)
            return
        end
        
        local success, clients = pcall(hs.json.decode, responseBody)
        if not success or not clients then
            callback(nil, "❌ Invalid clients response")
            return
        end
        
        -- Cache the clients for future use
        hs.settings.set("timer.cachedClients", clients)
        hs.settings.set("timer.clientsCachedAt", os.time())
        print("DEBUG: Cached", #clients, "clients at", os.time())
        
        callback(clients, nil)
    end)
end

function M.getRecentClientUsage(config, adminId, callback)
    -- Check if we have cached usage data (refresh every hour)
    local cachedUsage = hs.settings.get("timer.cachedClientUsage")
    local cachedAt = hs.settings.get("timer.clientUsageCachedAt") or 0
    local oneHourAgo = os.time() - (60 * 60) -- 1 hour in seconds
    
    if cachedUsage and cachedAt > oneHourAgo then
        callback(cachedUsage, nil)
        return
    end
    
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    -- Get recent time entries to determine most used clients
    local url = "https://moneybird.com/api/v2/" .. adminId .. "/time_entries.json"
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            callback({}, nil) -- Return empty usage if we can't get time entries
            return
        end
        
        local success, timeEntries = pcall(hs.json.decode, responseBody)
        if not success or not timeEntries then
            callback({}, nil)
            return
        end
        
        -- Count client usage and track most recent usage
        local clientUsage = {}
        for _, entry in ipairs(timeEntries) do
            if entry.contact_id then
                local clientId = tostring(entry.contact_id)
                if not clientUsage[clientId] then
                    clientUsage[clientId] = {count = 0, lastUsed = ""}
                end
                clientUsage[clientId].count = clientUsage[clientId].count + 1
                -- Keep track of most recent usage
                if entry.started_at and (clientUsage[clientId].lastUsed < entry.started_at) then
                    clientUsage[clientId].lastUsed = entry.started_at
                end
            end
        end
        
        -- Cache the usage data for future use (valid for 1 hour)
        hs.settings.set("timer.cachedClientUsage", clientUsage)
        hs.settings.set("timer.clientUsageCachedAt", os.time())
        
        callback(clientUsage, nil)
    end)
end

-- Constants

M.CACHE_TTL_HOUR = 60 * 60 -- 1 hour in seconds

return M