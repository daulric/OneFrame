return function ()
    local ContextAction = require(script.Parent:WaitForChild("ContextAction"))
    
    describe("it should bind action", function()
        it("should bind an action", function()
            local function handleAction(name, inputState, inputObject)
                if name == "hello" then
    
                    if inputState == Enum.UserInputState.End then
                        print("ending input!")
                    end
    
                    if inputState == Enum.UserInputState.Begin then
                        print("Hello There!")
                    end
                    
                end
    
                if name == "bye" then
                    if inputState == Enum.UserInputState.Begin then
                        print("bye begin!")
                    end
    
                    if inputState == Enum.UserInputState.End then
                        print("bye ended!")
                    end
                end
    
            end
    
            expect(ContextAction:BindAction("hello", handleAction, true, Enum.KeyCode.A, Enum.KeyCode.B, Enum.UserInputType.MouseButton1)).to.never.ok()
        end)


        it("should edit an image", function()
            expect(ContextAction:EditImage("hello", 13420478593)).to.never.be.ok()
        end)

        it("should edit text", function()
            expect(ContextAction:EditText("hello", "idk")).to.never.be.ok()
        end)

        it("should edit property", function()
            expect(
                ContextAction:EditProperty("hello", {
                    -- properties here!
                })
            ).to.never.be.ok()
        end)

        it("should get the button", function()
            local button = ContextAction:GetButton("hello")
            if button then
                expect(button).to.be.ok()
            else
                expect(button).to.never.be.ok()
            end
        end)

        it("should unbind action", function()
            expect(ContextAction:UnbindAction("hello")).to.never.be.ok()
        end)
    end)

end