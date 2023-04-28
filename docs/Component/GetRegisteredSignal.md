This function listens for the names of Components that has been registered!

```lua
local OneFrame = require(path.to.module)

OneFrame.Component:GetRegisteredSignal(
    handler: (name: string) -> ()
) -> ()
```