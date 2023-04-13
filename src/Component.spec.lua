return function ()
	local Component = require(script.Parent:WaitForChild("Component"))

    describe("Component Module", function()

        it("The Component should create a component that runs when published!", function()
            local New = Component:serve("live")
    
            expect(New).to.be.a("table")
            expect(New).to.ok()

            it("should set state", function()
                New:setState({
                    Money = 10
               }) 
               
               expect(New.state).to.be.a("table")
               expect(New.state.Money).to.be.equal(10)

            end)

            it("should update the state", function()
                New:setState(function(state)
                    state.Money = 80
                    return state
                end)

                expect(New.state.Money).to.never.equal(10)
            end)

            it("should add stuff in the state", function()
                New:setState({
                    Token = 90
                })

                print("Money:", New.state.Money, "\nToken:", New.state.Token)
                expect(New.state.Money).to.be.ok()
                expect(New.state.Token).to.be.ok()
            end)

            it("should throw error to stop individual values", function()
                expect(New:setState(10)).to.throw()
            end)

            it("should require a component", function()
                local moduleComponent = New:require(script.Parent.Parent:WaitForChild("component_require"))
                expect(moduleComponent).to.be.a("table")
                expect(moduleComponent).to.be.ok()

                it("should say and execute all the functions", function()
					for index, val in pairs(moduleComponent) do
						if type(val) == "function" then
                            print(index, ":", val)
                            val()
                        end
                    end
                end)

            end)

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

        it("should create a module component", function()
            local createComponent = Component:createComponent("test_module")
            print("Component Created!", createComponent)
            expect(createComponent).to.be.a("table")
            expect(createComponent).to.be.ok()
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