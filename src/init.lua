local compile = require(script:WaitForChild("compile"))
local Help = require(script:WaitForChild("Help"))

local Framework = require(script:WaitForChild("Framework"))

local Compiled: Help.Framework = compile({
	Component = require(script:WaitForChild("Component")),
	Start = Framework
})

if Compiled.Success then
	return Compiled
end
