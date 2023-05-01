local Utilities = script:WaitForChild("Utilities")
local compile = require(Utilities.compile)
local Help = require(script:WaitForChild("Help"))

local Framework = require(script:WaitForChild("Framework"))
local Controllers = require(script:WaitForChild("Controllers"))

local OneFrame: Help.Framework = compile({
	Component = require(script:WaitForChild("Component")),
	Start = Framework,
	Controllers = Controllers
})

return OneFrame