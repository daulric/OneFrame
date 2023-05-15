# Event

This is the Event Service of OneFrame

## Listening for Events
This will listen any incoming signal to the server or client
```lua
Event:Listen(id: string, function(...: any)
    print(...)
end)
```

## Creating a Send Signal
This creates a Send Signal to send data to the server or client
```lua
local event = Event.Send(id: string)
```

## Creating a Get Signal
```lua
local event = Event.Get(id: string)
```

## Send / Get Methods

If the Signal created was a Get Signal, it will return a value otherwise it won't return anything if Send Signal was created

### :Server
```lua
event:Server(...)
```

### :Client
```lua
event:Client(player, ...)
```

### :AllClients
```lua
event:AllClients(...)
```
This only works with Send Signals.