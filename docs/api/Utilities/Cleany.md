# Cleany

A Cleaning Service for managing garbage collection and memory leaks

## Contructing a New Cleaner

```lua
Cleany.create() -> Cleaner
```

## Methods

!!! warning "Before Using These Methods"

    Remember to call `.create` before running these methods

### Add
```lua
Cleany:Add(object) -> object
```

This will add any object to the collector and return the object.

### Remove
```lua
Cleany:Remove(object)
```

This will clean and remove the object from the collector.

### Contruct
```lua
Cleany:Contruct(class, ...)
```

This will contruct any function or module and add it to the collector

!!! info "When Using Contruct "

    The module must contain a `.new` function in order for it to work.

### Add Multiple
```lua
Cleany:AddMultiple(...) -> {objects}
```

This will add objects to the collector and it will return a table with the objects.

### Connect
```lua
Cleany:Connect(connection: RBXScriptSignal, callback: (...) -> ()) -> RBXScriptConnection
```

This will add any script connection to the collector to be cleaned.

### Clean
```lua
Cleany:Clean()
```

This will clean and destroy all the items in the collector.

!!! info "About `:Clean`"

    If the items in the collector is an `RBXScriptConnection`, then it will disconnect the event. If the item is an `Instance`, then it will destroy the item. If the item is a `corotine`, it will close the item. If the item is a `modular code`, it will either destroy or disconnect the code, if your code contains either one of the 2 methods