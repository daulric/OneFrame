local Utilities = script:WaitForChild("Utilities")
local Tools = script:WaitForChild("Tools")

local compile = require(Tools.compile)
local Help = require(Tools.Help)

local Framework = require(script:WaitForChild("Framework"))
local Controllers = require(script:WaitForChild("Controllers"))

local OneFrame = {
	Component = require(script:WaitForChild("Component")),
	Start = Framework,
	Controllers = Controllers,
	Utils = Utilities
}

return OneFrame