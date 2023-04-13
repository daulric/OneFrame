local OneFrame = require(game:GetService("ReplicatedStorage"):WaitForChild("OneFrame"))

local TestComponent = OneFrame.Component:serve("Hello1")

function TestComponent:preload()
    self.Working = "Working"
end

function TestComponent:render()
    print(self.Working)
end

return TestComponent