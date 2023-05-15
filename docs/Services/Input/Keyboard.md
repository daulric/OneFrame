# Keyboard

Keyboard module for OneFrame

## Contructing a New Keyboard

```lua
Keyboard.new() : Keyboard
```
This contructs a new keyboard

## **Methods**

!!! warning "Before Using These Methods"

    Remember to call `.new` before using these methods, otherwise the code won't work.

### :IsKeyDown

```lua
Keyboard:IsKeyDown(key: Enum.KeyCode) : boolean
```
This checks if a particular key is down

### :AreKeysDown

```lua
Keyboard:AreKeysDown(key1: Enum.KeyCode, key2: Enum.KeyCode) : boolean
```

This checks if both of the keys are down

### :IsEitherKeyDown
```lua
Keyboard:IsEitherKeyDown(key1: Enum.KeyCode, key2: Enum.KeyCode) : boolean
```

This checks if either one of the keys are down

### Create Combination
```lua
Keyboard:CreateCombination(name, ...)
```

This creates a keybind combination system

### Dismantle Combination
```lua
Keyboard:DismantleCombination(name)
```

This destroys combinations that was created.

### Destory

```lua
Keyboard:Destroy()
```

This destroys the keyboard

## **Signals**
Signals are created when `.new` is called.

### keydown

```lua
Keyboard.keydown:Connect(function(key)
    print("key pressed", key)
end)
```
This listens for key that was pressed

### keyup

```lua
Keyboard.keyup:Connect(function(key)
    print("key released", key)
end)
```
This listens for key that was released

### conbination
```lua
Keyboard.combination:Connect(function(name)
    print(`combination called: {name}`)
end)
```

This listens and execute combination that was created!