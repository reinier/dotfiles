-- user-manager.lua - User selection and storage management
local M = {}

-- Public API Functions

function M.getUserId(config, adminId, callback)
    -- Check if we have a stored user ID
    local storedUserId = hs.settings.get("timer.userId")
    if storedUserId then
        callback(storedUserId, nil)
        return
    end
    
    -- If not, show user chooser
    M.showUserChooser(config, adminId, callback)
end

function M.showUserChooser(config, adminId, callback)
    M.getAllUsers(config, adminId, function(users, userError)
        if userError then
            callback(nil, userError)
            return
        end
        
        if not users or #users == 0 then
            callback(nil, "❌ No users found")
            return
        end
        
        local chooser = hs.chooser.new(function(choice)
            if choice then
                -- Store the selected user ID
                hs.settings.set("timer.userId", choice.userId)
                callback(choice.userId, nil)
            else
                callback(nil, "❌ No user selected")
            end
        end)
        
        local choices = {}
        for _, user in ipairs(users) do
            local displayName = user.email or "User " .. (user.id or "Unknown")
            if user.first_name or user.last_name then
                displayName = (user.first_name or "") .. " " .. (user.last_name or "")
                displayName = displayName:gsub("^%s+", ""):gsub("%s+$", "") -- trim spaces
                if user.email then
                    displayName = displayName .. " (" .. user.email .. ")"
                end
            end
            
            table.insert(choices, {
                text = displayName,
                subText = "ID: " .. (user.id or "unknown"),
                userId = user.id
            })
        end
        
        -- Sort by name
        table.sort(choices, function(a, b)
            return a.text < b.text
        end)
        
        chooser:choices(choices)
        chooser:placeholderText("Select your user account...")
        chooser:selectedRow(1)  -- Default to first user
        chooser:show()
    end)
end

-- Private Helper Functions

function M.getAllUsers(config, adminId, callback)
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    local url = "https://moneybird.com/api/v2/" .. adminId .. "/users.json"
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            callback(nil, "❌ Failed to get users. Status: " .. status)
            return
        end
        
        local success, users = pcall(hs.json.decode, responseBody)
        if not success or not users then
            callback(nil, "❌ Invalid users response")
            return
        end
        
        callback(users, nil)
    end)
end

return M