return function ()
    local Framework = require(script.Parent:WaitForChild("Framework"))

    describe("Framework Component", function()
        local testFolder = script.Parent.Parent:WaitForChild("Test")

        it("Components Should Run", function()
            local Start = Framework(testFolder)

            expect(Start).to.be.a("boolean")
            expect(Start).to.be.ok() 
        end)

    end)

end