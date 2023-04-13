local Cleany = {}
Cleany.__index = Cleany

function Cleany.create()
    
    return setmetatable({
        _objects = {},
        _cleaning = false
    }, Cleany)
end

function Cleany:Add(object: any)
    if self._cleaning then
        warn("cleaning in proccess")
    end

    table.insert(self._objects, object)

    return object
end

function Cleany:Remove(object: any)
    if self._cleaning then
        warn("cleaning in proccess")
    end

    local findObject = table.find(self._objects, object)
    local obj = self._objects[findObject]

    if findObject and obj then
        if typeof(obj) == "Instance" then
            obj:Destroy()
        elseif typeof(obj) == "RBXScriptConnection" and obj.Connected then
            obj:Disconnect()
        end
        
        table.remove(self._objects, findObject)
    else
        warn("couldn't find", object, "in the cleanup")
    end

end

function Cleany:Connect(Connection: RBXScriptSignal, callback)
    if self._cleaning then
        warn("cleaning in proccess")
    end

    local scriptConnection: RBXScriptConnection = Connection:Connect(callback)
    table.insert(self._objects, scriptConnection)

    return scriptConnection
end

function Clean(self)
    for _, obj in pairs(self._objects) do
        if typeof(obj) == "RBXScriptConnection" and obj.Connected then
            obj:Disconnect()
        elseif typeof(obj) == "Instance" then
            obj:Destroy()
        end
    end
end

function Cleany:Clean()
    if self._cleaning then
        warn("already cleaning")
        return false
    end

    if self then
        self._cleaning = true
        Clean(self)
        table.clear(self._objects)
        self._cleaning = false
        return true
    end
end

return Cleany