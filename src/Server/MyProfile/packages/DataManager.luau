local datamanager = {}

--// Variables

local modules = script.Parent.Parent.modules

--// Modules

local config = require(modules.Config)

--// Services

local dds = game:GetService("DataStoreService")
local profile = dds:GetDataStore(config["DataBase-Name"])

--// Data Manager

function datamanager:get(key)
   return profile:GetAsync(key) 
end

function datamanager:set(key, value)
    local success, response = pcall(function()
        profile:SetAsync(key, value)
    end)
    if success then
        return true
    else
        warn(response)
    end

    return false
end

function datamanager:update(key, value)
    local success, response = pcall(function()
        profile:UpdateAsync(key, function()
            return value
        end)
    end)
    if success then
        return true
    else
        warn(response)
    end

    return false
end

return datamanager