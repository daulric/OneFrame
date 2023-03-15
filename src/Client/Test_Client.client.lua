local OneFrame = require(game:GetService("ReplicatedStorage"):WaitForChild("OneFrame"))

OneFrame.Component:GetRegisteredSignal(function(name, class)
    print(name, "was registered!", class)
end)

local success = OneFrame.StartClient(game.ReplicatedStorage.Test, true)

if success then
    print("server started")
end