# Starting OneFrame

You can start OneFrame by simply doing this
```lua
local OneFrame = require(path.to.module)
local testFolder = path.to.folder or { path.to.folder, path.to.folder2 }

OneFrame.Start(testFolder, ignorePrint: boolean?, ...any):andThen(function()
    print("Finished Executing")
end)
```
You can basically run a folder or a table with folders.
This executes code using [Promise](https://eryn.io/roblox-lua-promise/) Implementation by evaera.