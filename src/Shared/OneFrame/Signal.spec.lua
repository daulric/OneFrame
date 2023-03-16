return function ()
    local Signal = require(script.Parent:WaitForChild("Signal"))

    describe("Create a Signal Event", function()

        local NewSignal = Signal.new()
        
        it("accept data", function()
            expect(function()
                NewSignal:Connect(function(...)
                    print(...)
                end)
            end).to.be.ok()

        end)

        it("sends data", function()
            expect(function()
                NewSignal:Fire("success")
            end).to.be.ok()

        end)

        it("event waits", function()
            expect(function()
                NewSignal:Wait()
            end).to.be.ok()

        end)

        it("destroy event", function()
            expect(function()
                NewSignal:Destroy()
            end).to.be.ok()

        end)

    end)
end