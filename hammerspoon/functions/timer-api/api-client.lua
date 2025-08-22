-- api-client.lua - Base HTTP functionality and API utilities
local M = {}

-- Public API Functions

function M.getCurrentUTCTimestamp()
    return os.date("!%Y-%m-%d %H:%M:%S UTC")
end

function M.makeAPIRequest(method, url, headers, body, callback)
    hs.http.doAsyncRequest(url, method, body, headers, callback)
end

function M.getAdministrationId(config, callback)
    local headers = {
        ["Authorization"] = "Bearer " .. config.API_AUTH_TOKEN,
        ["Accept"] = "application/json"
    }
    
    local url = "https://moneybird.com/api/v2/administrations.json"
    
    hs.http.doAsyncRequest(url, "GET", nil, headers, function(status, responseBody, responseHeaders)
        if status ~= 200 then
            callback(nil, "❌ Failed to get administrations. Status: " .. status)
            return
        end
        
        local success, administrations = pcall(hs.json.decode, responseBody)
        if not success or not administrations or #administrations == 0 then
            callback(nil, "❌ Invalid or empty administrations response")
            return
        end
        
        callback(administrations[1].id, nil)
    end)
end

-- Constants

M.BASE_URL = "https://moneybird.com/api/v2"

return M