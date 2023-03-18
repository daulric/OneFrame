return function ()
    local compile = require(script.Parent:WaitForChild("compile"))

    describe("Should Compile the Table", function()

        local compiled = compile({
            Hello = 10,
            Hi = 10
        })

        it("should compile the table", function()
            expect(compiled).to.be.ok()
            expect(compiled.Success).to.be.ok()
        end)
    end)

end