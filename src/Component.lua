local module = {}
module.__index = module

local Utilites = script.Parent:WaitForChild("Utilities")
local Services = script.Parent:WaitForChild("Services")

local Signal = require(Utilites.Signal)

local RegisterSignal = Signal.new()

-- Different Class
local LiveClass = {}
local TestClass = {}

local compile = require(Utilites.compile)
local Cleany = require(Utilites.Cleany)
local Event = require(Services.Event)

type RegisterType = "live" | "test" | "shared"

function Register(class: {[any]: any}, name, Type: RegisterType)
	class.name = name
	class[Type] = true

	class.state = {}
	class.state.isState = true
	table.freeze(class.state)

	function class:setState(value: any)
		if not table.isfrozen(class.state) and class.state.isState ~= true then
			warn("this table was not properly set!")
			return
		end

		local NewClassState = table.clone(class.state)

		if type(value) == "table" then
			for index, stuff in pairs(value) do
				NewClassState[tostring(index)] = stuff
			end
		elseif type(value) == "function" then
			local newState = value(NewClassState)

			if type(newState) == "table" then 
				for index, stuff in pairs(newState) do
					NewClassState[tostring(index)] = stuff
				end
			else
				table.insert(NewClassState, value)
			end
		end

		NewClassState.isState = true
		class.state = NewClassState
		table.freeze(class.state)
	end

	function class:require(modulescript: ModuleScript)
		local module = require(modulescript)
		if module.shared then
			local newModule = compile(module)
			return newModule
		end
	end

	if name ~= nil then
		class.name = ""..name
	end
	
	class.Cleanup = Cleany.create()
	class.Event = Event

	if Type ~= "shared" then
		RegisterSignal:Fire(name)
	end
	
end

function CheckId(Table: {[string]: any}, name: string)
	if Table[name] then
		return true
	end
end

function module:extend(name, test)
	-- this here runs the component once
	local class = {}

	if CheckId(LiveClass, name) then
		warn(`{name} already exsist in this table`)
		return class
	end

	if test == true then
		Register(class, name, "test")
		TestClass[tostring(name)] = class
	else
		Register(class, name, "live")
		LiveClass[tostring(name)] = class
	end

	return class
	
end

function module:createComponent()
	local class = {}
	class.shared = true
	class.Cleanup = Cleany.create()
	class.Event = Event

	return class
end

function module:GetComponent(name: string)
	if not name then
		return
	end
	
	if LiveClass[name] then
		return LiveClass[name]
	end

	if TestClass[name] then
		return TestClass[name]
	end

end

function module:GetComponents()
	local Modules = {
		Test = TestClass,
		Live = LiveClass,
	}

	local compiled = compile(Modules)

	if compiled.Success then
		return compiled
	end
	
end

function module:GetRegisteredSignal(handler)
	RegisterSignal:Connect(handler)
end

local Component = compile(module)

if Component.Success then
	return Component
end