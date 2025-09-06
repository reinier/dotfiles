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

local function moveFile(sourcePath, targetPath)
    local success, error = os.rename(sourcePath, targetPath)
    if success then
        return true, nil
    end
    
    if error and error:match("Cross%-device link") then
        log("Cross-device move detected, using copy+delete fallback")
        
        local sourceFile, sourceErr = io.open(sourcePath, "rb")
        if not sourceFile then
            return false, "Cannot open source file: " .. (sourceErr or "unknown error")
        end
        
        local sourceContent = sourceFile:read("*all")
        sourceFile:close()
        
        if not sourceContent then
            return false, "Failed to read source file content"
        end
        
        local targetFile, targetErr = io.open(targetPath, "wb")
        if not targetFile then
            return false, "Cannot create target file: " .. (targetErr or "unknown error")
        end
        
        local writeSuccess = targetFile:write(sourceContent)
        targetFile:close()
        
        if not writeSuccess then
            os.remove(targetPath)
            return false, "Failed to write to target file"
        end
        
        local removeSuccess = os.remove(sourcePath)
        if not removeSuccess then
            log("Warning: Target file created but failed to remove source file: " .. sourcePath)
            return true, "File copied but source not removed"
        end
        
        return true, nil
    end
    
    return false, error or "unknown error"
end

local function loadSecretsConfig()
    local secrets = hs.settings.get("secrets")
    if not secrets or not secrets.directoryWatchers or not secrets.directoryWatchers.watchers then
        log("No directory watchers found in secrets configuration")
        return {}
    end
    
    return secrets.directoryWatchers.watchers
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
    local allWatchers = loadSecretsConfig()
    config = M.filterConfigForCurrentComputer(allWatchers)
    log("Loaded " .. #config .. " watchers from secrets configuration")
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
            
            if (flags.itemCreated or flags.itemRenamed) and not flags.itemIsDir then
                local fileName = file:match("([^/]+)$")
                if fileName and fileName ~= ".DS_Store" then
                    local targetPath = target .. "/" .. fileName
                    
                    hs.timer.doAfter(0.1, function()
                        local success, error = moveFile(file, targetPath)
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