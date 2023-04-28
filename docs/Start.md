This runs components within a particular folder

```lua
local OneFrame = require(path.to.module)

OneFrame.Start(
    Folder: Instance,
    ignorePrint: boolean,
    ...any, -- any thing can be added to this path
)
```