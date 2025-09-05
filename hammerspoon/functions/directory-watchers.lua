local M = {}

local config = {}
local activeWatchers = {}
local currentComputer = nil

local function log(message)
    print("[DirectoryWatchers] " .. message)
end

local function expandPath(path)
    if path:sub(1, 1) == "~" then
        return os.getenv("HOME") .. path:sub(2)
    end
    return path
end

local function ensureDirectoryExists(path)
    local expandedPath = expandPath(path)
    local success = hs.fs.mkdir(expandedPath)
    if not success then
        local attributes = hs.fs.attributes(expandedPath)
        if attributes and attributes.mode == "directory" then
            return true
        end
        return false
    end
    return true
end

local function parseYAMLConfig(filePath)
    local file = io.open(filePath, "r")
    if not file then
        log("Configuration file not found: " .. filePath)
        return {}
    end
    
    local content = file:read("*all")
    file:close()
    
    local watchers = {}
    local currentWatcher = nil
    
    for line in content:gmatch("[^\r\n]+") do
        line = line:gsub("^%s+", ""):gsub("%s+$", "")
        
        if line:match("^#") or line == "" then
            goto continue
        end
        
        if line == "watchers:" then
            goto continue
        end
        
        if line:match("^%- source:") then
            if currentWatcher then
                table.insert(watchers, currentWatcher)
            end
            currentWatcher = {}
            local source = line:match("^%- source:%s*[\"']?([^\"']+)[\"']?")
            if source then
                currentWatcher.source = source
            end
        elseif currentWatcher then
            local target = line:match("^target:%s*[\"']?([^\"']+)[\"']?")
            if target then
                currentWatcher.target = target
                goto continue
            end
            
            local computer = line:match("^computer:%s*[\"']?([^\"']+)[\"']?")
            if computer then
                currentWatcher.computer = computer
                goto continue
            end
            
            local enabled = line:match("^enabled:%s*(%w+)")
            if enabled then
                currentWatcher.enabled = (enabled:lower() == "true")
                goto continue
            end
            
            local description = line:match("^description:%s*[\"']?([^\"']*)[\"']?")
            if description then
                currentWatcher.description = description
                goto continue
            end
        end
        
        ::continue::
    end
    
    if currentWatcher then
        table.insert(watchers, currentWatcher)
    end
    
    return watchers
end

function M.getCurrentComputer()
    if not currentComputer then
        currentComputer = hs.host.localizedName()
    end
    return currentComputer
end

function M.filterConfigForCurrentComputer(allWatchers)
    local computerName = M.getCurrentComputer()
    local filtered = {}
    
    for _, watcher in ipairs(allWatchers) do
        if watcher.computer == computerName and (watcher.enabled ~= false) then
            if watcher.source and watcher.target then
                table.insert(filtered, watcher)
            else
                log("Skipping watcher with missing source or target: " .. (watcher.description or "unnamed"))
            end
        end
    end
    
    log("Filtered " .. #filtered .. " watchers for computer: " .. computerName)
    return filtered
end

function M.loadConfig()
    local configPath = hs.configdir .. "/directory-watchers-config.yaml"
    local allWatchers = parseYAMLConfig(configPath)
    config = M.filterConfigForCurrentComputer(allWatchers)
    log("Loaded " .. #config .. " watchers from configuration")
    return config
end

function M.createWatcher(watcherConfig)
    local source = expandPath(watcherConfig.source)
    local target = expandPath(watcherConfig.target)
    
    local sourceAttribs = hs.fs.attributes(source)
    if not sourceAttribs or sourceAttribs.mode ~= "directory" then
        log("Source directory does not exist, skipping: " .. source)
        return nil
    end
    
    if not ensureDirectoryExists(target) then
        log("Cannot create target directory, skipping: " .. target)
        return nil
    end
    
    local watcher = hs.pathwatcher.new(source, function(files, flagTables)
        for i, file in ipairs(files) do
            local flags = flagTables[i]
            
            if flags.itemCreated and not flags.itemIsDir then
                local fileName = file:match("([^/]+)$")
                if fileName then
                    local targetPath = target .. "/" .. fileName
                    
                    hs.timer.doAfter(0.1, function()
                        local success, error = os.rename(file, targetPath)
                        if success then
                            log("Moved: " .. fileName .. " -> " .. target)
                            hs.notify.new({
                                title = "Directory Watcher",
                                informativeText = "Moved " .. fileName .. " to " .. watcherConfig.target
                            }):send()
                        else
                            log("Failed to move " .. fileName .. ": " .. (error or "unknown error"))
                        end
                    end)
                end
            end
        end
    end)
    
    if watcher then
        watcher:start()
        log("Started watcher: " .. source .. " -> " .. target)
        if watcherConfig.description then
            log("  Description: " .. watcherConfig.description)
        end
    end
    
    return watcher
end

function M.stop()
    for _, watcher in ipairs(activeWatchers) do
        if watcher then
            watcher:stop()
        end
    end
    activeWatchers = {}
    log("Stopped all directory watchers")
end

function M.start()
    M.stop()
    
    if not M.loadConfig() then
        log("Failed to load configuration")
        return false
    end
    
    if #config == 0 then
        log("No watchers configured for this computer: " .. M.getCurrentComputer())
        return true
    end
    
    for _, watcherConfig in ipairs(config) do
        local watcher = M.createWatcher(watcherConfig)
        if watcher then
            table.insert(activeWatchers, watcher)
        end
    end
    
    log("Directory watcher system started with " .. #activeWatchers .. " active watchers")
    return true
end

function M.reload()
    log("Reloading directory watchers...")
    return M.start()
end

function M.status()
    local computerName = M.getCurrentComputer()
    log("Directory Watcher Status:")
    log("  Computer: " .. computerName)
    log("  Active watchers: " .. #activeWatchers)
    log("  Configured watchers: " .. #config)
    
    for i, watcherConfig in ipairs(config) do
        local status = activeWatchers[i] and "ACTIVE" or "INACTIVE"
        log("    [" .. status .. "] " .. watcherConfig.source .. " -> " .. watcherConfig.target)
        if watcherConfig.description then
            log("      " .. watcherConfig.description)
        end
    end
end

return M