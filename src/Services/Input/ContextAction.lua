local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ContextAction = {}

local Utilities = script.Parent.Parent.Parent:WaitForChild("Utilities")
local Cleany = require(Utilities.Cleany)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OFContextAction"

if RunService:IsClient() then
    screenGui.Parent = Players.LocalPlayer.PlayerGui
end

local Actions = {}

local default_properties = {
    Size = UDim2.new(0, 80, 0, 80),
    Position = UDim2.new(0.89, 0,0.498, 0)
}

function createButton(name)
    local button = Instance.new("ImageButton", screenGui)
    button.Name = name
    button.Image = `rbxassetid://{13420116154}`
    button.Size = default_properties.Size
    button.Position = default_properties.Position
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    return button
end

function createTextLabel(name)
    local textlabel = Instance.new("TextLabel")
    textlabel.Name = "OneFrame TextLabel"
    textlabel.Text = name
    textlabel.Size = default_properties.Size
    --textlabel.TextScaled = true
    textlabel.RichText = true
    textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textlabel.BackgroundTransparency = 1
    return textlabel
end

function ContextAction:BindAction(name: string, func, touchButton: boolean, ...)
    assert(Actions[name] == nil, `the context action already exsists; Name: {name}`)

    local itemsToStore = {}
    itemsToStore._cleany = Cleany.create()

    local keys = {...}

    if UserInputService.TouchEnabled then
        if touchButton == true then

            local button = createButton(name)
            itemsToStore.button = button

            local uicorner = Instance.new("UICorner", button)
            uicorner.CornerRadius = UDim.new(1, 0)

            local function Action(input)
                local inputState = input.UserInputState
                func(name, inputState, input)
            end

            itemsToStore._cleany:Connect(button.InputBegan, Action)
            itemsToStore._cleany:Connect(button.InputEnded, Action)
            

            local textlabel = createTextLabel(name)
            textlabel.Parent = button

            local UIAspectRatio = Instance.new("UIAspectRatioConstraint", textlabel)
            UIAspectRatio.AspectType = Enum.AspectType.ScaleWithParentSize

            local textscale = Instance.new("UITextSizeConstraint", textlabel)
            textscale.MinTextSize = 20
            textscale.MaxTextSize = 20

            itemsToStore.textlabel = textlabel

            itemsToStore._cleany:AddMultiple(button, textlabel, uicorner, UIAspectRatio) -- items for the button!

        end
    end

    if RunService:IsClient() then
        ContextActionService:BindAction(name, func, false, unpack(keys))
    end

    Actions[name] = itemsToStore
end

function ContextAction:EditImage(name: string, id: number)
    if Actions[name].button then
        Actions[name].textlabel.TextTransparency = 1
        Actions[name].button.ImageTransparency = 0
        Actions[name].button.Image = `rbxassetid://{id}`
    end
end

function ContextAction:EditText(name: string, text: string)
    if Actions[name].textlabel then
        Actions[name].button.ImageTransparency = 1
        Actions[name].textlabel.TextTransparency = 0
        Actions[name].textlabel.Text = `<b>{text}</b>`
    end
end

function ContextAction:EditProperty(name: string, properties)
    properties = properties or {}

    local button = Actions[name].button

    if button then

        for index, property in pairs(properties) do
            task.spawn(function()
                if typeof(button[index]) ~= "RBXScriptSignal" then
                    button[index] = property
                end
            end)
        end
    end

end

function ContextAction:GetButton(name: string)
    if Actions[name].button then
        return Actions[name].button
    end
end

function ContextAction:UnbindAction(name: string)
    Actions[name]._cleany:Clean()
    ContextActionService:UnbindAction(name)
    Actions[name] = nil
end

return ContextAction