local OneFrame = require(game.ReplicatedStorage.OneFrame)

local component = OneFrame.Component:createComponent()

function component:init()
    print("component init")
end

function component:preload()
    print("component preloading")
end

function component:render()
    print("component rendering")
end


return component