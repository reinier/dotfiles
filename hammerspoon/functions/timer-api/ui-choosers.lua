-- ui-choosers.lua - All chooser interfaces for clients, projects, and descriptions
local M = {}

-- Dependencies 
local cache = require("functions.timer-api.cache")

-- Public API Functions

function M.showClientChooser(config, adminId, callback)
    -- Get both clients and their usage data
    cache.getClients(config, adminId, function(clients, clientError)
        if clientError then
            callback(nil, clientError)
            return
        end
        
        if not clients or #clients == 0 then
            callback(nil, "❌ No clients found")
            return
        end
        
        cache.getRecentClientUsage(config, adminId, function(clientUsage, usageError)
            -- Continue even if usage data fails
            if usageError then
                clientUsage = {}
            end
            
            local chooser = hs.chooser.new(function(choice)
                if choice then
                    callback(choice.clientId, nil)
                else
                    callback(nil, "❌ No client selected")
                end
            end)
            
            -- Sort clients by recent usage, then alphabetically
            local sortedClients = {}
            for _, client in ipairs(clients) do
                local clientId = tostring(client.id)
                local usage = clientUsage[clientId] or {count = 0, lastUsed = ""}
                
                table.insert(sortedClients, {
                    client = client,
                    usage = usage
                })
            end
            
            -- Sort by last used date (most recent first), then by usage count, then by name
            table.sort(sortedClients, function(a, b)
                if a.usage.lastUsed ~= b.usage.lastUsed then
                    return a.usage.lastUsed > b.usage.lastUsed
                end
                if a.usage.count ~= b.usage.count then
                    return a.usage.count > b.usage.count
                end
                return (a.client.company_name or a.client.firstname or "Unknown") < (b.client.company_name or b.client.firstname or "Unknown")
            end)
            
            local choices = {}
            for _, item in ipairs(sortedClients) do
                local client = item.client
                local usage = item.usage
                
                local displayName = client.company_name or 
                                  (client.firstname and client.lastname and (client.firstname .. " " .. client.lastname)) or 
                                  client.firstname or "Unknown Client"
                
                local subText = "ID: " .. (client.id or "unknown")
                if usage.count > 0 then
                    subText = subText .. " • Used " .. usage.count .. " times"
                    if usage.lastUsed and usage.lastUsed ~= "" then
                        subText = subText .. " • Last: " .. string.sub(usage.lastUsed, 1, 10) -- Just the date part
                    end
                end
                
                table.insert(choices, {
                    text = displayName,
                    subText = subText,
                    clientId = client.id
                })
            end
            
            chooser:choices(choices)
            chooser:placeholderText("Select client for timer...")
            chooser:selectedRow(1)  -- Default to first (most recently used) client
            chooser:show()
        end)
    end)
end

function M.showProjectChooser(config, adminId, callback)
    cache.getProjects(config, adminId, function(projects, projectError)
        if projectError then
            callback(nil, projectError)
            return
        end
        
        if not projects or #projects == 0 then
            callback(nil, "❌ No projects found")
            return
        end
        
        local chooser = hs.chooser.new(function(choice)
            if choice then
                callback(choice.projectId, nil)
            else
                callback(nil, "❌ No project selected")
            end
        end)
        
        local choices = {}
        for i, project in ipairs(projects) do
            table.insert(choices, {
                text = project.name or "Unknown Project",
                subText = "ID: " .. (project.id or "unknown"),
                projectId = project.id
            })
        end
        
        chooser:choices(choices)
        chooser:placeholderText("Select project for timer...")
        chooser:selectedRow(1)  -- Default to first project
        chooser:show()
    end)
end

function M.showDescriptionInput(callback)
    -- Get last used description and common descriptions
    local lastDescription = hs.settings.get("timer.lastDescription") 
    local recentDescriptions = hs.settings.get("timer.recentDescriptions") or {}
    
    local chooser = hs.chooser.new(function(choice)
        if choice then
            local description = choice.text
            -- Save the description for next time
            hs.settings.set("timer.lastDescription", description)
            
            -- Add to recent descriptions (keep last 5, avoid duplicates)
            local newRecent = {description}
            for _, desc in ipairs(recentDescriptions) do
                if desc ~= description and #newRecent < 5 then
                    table.insert(newRecent, desc)
                end
            end
            hs.settings.set("timer.recentDescriptions", newRecent)
            
            callback(description, nil)
        else
            callback(nil, "❌ Timer cancelled")
        end
    end)
    
    -- Build choices list with recent descriptions
    local choices = {}
    
    -- Add last used description first (if exists)
    if lastDescription then
        table.insert(choices, {
            text = lastDescription,
            subText = "Last used"
        })
    end
    
    -- Add other recent descriptions
    for _, desc in ipairs(recentDescriptions) do
        if desc ~= lastDescription then
            table.insert(choices, {
                text = desc,
                subText = "Recent"
            })
        end
    end
    
    -- Add some common defaults if no recent descriptions
    if #choices == 0 then
        local defaults = {
            "Work Timer Entry",
            "Development work", 
            "Meeting",
            "Code review",
            "Documentation"
        }
        for _, desc in ipairs(defaults) do
            table.insert(choices, {
                text = desc,
                subText = "Suggested"
            })
        end
    end
    
    chooser:choices(choices)
    chooser:placeholderText("Enter timer description...")
    chooser:selectedRow(1) -- Default to first choice (last used)
    
    -- Allow typing custom descriptions
    chooser:queryChangedCallback(function(query)
        if query and query ~= "" then
            -- Show typed text as first option
            local newChoices = {{text = query, subText = "Custom"}}
            -- Add existing choices that match
            for _, choice in ipairs(choices) do
                if string.find(string.lower(choice.text), string.lower(query), 1, true) then
                    table.insert(newChoices, choice)
                end
            end
            chooser:choices(newChoices)
        else
            chooser:choices(choices)
        end
    end)
    
    chooser:show()
end

-- Constants

M.MAX_RECENT_DESCRIPTIONS = 5
M.DEFAULT_DESCRIPTIONS = {
    "Work Timer Entry",
    "Development work", 
    "Meeting",
    "Code review",
    "Documentation"
}

return M