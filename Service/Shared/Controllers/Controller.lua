local OneFrame = require(game.ReplicatedStorage.OneFrame)
local Controllers = OneFrame.Controllers

local Test = Controllers.CreateController({
    Name = "test",
    Diamond = 1000,
    Gold = 10,
    Silver = 100,
    Emerald = 1,
    event = OneFrame.CreateSignal(),
    bindable = OneFrame.CreateBinableSignal()
})

function Test:Get()
    print(self.Diamond, "diamonds")
    return self.Diamond
end

function Test:Send()
    self.event:Fire()
    self.bindable:Fire()
end

return Test