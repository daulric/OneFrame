return function ()
    local BindableSignal = require(script.Parent:WaitForChild("BinableSignal"))

    describe("Binable Signal Events", function()
        local signal = BindableSignal.new()

        expect(signal).to.be.ok()

        it("should listen for signals to return", function()
            expect(signal:Connect(function(...)
                print("got data items:", ...)
                return true
            end)).to.never.ok()
        end)

        it("should send and return data", function()
            local get = signal:Fire("hello")
            expect(get).to.be.ok()
        end)

    end)
end