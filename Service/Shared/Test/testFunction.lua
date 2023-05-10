return function(render)

    render(function(...)
        local items = {...}
        local message = `render is working; values provided was {table.concat(items, " ")}`
        print(message)
        return message
    end)

    render(function()
        print("can also render another function!")
    end)

end