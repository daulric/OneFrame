export type Framework = {
	init: (self: any, ...any) -> (),
	render: (self: any, ...any) -> (),
	preload: (self: any, ...any) -> (),
	closing: (self: any, ...any) -> (),
	live: boolean,
	test: boolean,
	name: string
} | (...any) -> ()

local Packages = script.Parent:WaitForChild("Packages")

hello = "heh"

local Promise = require(Packages:WaitForChild("Promise"))

local RunService = game:GetService("RunService")

function render(scripts, ...)
	if scripts.render then
		local success, err = pcall(function(...)
			task.spawn(scripts.render, scripts, ...)
		end, ...)
		
		if not success then
			warn(err)
		end

	end
end

function preload(scripts, ...)
	if scripts.preload then
		local preloadSuccess, err = pcall(function(...)
			task.spawn(scripts.preload, scripts, ...)
		end, ...)

		if not preloadSuccess then
			warn(err)
		end

	end
end

function init(scripts, ...)
	if scripts.init then
		local initSuccess, err = pcall(function(...)
			task.spawn(scripts.init, scripts, ...)
		end, ...)
	
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
	
	local name = ""

	assert(type(scripts) == "table" or type(scripts) == "function", `this is not a table or a function; we got a {type(scripts)}`)

	if typeof(scripts) == "table" then

		if scripts.name ~= nil and scripts.name ~= "" then
			name = name..scripts.name
		else
			scripts.name = scriptName
			name = scriptName
		end
	
		task.spawn(function(...)
			-- this is just here to load variables and other stuff
			init(scripts, ...)
			task.wait()
			preload(scripts, ...)
			task.wait()
			render(scripts, ...)
		end, ...)
	
		if scripts.closing and RunService:IsServer() then
			game:BindToClose(function()
				task.spawn(scripts.closing, scripts)
			end)
		end
	end

	if typeof(scripts) == "function" then
		name = scriptName

		local items = {...}
		local count = select("#", ...)

		local function renderFunc (callback)
			return callback(unpack(items, 1, count))
		end

		local function closingFunc(callback)
			game:BindToClose(function()
				callback(unpack(items, 1, count))
			end)
		end

		task.spawn(scripts, renderFunc, closingFunc)

	end

	local End = os.clock() - Start

	return `{name} : Took {End} ms`

end

function MakeAjustment(v, ignorePrint, ...)

	local success, scripts: Framework, name = pcall(function()
		local Data = require(v)

		if type(Data) == "table" then
			return Data, Data.name
		end

		if type(Data) == "function" then
			return Data, v.Name
		end
		
	end)

	assert(success, `data could not execute for {name or v.Name}`)

	if type(scripts) == "table" then

		if scripts.test == true then
			if RunService:IsStudio() then
				local message = Connection(scripts, name, ...)
				messageInfo(ignorePrint, message)
			end
		elseif scripts.live == true then
			local message = Connection(scripts, name, ...)
			messageInfo(ignorePrint, message)
		end

	end

	if type(scripts) == "function" then
		local message = Connection(scripts, name, ...)
		messageInfo(ignorePrint, message)
	end

end

function InitFolder(Folder: Instance, ignorePrint, ...: any)

	for _, v in ipairs(Folder:GetDescendants()) do
		if v:IsA("ModuleScript") then
			task.spawn(MakeAjustment, v, ignorePrint, ...)
		end
	end
end

function InitTable(Table, ignorePrint, ...)
	for _, Instances in pairs(Table) do
		if typeof(Instances) == "Instance" then 
			InitFolder(Instances, ignorePrint, ...)
		elseif typeof(Instances) == "table" then 
			InitTable(Instances, ignorePrint, ...)
		end
	end
end

type folder = Instance | {[any]: any}

function Framework(Folder: folder, ignorePrint: boolean?, ...: any)

	local items = {...}
	local count = select("#", ...)

	local Success = Promise.new(function(resolve, reject)
		if typeof(Folder) == "Instance" then
			InitFolder(Folder, ignorePrint, unpack(items, 1, count))
			resolve(items)
		elseif typeof(Folder) == "table" then
			InitTable(Folder, ignorePrint, unpack(items, 1, count))
			resolve(items)
		else
			reject(items)
		end

	end)

	return Success
end

return Framework
