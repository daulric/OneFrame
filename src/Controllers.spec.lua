return function ()
    local Controllers = require(script.Parent:WaitForChild("Controllers"))

    describe("Controllers Component", function()
        it("should add controllers from the path", function()
            local added = Controllers.AddController(game.ReplicatedStorage.Controllers)
            expect(added).to.be.ok()
        end)

        it("should get a controller", function()
            local controller = Controllers.GetController("test")
            expect(controller).to.be.a("table")
            expect(controller:Get()).to.be.ok()
        end)
    end)
end