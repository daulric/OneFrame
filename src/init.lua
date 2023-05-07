local Utilities = script:WaitForChild("Utilities")
local Tools = script:WaitForChild("Tools")

local compile = require(Tools.compile)
local Help = require(Tools.Help)

local Framework = require(script:WaitForChild("Framework"))
local Controllers = require(script:WaitForChild("Controllers"))

local Services = script:WaitForChild("Services")

local OneFrame = {
	Component = require(script:WaitForChild("Component")),
	Start = Framework,
	Controllers = Controllers,
	Utils = Utilities,
	Services = Services
}

compile(OneFrame)

return OneFrame