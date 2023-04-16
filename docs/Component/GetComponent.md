# **OneFrame GetComponent**

This returns extended component in another server / client

```lua
local OneFrame = require(path.to.module)

local Component = OneFrame.Component:GetComponent(
    name: string
)
```

This will return the component that was called using the `:extend(name)`.