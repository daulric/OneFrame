# **OneFrame Extend Component**

## **Creating a OneFrame Component**

```lua
local OneFrame = require("path.to.module")

local component = OneFrame.Component:extend(
    name: string,
    test: boolean? -- if this is true, it will only run in studio
)


```
This will create a new component to be ran in the server/client

#

# **Different Functions**

```lua
function component:init(...)
    -- this will run at the beginning
end
```

```lua
function component:preload(...)
    -- this will preload right after it has be initialized
end
```

```lua
function component:render(...)
    -- this will render stuff after preloading has finished
end
```

```lua
function component:closing(...)
    -- this will run when the game server is shutting down

    -- it operates with game:BindToClose() function
end
```

#
# **Service Providers**

## **Cleanup Service** - Provides garbage collection and memory leak cleanups


#### **:Add()**
```lua
function component:render()
    self.part = self.Cleanup:Add(Instance.new("Part"))
end
```

#### **:Connect()**
```lua
function component:render()
    self.connection = self.Cleanup:Connect(game.Players.PlayerAdded, function(player)
        print("Player Added", player)
    end)
end
```

#### **:Remove()**
```lua
function component:render()
    self.Cleanup:Remove(self.part)
    self.Cleanup:Remove(self.connection)
end
```

#### **:Clean()**
```lua
function component:render()
    local success = self.Cleanup:Clean()

    if success then
        print("cleanup was successful")
    end
end
```

## **Event Service** - Provides a safe and reliable passage when using remote and bindable event / functions
#

## **:Listen()**
```lua
function component:init()
    self.Event:Listen(
        id: string,
        callback: (...any?) -> ()
    )
end
```

## **.Get(id)**
Creating an .Get Event Component
```lua
function component:render()
    local getEvent = self.Event.Get(
        id: string
    )
end
```

this gets data from another server / client
```lua
getEvent:Cross(
    ...any?
) -> ...any

```

This gets data from ther server
```lua
getEvent:Server(
    ...any?
) -> ...any

```
This gets data from the client

```lua
getEvent:Client(
    player: Player,
    ...any
) -> ...any
```

## **.Send(id)**
This creates a .Send Event component
```lua
function component:render()

    local sendEvent = self.Event.Send(
        id: string
    )

end
```

this sends data to another server / client
```lua 
sendEvent:Cross(
    ...any
) -> ()
```

This send data to the server
```lua
sendEvent:Server(
    ...any
) -> ()
```
This sends data to the client
```lua
sendEvent:Client(
    player: Player,
    ...any
) -> ()
```

#