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
local Players = game:GetService("Players")

local RunService = game:GetService("RunService")
local compile = require(Utilites.compile)

local mainFunctions = {"init", "closing", "preload", "render", "Cleanup", "Event", "live", "test", "shared", "state", "setState", "require", "name", "state", "setState", "require"}

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

function Connection(scripts: Framework, scriptName, ...: any)
	task.wait()
	local Items = table.unpack({...})
	
	local name = ""

	if scripts.name ~= nil and scripts.name ~= "" then
		name = name..scripts.name
	else
		scripts.name = scriptName
		name = name..scriptName
	end

	task.spawn(function()
		-- this is just here to load variables and other stuff
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
	
	end)

	if scripts.closing and RunService:IsServer() then
		game:BindToClose(function()
			task.spawn(function()
				scripts:closing(Items)
			end)
		end)
	end

end

function InitFramework(Folder: Instance, ignorePrint, ...: any)

	for i, v in ipairs(Folder:GetChildren()) do
		local Start = os.clock()

		if v:IsA("ModuleScript") then
			
			local success, scripts, name = pcall(function()
				local Data: Framework = require(v)
				return Data, Data.name
			end)

			if not success then
				warn(`required data could not been executed for {name}`)
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

		elseif v:IsA("Instance") then
			InitFramework(v, ignorePrint, ...)
		end
	end
	
	return true
end

local Compiled = compile({
	Framework = InitFramework
})

if Compiled.Success then
	return Compiled.Framework
end