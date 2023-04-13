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

	function class:setState(value: any)
		if type(value) == "table" then
			for index, stuff in pairs(value) do
				class.state[tostring(index)] = stuff
			end
		elseif type(value) == "function" then
			local newState = value(class.state)

			if type(newState) == "table" then 
				for index, stuff in pairs(newState) do
					class.state[tostring(index)] = stuff
				end
			else
				warn("table didn't return")
			end
		end

		if type(value) ~="function" or type(value) ~="table" then
			warn("only table and function can be used")
		end

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

function module:serve(name)
	-- this here runs the component once
	local class = {}

	if CheckId(LiveClass, name) then
		warn(`{name} already exsist in this table`)
		return class
	end

	Register(class, name, "live")
	LiveClass[tostring(name)] = class

	return class
end

function module:test(name: any)
	local class = {}

	if CheckId(TestClass, name) then
		warn(`{name} already exsist in this table`)
		return class
	end

	Register(class, name, "test")
	TestClass[tostring(name)] = class

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