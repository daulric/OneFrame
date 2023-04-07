export type Framework = {
	render: (self: any, ...any) -> (),
	preload: (self: any, ...any) -> (),
	live: boolean,
	test: boolean,
	name: string
}
local Players = game:GetService("Players")

local RunService = game:GetService("RunService")
local compile = require(script.Parent:WaitForChild("compile"))

function render(scripts, name, ignorePrint, Items)
	local Start = os.clock()
	if scripts.render then
		local renderSuccess, err = pcall(function()
			task.spawn(function()
				scripts:render(Items)
			end)
		end)

		if renderSuccess then
			local End = math.ceil(os.clock() - Start)
			if not ignorePrint then
				print(`finished rendering {name} : took {End} ms`)
			end
		else
			warn(err)
		end

	end
end

function Connection(scripts: Framework, scriptName, ignorePrint, ...: any)
	local Start = os.clock()
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
		
		if scripts.preload then
			local preloadSuccess, err = pcall(function()
				task.spawn(function()
					scripts:preload(Items)
				end)
			end)

			if preloadSuccess then
				local End = math.ceil(os.clock() - Start)

				if not ignorePrint then
					local message = `Preloading {name} took {End} ms`
					
					if RunService:IsClient() then
						print(`Client // {message}`)
					elseif RunService:IsServer() then
						print(`Server // {message}`)
					end
				end

				task.spawn(render, scripts, name, ignorePrint, Items)
			else
				warn(err)
			end

		end

		if not scripts.preload then
			task.spawn(render, scripts, name, ignorePrint, Items)
		end

	end)

end

function InitFramework(Folder: Instance, ignorePrint, ...: any)

	for i, v in ipairs(Folder:GetChildren()) do

		if v:IsA("ModuleScript") then
			
			local success, scripts: Framework, name = pcall(function()
				return require(v), v.Name
			end)

			if not success then
				warn(`required data could not been executed for {name}`)
				return
			end

			if scripts.live then
				Connection(scripts, name, ignorePrint, ...)
			elseif scripts.test then
				if RunService:IsStudio() then
					Connection(scripts, name, ignorePrint, ...)
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