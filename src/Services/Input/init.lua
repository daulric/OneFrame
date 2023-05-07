local RunService = game:GetService("RunService")

if RunService:IsClient() then
    return {
        Keyboard = require(script:WaitForChild("Keyboard")),
        Mouse = require(script:WaitForChild("Mouse"))
    }
end