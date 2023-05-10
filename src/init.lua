local Utilities = script:WaitForChild("Utilities")
local Tools = script:WaitForChild("Tools")
local Service = script:WaitForChild("Services")

local compile = require(Tools.compile)

local Framework = require(script:WaitForChild("Framework"))
local Controllers = require(script:WaitForChild("Controllers"))
local Component = require(script:WaitForChild("Component"))

local Packages = script:WaitForChild("Packages")
local Promise = require(Packages.Promise)

local Services = {
	Event = require(Service:WaitForChild("Event")),
	Input = require(Service:WaitForChild("Input")),
}

local Cleany = require(Utilities.Cleany)
local Signal = require(Utilities.Signal)
local BindableSignal = require(Utilities.BinableSignal)

local OneFrame = {
	-- Main Stuff
	Component = Component,
	Start = Framework,
	Controllers = Controllers,

	-- Services!
	Input = Services.Input,
	Event =  Services.Event,
	Promise = Promise,

	-- Utilites!
	CreateCleany = Cleany.create,
	CreateSignal = Signal.new,
	CreateBinableSignal = BindableSignal.new,
}

compile(OneFrame)

return OneFrame