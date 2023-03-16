return function ()
    local Signal = require(script.Parent:WaitForChild("Signal"))

    describe("Create a Signal Event", function()
        FOCUS()

        local NewSignal = Signal.new()
        
        it("accept data", function()
            NewSignal:Connect(function(...)
                print(...)
            end)

            expect(NewSignal).to.be.ok()
        end)

        it("sends data", function()
            NewSignal:Fire("success")
            expect(NewSignal).to.be.ok()
        end)

        it("event waits", function()
            local wait = NewSignal:Wait()
            expect(wait).to.be.ok()
        end)

        it("destroy event", function()
            NewSignal:Destroy()
            expect(NewSignal).to.be.equal(nil)
        end)

    end)
end