local OneFrame = require(game.ReplicatedStorage.OneFrame)
local Controllers = OneFrame.Controllers
local Signal = require(OneFrame.Utils:WaitForChild("Signal"))

local Test = Controllers.CreateController({
    Name = "test",
    Diamond = 1000,
    Gold = 10,
    Silver = 100,
    Emerald = 1,
    event = Signal.new()
})

function Test:Get()
    print(self.Diamond, "diamonds")
    return self.Diamond
end

return Test