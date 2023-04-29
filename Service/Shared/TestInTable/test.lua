local OneFrame = require(game.ReplicatedStorage.OneFrame)

local Comp = OneFrame.Component:extend("Hello10")

function Comp:render()
    print("rendering component from table")
end

print("working table", Comp)

return Comp