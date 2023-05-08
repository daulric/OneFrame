local Utilities = script:WaitForChild("Utilities")
local Tools = script:WaitForChild("Tools")
local Service = script:WaitForChild("Services")

local compile = require(Tools.compile)

local Framework = require(script:WaitForChild("Framework"))
local Controllers = require(script:WaitForChild("Controllers"))
local Packages = script:WaitForChild("Packages")

local Services = {
	Event = require(Service:WaitForChild("Event")),
	Input = require(Service:WaitForChild("Input")),
}

local Utils = {
	Signal = require(Utilities:WaitForChild("Signal")),
	Cleany = require(Utilities:WaitForChild("Signal"))
}

local OneFrame = {
	Component = require(script:WaitForChild("Component")),
	Start = Framework,
	Controllers = Controllers,
	Utils = Utils,
	Services = Services,
	Promise = require(Packages.Promise)
}

compile(OneFrame)

return OneFrame