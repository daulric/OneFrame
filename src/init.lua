local Utilities = script:WaitForChild("Utilities")
local compile = require(Utilities.compile)
local Help = require(script:WaitForChild("Help"))

local Framework = require(script:WaitForChild("Framework"))

-- @class OneFrame

local OneFrame: Help.Framework = compile({
	Component = require(script:WaitForChild("Component")),
	Start = Framework,
})

return OneFrame