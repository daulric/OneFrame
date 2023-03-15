local OneFrame = require(game.ReplicatedStorage.OneFrame)

OneFrame.Component:GetRegisteredSignal(function(name, class)
    print(name, "was registered!", class)
end)

local success = OneFrame.StartServer(game.ReplicatedStorage.Test, true)

if success then
    print("server started")
end