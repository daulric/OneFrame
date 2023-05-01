local OneFrame = require(game.ReplicatedStorage.OneFrame)
local Controllers = OneFrame.Controllers

local Test = Controllers.CreateController({
    Name = "test",
    Diamond = 10
})

function Test:Get()
    print(self.Diamond, "diamonds")
    return self.Diamond
end

return Test