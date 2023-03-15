local OneFrame = require(game:GetService("ReplicatedStorage"):WaitForChild("OneFrame"))

OneFrame.Component:GetRegisteredSignal(function(name)
    print(name, "was registered!")
end)

local success = OneFrame.StartClient(game.ReplicatedStorage.Test, true)

if success then
    print("server started")
end