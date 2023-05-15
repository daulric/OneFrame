# Controllers

## Add Controllers
```lua
Controllers:AddController(path: Instance)
```
This adds controllers to the index to be recognized when using `:GetController`.

## Create Controller
```lua
Controllers:CreateController {
    Name: string,
    [any]: any
}
```

This will create controllers to be used in scripts.

## Get Controller
```lua
Controllers:GetController(name: string)
```

This gets controllers that was created.

## Get Controllers
```lua
Controllers:GetControllers()
```

This will return all the controllers.