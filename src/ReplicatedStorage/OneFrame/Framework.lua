export type Framework = {
	render: (self: any, ...any) -> (),
	preload: (self: any, ...any) -> (),
	live: boolean,
	test: boolean,
	name: string
}

local RunService = game:GetService("RunService")
local compile = require(script.Parent:WaitForChild("compile"))

function Connection(scripts: Framework, scriptName, ignorePrint, ...: any)
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
			local success, err = pcall(function()
				task.spawn(function()
					scripts:preload(Items)
				end)
			end)

			if success then
				if not ignorePrint then
					print(`finished preloading {name}`)
				end
			else
				warn(err)
			end

		end

		task.wait()

		if scripts.render then
			local success, err = pcall(function()
				task.spawn(function()
					scripts:render(Items)
				end)
			end)

			if success then
				if not ignorePrint then
					print(`finished rendering {name}`)
				end
			else
				warn(err)
			end

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

function InitClient(Folder: Instance, ignorePrint: boolean, ...: any)
	if RunService:IsClient() then
		return InitFramework(Folder, ignorePrint, ...)
	else
		warn("Cannot Run Modules With Server", Folder.Name)
	end
end

function InitServer(Folder: Instance, ignorePrint: boolean, ...)
	if RunService:IsServer() then
		return InitFramework(Folder, ignorePrint, ...)
	else
		warn("Cannot Run Modules With Client", Folder.Name)
	end
end

local Compiled = compile({
	Client = InitClient,
	Server = InitServer,
})

if Compiled.Success then
	return Compiled
end