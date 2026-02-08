--// Variables

local packages = script.Parent.packages
local data = script.Parent.data

--// Modules

local myprofile = require(packages.MyProfile)
local datamanager = require(packages.DataManager)
local collection = require(data.collection)

--// Main

game.Players.PlayerAdded:Connect(function(player : Player)
    myprofile:load(player)
end)

game.Players.PlayerRemoving:Connect(function(player : Player)
    myprofile:remove(player)
end)

--// Against Server Termination

game:BindToClose(function()
    for _,v in pairs(collection) do
        print("Kullanıcı : ", v)
        datamanager:update(v.id, v.data)
    end
end)
