
Sample Code for Functional Components

```lua
return function(render, closing)

    local data = render(function(...)
        local items = {...}
        print(...)
        return items
    end)

    print(data) --> print items in a table

    closing(function()
        print("closing game")
    end)

end
```