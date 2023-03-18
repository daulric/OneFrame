local module = {}
module.__index = module

local Signal = require(script.Parent:WaitForChild("Signal"))

local RegisterSignal = Signal.new()

local RegisterClass = {}
local compile = require(script.Parent:WaitForChild("compile"))

type RegisterType = "live" | "test"

function Register(class: {[any]: any}, name, Type: RegisterType)
	class.name = name
	class[Type] = true
	
	if name ~= nil then
		class.name = ""..name
	end
	
	RegisterSignal:Fire(name)
	return class
end


function module:serve(name)
	-- this here runs the component once
	local class = {}
	
	Register(class, name, "live")
	
	table.insert(RegisterClass, class)
	
	return class
end

function module:test(name: any)
	local class = {}
	
	Register(class, name, "test")
	
	table.insert(RegisterClass, class)
	return class
end

function module:GetComponent(name: string)
	if not name then
		return
	end
	
	local ClassGotten

	for i, v in pairs(RegisterClass) do
		if v.name == name then
			ClassGotten = v
			break
		else
			warn("couldn't find", name)
			break
		end
	end

	return ClassGotten
end

function module:GetComponents()

	local success, component = pcall(function()
		return compile(RegisterClass)
	end)

	if success and component.Success then
		return component
	end

end

function module:GetRegisteredSignal(handler)
	RegisterSignal:Connect(handler)
end

local Component = compile(module)

if Component.Success then
	return Component
end