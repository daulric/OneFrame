return function(render, closing)

    render(function(...)
        local items = {...}
        local message = `render is working; values provided was {table.concat(items, " ")}`
        print(message)
        return message
    end)

    render(function()
        print("can also render another function!")
    end)

    closing(function()
        print("closing the game; its working!")
    end)

end