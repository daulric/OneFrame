# Start

Code Samples Based of the OneFrame Module

### Executing the Code

```lua
local OneFrame = require(path.to.module)
local Folder = path.to.folder or {path.to.folder, path.to.another.folder}

OneFrame.Start(Folder, true, "Hello"):andThen(function()
    print("Finished Executing the Code!")
end)
```

!!! note "More Examples Comming Soon"