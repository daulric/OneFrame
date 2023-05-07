local Event = {}
local Storage = {}

-- // Services \\ ---
local RunService = game:GetService("RunService")

local RemoteEvent = script:WaitForChild("RemoteEvent")
local RemoteFunction = script:WaitForChild("RemoteFunction")
local BindableEvent = script:WaitForChild("BindableEvent")
local BindableFunction = script:WaitForChild("BindableFunction")

function Event:Listen(id: string, callback: (...any) -> ...any)
    local listener = {}
    listener.__callback = callback

    if not Storage[id] then
        Storage[id] = listener
    else
        warn(`{id} already exsisted`)
    end

    table.freeze(listener)
    return listener
end

function Event.Send(id: string)
    local SendType = {}

    assert(type(id) == "string", `this is not a string; we got a {type(id)}`)

    function SendType:Server(...: any)
        RemoteEvent:FireServer(id, ...)
    end

    function SendType:Client(player: Player, ...: any)
        RemoteEvent:FireClient(player, id, ...)
    end

    function SendType:AllClients(...: any)
        RemoteEvent:FireAllClients(id, ...)
    end

    function SendType:Cross(...: any)
        BindableEvent:Fire(id, ...)
    end

    table.freeze(SendType)
    return SendType
end

function Event.Get(id: string)
    local SendType = {}

    assert(type(id) == "string", `this is not a string; we got a {type(id)}`)

    function SendType:Server(...: any)
        return RemoteFunction:InvokeServer(id, ...)
    end

    function SendType:Client(player: Player, ...: any)
        return RemoteFunction:InvokeClient(player, ...)
    end

    function SendType:Cross(...: any)
        return BindableFunction:Invoke(id, ...)
    end

    table.freeze(SendType)
    return SendType
end

function SuccessfulConnection(id: string)
    local success, connection = pcall(function()
        if Storage[id] then
            return Storage[id]
        end
    end)

    if success then
        return connection
    else
        warn("connection is not valid", `ID: {id}`)
    end

end

function ServerListen(player: Player, id: string, ...)
    local connection = SuccessfulConnection(id)

    if connection and connection.__callback then
        return connection.__callback(player, ...)
    end

end

function ClientListen(id: string, ...)
    local connection = SuccessfulConnection(id)

    if connection and connection.__callback then
        return connection.__callback(...)
    end

end

function CrossListen(id: string, ...)
    local connection = SuccessfulConnection(id)

    if connection and connection.__callback then
        return connection.__callback(...)
    end

end

if RunService:IsServer() then
    RemoteEvent.OnServerEvent:Connect(ServerListen)
    RemoteFunction.OnServerInvoke = ServerListen
end

if RunService:IsClient() then
    RemoteEvent.OnClientEvent:Connect(ClientListen)
    RemoteFunction.OnClientInvoke = ClientListen
end

BindableEvent.Event:Connect(CrossListen)
BindableFunction.OnInvoke = CrossListen

return Event