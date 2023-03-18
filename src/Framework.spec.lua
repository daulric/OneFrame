return function ()
    local Framework = require(script.Parent:WaitForChild("Framework"))
    local RunService = game:GetService("RunService")

    describe("Framework Component", function()
        local testFolder = script.Parent.Parent:WaitForChild("Test")

        it("Server Components Running", function()
            if RunService:IsServer() then
                local Start = Framework.Server(testFolder)

                expect(Start).to.be.a("boolean")
                expect(Start).to.be.ok() 
            end
        end)

        it("Client Components Running", function()
            if RunService:IsClient() then
                local Start = Framework.Client(testFolder)

                expect(Start).to.be.a("boolean")
                expect(Start).to.be.ok()
            end
        end)

    end)

end