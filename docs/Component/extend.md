---
sidebar_position: 1
---

## Creating a Component using extend
This code will be executed!

```lua
local OneFrame = require(path.to.module)

local Component = OneFrame.Component:extend(name)

return Component
```

## Basic Functions

`:init` - this inialize the component before the main function runs
```lua
function Component:init(...)
    -- code here
end
```

`:preload` - this will preload anything before it renders the function.
```lua
function Component:preload(...)
    -- code here
end
```

`:render` will render the main code
```lua
function Component:render(...)
    -- code here
end
```

`:closing` - will render when the game is closing
```lua
function Component:closing(...)
    -- code here
end
```

## Built In Funtions
`:setState` - this sets a state to the component
```lua
function Component:render()
    self:setState({
        money = 100
    })
end
```

`.state` - this returns the state
```lua
function Component:render()
    print(self.state.money) -- 100
end
```

`:require` - this will require any components that was created using `createComponent`
```lua
function Component:render()
    local module = self:require(path.to.component)
    print(module)
end
```


## Event Service
Use `self.Event` to get the Event Class of the Component

### **Initializing a Send Event**
```lua
function Component:render()
    self.Event.Send(id: string)
end
```

### **Initialising a Get Event**
```lua
function Component:render()
    self.Event.Get(id: string)
end
```

### Send / Get Types

**Cross** - this sends / get data from server/client to another server/client
```lua
:Cross(
    ...any
) -> any | ()
```

**Server** - this sends / get data from the client to the server
```lua
:Server(
    ...any
) -> any | ()
```

**Client** - this sends / get data from the server to the client
```lua
:Client(
    player: Player,
    ...any
) -> any | ()
```

## Cleanup Service

Cleanup Service is there to keep the roblox eco-system clean at all times.
This manages memory leaks and handles garbage collection

`:Add()` - this adds the object in a queue to be cleaned up!
```lua
:Add(
    obj: Instance
) -> Instance
```

`:Connect` - this added Script Connections in the queue to be cleaned up!
```lua
:Connect(
    connection: RBXScriptSignal,
    callback: (...any) -> ()
) -> RBXScriptConnection
```

`:Remove()` - this will disconnect events or destroy objects
```lua
:Remove(
    obj: Instance | RBXScriptConnection
) -> ()
```

`:Clean()` - this will clean all of objects and connections that was stored the queue
```lua
:Clean() -> boolean
```