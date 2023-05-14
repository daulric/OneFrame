# Signal

## Contructing a New Signal

```lua
Signal.new() : Signal
```

This contructs a new signal

## **Methods**

### Connect
```lua
Signal:Connect(function(...)
    print(...)
end)
```

This listens for signal

### Fire
```lua
Signal:Fire(...)
```

This fires any params

### Wait
```lua
Signal:Wait()
```

This waits for signals

### Destroy
```lua
Signal:Destroy()
```