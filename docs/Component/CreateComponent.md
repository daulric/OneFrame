---
sidebar_position: 2
---

## Creating Component

```lua
local OneFrame = require(path.to.module)

local Component = OneFrame.Component:createComponent()

function Component:print(...)
    print(...)
end

return Component
```
Created a component

## Calling Component

```lua
local OneFrame = require(path.to.module)
local Test = OneFrame.Component:extend("test")

function Test:render()
    local component = self:require(path.to.component)
    component:print("Hello", "Bye") -- Hello, Bye
end

return Test
```