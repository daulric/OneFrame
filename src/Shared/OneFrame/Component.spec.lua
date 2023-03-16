return function ()
    local Component = require(script.Parent:WaitForChild("Component"))

    describe("Creating OneFrame Component", function()
        it("The Component should create a component that runs when published!", function()
            local New = Component:serve("live")
    
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
            local New = Component:test("test")
    
            function New:render()
                print("tested!")
            end
    
            function New:preload()
                print("preloading test")
            end
    
            expect(New).to.be.a("table")
            expect(New).to.be.ok()
        end)

        it("return all components", function()
            local Components = Component:GetComponents()
            expect(Components).to.be.a("table")
            expect(Components).to.be.ok()
        end)

        it("return a particular component", function()

            expect(function()
                local liveComponent = Component:GetComponent("live")
                expect(liveComponent).to.be.a("table")
            end).to.be.ok()

            expect(function()
                local testComponent = Component:GetComponent("test")
                expect(testComponent).to.be.a("table")
            end).to.be.ok()

        end)

    end)


end