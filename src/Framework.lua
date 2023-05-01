export type Framework = {
	init: (self: any, ...any) -> (),
	render: (self: any, ...any) -> (),
	preload: (self: any, ...any) -> (),
	closing: (self: any, ...any) -> (),
	live: boolean,
	test: boolean,
	name: string
}

local Utilites = script.Parent:WaitForChild("Utilities")
local Tools = script.Parent:WaitForChild("Tools")

local RunService = game:GetService("RunService")
local compile = require(Tools.compile)

function render(scripts, Items)

	if scripts.render then
		local renderSuccess, err = pcall(function()
			task.spawn(function()
				scripts:render(Items)
			end)
		end)

		if not renderSuccess then
			warn(err)
		end

	end
end

function preload(scripts, Items)
	if scripts.preload then
		local preloadSuccess, err = pcall(function()
			task.spawn(function()
				scripts:preload(Items)
			end)
		end)

		if preloadSuccess then
			task.spawn(render, scripts, Items)
		else
			warn(err)
		end

	elseif not scripts.preload then
		task.spawn(render, scripts, Items)
	end
end

function init(scripts, Items)
	if scripts.init then
		local initSuccess, err = pcall(function()
			task.spawn(function()
				scripts:init(Items)
			end)
		end)
	
		if not initSuccess then
			warn(err)
		end
	
	end
end

function Connection(scripts: Framework, scriptName, ...: any)
	task.wait()
	local Items = table.unpack({...})
	
	local name = ""

	if scripts.name ~= nil and scripts.name ~= "" then
		name = name..scripts.name
	else
		scripts.name = scriptName
		name = scriptName
	end

	task.spawn(function()
		-- this is just here to load variables and other stuff
		task.spawn(init, scripts, Items)
		task.wait()
		task.spawn(preload, scripts, Items)
	end)

	if scripts.closing and RunService:IsServer() then
		game:BindToClose(function()
			task.spawn(function()
				scripts:closing(Items)
			end)
		end)
	end

end

function makeAjustment(v, ignorePrint, Start, ...)
	local success, scripts, name = pcall(function()
		local Data: Framework = require(v)
		return Data, Data.name
	end)

	if not success then
		warn(`required data could not been executed for {name}`)
		return
	end
	
	if scripts.test == true then
		if RunService:IsStudio() then
			Connection(scripts, name, ...)
		end
	else
		Connection(scripts, name, ...)
	end

	if not ignorePrint then
		local End = math.ceil(os.clock() - Start)
		local message = `{name} : Took {End} ms`

		if RunService:IsClient() then
			print(`Client // {message}`)
		elseif RunService:IsServer() then
			print(`Server // {message}`)
		end
	end
end

function InitFolder(Folder: Instance, ignorePrint, ...: any)

	for i, v in ipairs(Folder:GetDescendants()) do
		local Start = os.clock()

		if v:IsA("ModuleScript") then
			task.spawn(makeAjustment, v, ignorePrint, Start, ...)
		end
	end
end

function InitTable(Table, ignorePrint, ...)
	for _, Instances in pairs(Table) do
		if typeof(Instances) == "Instance" then 
			InitFolder(Instances, ignorePrint, ...)
			return
		end

		if typeof(Instances) == "table" then 
			InitTable(Instances, ignorePrint, ...)
		end
	end
end

function Framework(Folder: Instance | {[any]: any}, ignorePrint, ...: any)
	if typeof(Folder) == "Instance" then 
		InitFolder(Folder, ignorePrint, ...)
		return true
	end

	if typeof(Folder) == "table" then
		InitTable(Folder, ignorePrint, ...)
		return true
	end
end

return Framework
