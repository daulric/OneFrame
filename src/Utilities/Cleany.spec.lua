return function ()
    local Cleany = require(script.Parent:WaitForChild("Cleany"))
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    describe("it should clean modules", function()
        local Cleanup
        local Object = Instance.new("Part")
        local Connection

        it("should create a new clean up module", function()
            Cleanup = Cleany.create()
            expect(Cleanup).to.be.a("table")
            expect(Cleanup).to.be.ok()
        end)

        it("should add connections to the clean up table", function()
            expect(function()
                Connection = Cleanup:Connect(Players.ChildAdded, function(child)
                    print("child added:", child)
                end)

                Cleanup:Connect(Players.ChildRemoved, function(child)
                    print("child removed:", child)
                end)

            end).to.be.ok()
        end)

        it("should add objects", function()
            local added = Cleanup:Add(Object)
            print("Part Join Workspace", added)
            added.Parent = workspace
            expect(added).to.be.ok()
        end)

        it("should remove objects", function()
            expect(function()
                Cleanup:Remove(Object)
                Cleanup:Remove(Connection)
            end).to.be.ok()
        end)

        it("should clean itself", function()
            expect(function()
                Cleanup:Clean()
            end).to.be.ok()
        end)

    end)

end