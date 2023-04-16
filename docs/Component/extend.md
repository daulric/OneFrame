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

## **Cleanup Service** 
#### Provides garbage collection and memory leak cleanups


#### **:Add()**
```lua
function component:render()
    self.Cleanup:Add(
        Instance: Instance
    ) -> Instance
end
```

#### **:Connect()**
```lua
function component:render()
    self.connection = self.Cleanup:Connect(
        connection: RBXScriptSignal,
        callback: (...any) -> ()
    ) -> RBXScriptConnection
end
```

#### **:Remove()**
```lua
function component:render()
    self.Cleanup:Remove(
        object: Instance | RBXScriptConnection
    )
end
```

#### **:Clean()**
```lua
function component:render()
    self.Cleanup:Clean() -> boolean
end
```

## **Event Service** 
#### Provides a safe and reliable passage when using remote and bindable event / functions
#

### **:Listen()**
This listens for incoming signal that is corresponded with the id
```lua
function component:init()
    self.Event:Listen(
        id: string,
        callback: (...any?) -> ()
    ) -> ()
end
```

### **.Get(id)**
This creates a `.Get` Event Component
```lua
function component:render()
    self.Event.Get(
        id: string
    ) -> Api
end
```

### **.Send(id)**
This creates a `.Send` Event component
```lua
function component:render()
    self.Event.Send(
        id: string
    ) -> Api
end
```
#

## **`.Send(id)` and `.Get(id)` Api**

```lua
:Cross(
    ...any
) -> ...any | ()
```

This sends or returns data from another server / client

```lua
:Server(
    ...any
) -> ...any | ()
```
This sends or returns data from the server

```lua
:Client(
    player: Player,
    ...any
) -> ...any | ()
```
This sends or returns data from the client