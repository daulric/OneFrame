# Bindable Signal

This is like the [Signal](./Signal.md) but for bindable functions

## Contructing Signals
```lua
BindableSignal.new() : BindableSignal
```
This creates a new BindableSignal

## **Methods**

### Connect
```lua
BindableSignal:Connect(function(...)
    print(...)
    return true
end)
```

this listens for signals and return data

### Fire
```lua
local data = BindableSignal:Fire(...) : any
print(data)
```

This send and waits for data to be returns

### Destroy

```lua
BindableSignal:Destroy()
```

This destroys the bindable signal.