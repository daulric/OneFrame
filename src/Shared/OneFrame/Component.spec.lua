return function ()
    local Component = require(script.Parent:WaitForChild("Component"))

    describe("Creating OneFrame Component", function()
        it("The Component should create a component that runs when published!", function()
            local New = Component:serve("Hello")
    
            function New:render()
                print("tested!")
            end
    
            function New:preload()
                print("preloading test!")
            end
    
            expect(New).to.be.a("table")
            expect(New).to.ok()
        end)
    
        it("The Component should create a test component that only runs in studio", function()
            local New = Component:test("Hello")
    
            function New:render()
                print("tested!")
            end
    
            function New:preload()
                print("preloading test")
            end
    
            expect(New).to.be.a("table")
            expect(New).to.be.ok()
        end)
    end)


end