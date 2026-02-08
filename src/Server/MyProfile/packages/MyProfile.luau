local module = {}

--// Variables

local modules = script.Parent.Parent.modules
local data = script.Parent.Parent.data

local methods = {}
methods.__index = methods

--// Modules

local datamanager = require(script.Parent.DataManager)

local collection = require(data.collection)
local config = require(modules.Config)

--// Services

local http = game:GetService("HttpService")

--// Module

function module:load(player : Player)
    local key = http:GenerateGUID(false)

    local newPlayerData = setmetatable({},methods)
    newPlayerData.plr = player
    newPlayerData.id = player.UserId
    newPlayerData.data = {}
    newPlayerData.key = key

    --// Database Operation

    local playerCollection = datamanager:get(player.UserId)

    if playerCollection then
        newPlayerData.data = playerCollection
    else
        newPlayerData.data = config["DataBase-Template"]
    end

    task.spawn(function()
        while task.wait(1) do
            print(collection[player.UserId])
        end
    end)

    --// Collection Load

    collection[player.UserId] = newPlayerData

    print("[MyProfile] : "..player.Name.." data has been loaded into the collection.")

    return newPlayerData
end

function module:getCache(player: Player)
    return collection[player.UserId]
end

function module:remove(player : Player)
    datamanager:update(player.UserId, collection[player.UserId].data)
    collection[player.UserId] = nil
end

--// Methods

function methods:GetDataToText()
    return http:JSONEncode(self.data)
end

return module