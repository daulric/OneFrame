return function ()
    local Framework = require(script.Parent:WaitForChild("Framework"))
    local RunService = game:GetService("RunService")

    describe("OneFrame Framework Component", function()
        it("should run the script", function()
            local testFolder = script.Parent.Parent:WaitForChild("Test")

            if RunService:IsServer() then
                local Start = Framework.Server(testFolder)

                expect(Start).to.be.a("boolean")
                expect(Start).to.be.ok() 
            end

            if RunService:IsClient() then
                local Start = Framework.Client(testFolder)

                expect(Start).to.be.a("boolean")
                expect(Start).to.be.ok()
            end
            
        end)
    end)

end