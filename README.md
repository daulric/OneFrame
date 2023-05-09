# **What is OneFrame?**
OneFrame is a module that allows developers to run multiple modular code under one server / client.

It was designed to give developers a sense of ease when making games and other projects.

# **Why Choose OneFrame**
There was a problem with games always scripts all over the place. The solution was to run all codes under one server / client without anything breaking!

This module was created to be:
- Fast
- Reliable
- More Organized
- Promise Implementation (by evaera)

# **Usage**

## Running Module Scripts from Folders

```lua
local OneFrame = require(path.to.module)
local testFolder = path.to.folder or { path.to.folder }

OneFrame.Start(testFolder, ignorePrint: boolean?, ...any --[[ data / params here]]):andThen(function()
    print("Running Folder Finished!")
end)
```
**What happens when `.Start()` is called?**
- It will execute any modular code that is a component or a function.
- Modules that is not a component or a function, the module will be skipped!
- This wil return a promise when all the modules are executed!

## Creating Components To Be Executed
This wil create a component that will be executed when `.Start()` is called.
```lua
local OneFrame = require(path.to.module)

local testComponent = OneFrame.Component:extend(name: string, test: boolean? --[[true = runs code in studio only!]] )

function testComponent:init()
    -- initializes the module
end

function testComponent:preload()
    -- preloads the module
end

function testComponent:render()
    -- renders / execute the code
end

function testComponent:closing()
 -- runs when game is closing
end

return testComponent
```

## Creating Functional Module to be Executed
This will execute the function when `.Start()` is called
```lua
return function (...any --[[params here]])
    print(params here!)
end
```

# **Install OneFrame Today**
[<img src="https://wally.run/static/wally-logo.7f93c2d5.svg" width="200" height="100">](https://wally.run/package/daulric/oneframe) [<img src="./images/installation2.png" width="200" height="100">](./OneFrame.rbxm)
