local OneFrame = require(game:GetService("ReplicatedStorage"):WaitForChild("OneFrame"))

local TestComponent = OneFrame.Component:extend("Hello1")

function TestComponent:preload()
    self.Working = "Working"
end

function TestComponent:render()
    print(self.Working)
end

return TestComponent