# Functional Component

This is where we create component in a module based on functions

```lua
return function (render, closing)

    local hello = render(function(...)
        print(...) --> Variable from .Start
        return true
    end)

    print(hello) --> this will pring true

    closing(function()
        print("game is closing")
    end)

    -- this will run when the game is shutting down

end
```