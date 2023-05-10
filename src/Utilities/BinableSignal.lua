local Signal = {}
Signal.__index = Signal


function Signal.new()
    local self = setmetatable({}, Signal)
    self._bindable = Instance.new("BindableFunction")
    self._argCount = nil
    self._args = nil

    return self
end

function Signal:Fire(...)
    if self._bindable then
        self._args = {...}
        self._argCount = select("#", ...)
        return self._bindable:Invoke()
    end
end

function Signal:Connect(handler)
    if self._bindable then
        self._bindable.OnInvoke = function()
            return handler(unpack(self._args, 1, self._argCount))
        end
    end
end

function Signal:Destroy()
    if self._bindable then
        self._bindable:Destroy()
        self._bindable = nil
    end

    self._argCount = nil
    self._args = nil
    setmetatable(self, nil)

end

return Signal