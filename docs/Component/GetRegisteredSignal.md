## **OneFrame Registered Signal**

#

```lua
local OneFrame = require(path.to.module)

OneFrame.Component:GetRegisteredSignal(
    handler: (name: string) -> ()
)
```

This gets the name of the component that has been registered using `:extend(name)`.