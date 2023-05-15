# Component

## Creating a Component

```lua
local myComp = Component:extend(name: string, test: boolean)
```

This will create a component to be run when `.Start` is called
!!! info

    If the `test` param is true then the code will only run in studio and not on the game.

### Main Functions
```lua
function myComp:init(...)
    -- this will initialize the component with variables
end

function myComp:preload(...)
    -- this will preload the code before executing the code
end

function myComp:render(...)
    -- this will execute the code.
end

function myComp:closing(...)
    -- this will run when the game is closing
end
```

## Methods
### State
#### `:setState`
```lua
Component:setState(value: any)
```

This will set the state of the any value

#### `.state`
```lua
Component.state
```

This will return the state what was set

!!! waring "About the State"

    `.state` and `:setState` can only be called when `:extend` is called.
    Example: Within the `:render` code block, you will have something like `self.state` or `self:setState`

## GetComponent
```lua
Component:GetComponent(name) -> {[any]: any}
```

This will return the component with that name from the index.

## Get Components
```lua
Component:GetComponents() -> {[any]: any}
```

This will return all the components in the index

## Get Registered Signal
```lua
Component:GetRegisteredSignal(function(name)
    print(name, "was created!")
end)
```

This will return the name of the component that was created