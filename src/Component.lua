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

function module:setState(value: any)
	if not self.state then
		warn("there is no state to this component")
		return
	end

	if not table.isfrozen(self.state) and self.state.isState ~= true then
		warn("this table was not properly set!")
		return
	end

	local NewClassState = table.clone(self.state)

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
	self.state = NewClassState
	table.freeze(self.state)
end

function module:require(modulescript: ModuleScript)
	local module = require(modulescript)
	if module.shared then
		local newModule = compile(module)
		return newModule
	end
end

function CheckId(Table: {[string]: any}, name: string)
	if Table[name] then
		return true
	end
end

function Register(class: {[any]: any}, name, Type: RegisterType)
	class.name = name
	class[Type] = true

	if name ~= nil then
		class.name = ""..name
	end

	RegisterSignal:Fire(name)
	
end

function module:extend(name, test)
	-- this here runs the component once
	local class = {}

	if CheckId(LiveClass, name) then
		warn(`{name} already exsist in execution table`)
		return class
	end

	if CheckId(TestClass, name) then
		warn(`{name} already exsist in test table : TEST TABLE WONT RUN IN GAME`)
		return class
	end

	class.state = {}
	table.freeze(class.state)
	class.Cleanup = Cleany.create()
	class.Event = Event
	
	if test == true then
		Register(class, name, "test")
		TestClass[tostring(name)] = class
	else
		Register(class, name, "live")
		LiveClass[tostring(name)] = class
	end

	setmetatable(class, module)

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

return module