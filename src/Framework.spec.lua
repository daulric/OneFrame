return function ()
    local Framework = require(script.Parent:WaitForChild("Framework"))

    describe("Framework Component", function()
        local testFolder = game:GetService("ReplicatedStorage"):WaitForChild("Test")

        it("Components Should Run", function()
            local Start = Framework(testFolder)

            expect(Start).to.be.a("boolean")
            expect(Start).to.be.ok() 
        end)

        it("should collect and run instances from a table", function()
            local testFolder = {
                game:GetService("ReplicatedStorage"):WaitForChild("TestInTable")
            }

            local Start = Framework(testFolder)
            expect(Start).to.be.a("boolean")
            expect(Start).to.be.ok()
        end)

    end)

end