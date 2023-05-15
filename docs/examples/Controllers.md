Sample Code for Controllers

## Creating Controllers
```lua
local OneFrame = require(path.to.module)
local Controllers = OneFrame.Controllers

local myController = Controllers.CreateController {
    Name = "Test Controller",
    Signal = OneFrame.CreateSignal()
}

function myController:Send()
    self.Signal:Fire("hello")
end

return myController
```

## Initialing the Controllers in the Server / Client
```lua
local OneFrame = require(path.to.module)
local Controllers = OneFrame.Controllers

Controllers.AddControllers(path.to.controllers)
```

## Getting Controllers
```lua
local OneFrame = require(path.to.module)
local Controllers = OneFrame.Controllers

local Controller = Controllers.GetControllers("Test Controller")

Controller.Signal:Connect(function(...)
    print(...) --> "hello"
end)

Controller:Send() --. This will send the data to the signal
```