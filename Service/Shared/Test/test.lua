local OneFrame = require(game.ReplicatedStorage.OneFrame)

local New =OneFrame.Component:serve("Hello")

function New:preload()
    print("preloading")
end

function New:render()
    print("working")
end

return New