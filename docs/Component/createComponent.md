## **OneFrame Shared Component**
#

### **Creating A Shared Component**
```lua
local OneFrame = require(path.to.module)

local component = OneFrame.Component:createComponent()

function component:printAny(...)
    print(...)
end

return component
```

### **Running in the extend component**
```lua
local OneFrame = require(path.to.module)

local Test = OneFrame.Component:extend("Hello")

function Test:render()
    local SharedComponent = self:require(path.to.component) -- this make sure that the component is valid
    SharedComponent:printAny("idk", 1, 2, 3)
end

return Test
```