return function ()
    local Event = require(script.Parent:WaitForChild("Event"))
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    describe("Event Service", function()
        it("should listen for signals", function()
            expect(function()
                Event:Listen("test", function(...)
                    print(...)
                    return ...
                end)
            end).to.be.ok()
        end)

        it("should create a send signal", function()
            local TestSend = Event.Send("test")
            expect(TestSend).to.be.a("table")

            if RunService:IsServer() then
                it("should send info to the client", function()
                    
                    expect(function()
                        TestSend:AllClients("hello", "idk")
                    end).to.be.ok()

                    Players.PlayerAdded:Once(function(player)
                        expect(function()
                            TestSend:Client(player, "hello", "idk")
                        end).to.be.ok()
                    end)

                end)
            end

            if RunService:IsClient() then
                it("should send info to the server", function()
                    expect(function()
                        TestSend:Server("hello", "idk")
                    end).to.be.ok()
                end)
            end

        end)

        it("should create a return signal",  function()
            local TestGet = Event.Get("test")
            expect(TestGet).to.be.a("table")

            if RunService:IsServer() then
                it("should get info from the client", function()
                    Players.PlayerAdded:Once(function(player)
                        local TestReturn = TestGet:Client(player, "idk", "hello")
                        expect(TestReturn).to.be.ok()
                    end)
                end)
            end

            if RunService:IsClient() then
                it("should retun info from the server", function()
                    repeat task.wait() until Players.LocalPlayer

                    local TestReturn = TestGet:Server("idk", "hello")
                    expect(TestReturn).to.throw(nil)
                    
                end)
            end

        end)
        
    end)

end