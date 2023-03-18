local OneFrame = require(game:GetService("ReplicatedStorage"):WaitForChild("OneFrame"))

local New2 = OneFrame.Component:serve("test2")

function New2:preload()
    print("preloading test2")
end

function New2:render()
    print("test2 working")
end

return New2