local Component = {}
Component.__index = Component

local Utilites = script.Parent:WaitForChild("Utilities")
local Services = script.Parent:WaitForChild("Services")
local Tools = script.Parent:WaitForChild("Tools")

local Help = require(Tools.Help)

local Signal = require(Utilites.Signal)

local RegisterSignal = Signal.new()

-- Different Class
local LiveClass = {}
local TestClass = {}

local Cleany = require(Utilites.Cleany)
local Event = require(Services.Event)

type RegisterType = "live" | "test" | "shared"


function CheckId(Table: {[string]: any}, name: string)
	if Table[name] then
		return true
	end
end

function Component:extend(name: string, test: boolean?): Help.Component

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
	class.name = tostring(name)

	if test then
		class.test = true
		TestClass[tostring(name)] = class
	else
		class.live = true
		LiveClass[tostring(name)] = class
	end

	setmetatable(class, Component)
	RegisterSignal:Fire(name)
	return class
	
end

function Component:setState(value: any)

	assert(self.state, "there is no state to this component")
	assert(table.isfrozen(self.state) or self.state.isState, `this table is not properly set! {self.state}`)

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

function Component:GetComponent(name: string)
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

function Component:GetComponents()
	local Modules = {
		Test = TestClass,
		Live = LiveClass,
	}

	local compiled = table.freeze(table.clone(Modules))

	return compiled
	
end

function Component:GetRegisteredSignal(handler)
	RegisterSignal:Connect(handler)
end

return Component