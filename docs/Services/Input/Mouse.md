# Mouse

Mouse Module for OneFrame

## Contructing a New Mouse

```lua
Mouse.new() : Mouse
```

## **Methods**

### IsLeftDown

```lua
Mouse:IsLeftDown() : boolean
```
This checks if left mouse click is pressed

### IsRightDown
```lua
Mouse:IsRightDown() : boolean
```
This checks if right mouse click is pressed

### GetDelta
```lua
Mouse:GetDelta()
```
This gets the mouse delta

### GetRay

```lua
Mouse:GetRay(override: Vector2?)
```

This returns a viewpoint ray

### Raycast

```lua
Mouse:Raycast(RaycastParams: RaycastParams, distance: number?, override: Vector2?)
```

This returns a workspace raycast

### Project
```lua
Mouse:Project(distance: number?, override: Vector2?)
```

This project the distance of the mouse

### Lock
```lua
Mouse:Lock()
```

This locks the mouse at its current position on the screen

### LockCenter
```lua
Mouse:LockCenter()
```

This locks the mouse in the center of the screen

### Unlock
```lua
Mouse:Unlock()
```

This unlocks the mouse from the screen

### Destroy
```lua
Mouse:Destroy
```

This destroys the mouse

## **Signals**

Signals are created when `.new` is called

### LeftDown
```lua
Mouse.LeftDown:Connect(function()
    print("left click pressed")
end)
```

This fires when left mouse click is pressed.

### LeftUp
```lua
Mouse.LeftUp:Connect(function()
    print("left click released")
end)
```

### RightDown
```lua
Mouse.RightDown:Connect(function()
    print("right click pressed")
end)
```

This fires when right mouse click is pressed.

### RightUp
```lua
Mouse.RightUp:Connect(function()
    print("right click released")
end)
```

This fires when right mouse click is released.

### Scrolled
```lua
Mouse.Scrolled:Connect(function(pos)
    print("mouse scrolled; current position", pos)
end)
```

This fires when you scroll.