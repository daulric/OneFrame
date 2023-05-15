# Component

Sample Code for the Component

```lua
local OneFrame = require(path.to.module)

local myComponent = OneFrame.Component:extend("Test_Hello")

function myComponent:init()
    self:setState({
        hello = 10,
        bye = 10,
    })
end

function myComponent:preload(...)
    print(...) -- > "Hello"
end

function myComponent:render(...)
    self:setState({...})

    print(self.state)
end

function myComponent:closing()

    self:setState(function(state)
        print("state before shutting down", state)
        return {}
    end)

    print("shutting down!")
end

return myComponent
```