export type Framework = {
	init: (self: any, ...any) -> (),
	render: (self: any, ...any) -> (),
	preload: (self: any, ...any) -> (),
	closing: (self: any, ...any) -> (),
	live: boolean,
	test: boolean,
	name: string
}

local Packages = script.Parent:WaitForChild("Packages")

local Promise = require(Packages:WaitForChild("Promise"))

local RunService = game:GetService("RunService")

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
			render(scripts, Items)
		else
			warn(err)
		end

	elseif not scripts.preload then
		render(scripts, Items)
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

function messageInfo(ignorePrint, message)
	if not ignorePrint then
		if RunService:IsClient() then
			print(`Client // {message}`)
		elseif RunService:IsServer() then
			print(`Server // {message}`)
		end
	end
end

function Connection(scripts: Framework, scriptName, ...: any)
	local Start = os.clock()

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
		init(scripts, Items)
		task.wait()
		preload(scripts, Items)
	end)

	if scripts.closing and RunService:IsServer() then
		game:BindToClose(function()
			task.spawn(function()
				scripts:closing(Items)
			end)
		end)
	end

	local End = math.ceil(os.clock() - Start)

	return `{name} : Took {End} ms`

end

function MakeAjustment(v, ignorePrint, ...)
	local success, scripts, name = pcall(function()
		local Data: Framework = require(v)
		return Data, Data.name
	end)

	assert(success, `required data could not been executed for {name}`)

	if scripts.test == true then
		if RunService:IsStudio() then
			local message = Connection(scripts, name, ...)
			messageInfo(ignorePrint, message)
		end
	elseif scripts.live then
		local message = Connection(scripts, name, ...)
		messageInfo(ignorePrint, message)
	end

end

function InitFolder(Folder: Instance, ignorePrint, ...: any)

	for i, v in ipairs(Folder:GetDescendants()) do
		local Start = os.clock()

		if v:IsA("ModuleScript") then
			task.spawn(MakeAjustment, v, ignorePrint, ...)
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
	
	local items = unpack({...})

	local Success = Promise.new(function(resolve, reject)
		if typeof(Folder) == "Instance" then
			InitFolder(Folder, ignorePrint, items)
			resolve(items)
		elseif typeof(Folder) == "table" then
			InitTable(Folder, ignorePrint, items)
			resolve(items)
		else
			reject(items)
		end
	end)

	return Success
end

return Framework
