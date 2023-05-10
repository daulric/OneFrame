local RunService = game:GetService("RunService")
local OneFrame = require(game.ReplicatedStorage.OneFrame)

local New = OneFrame.Component:extend("Hello")

function New:init()
	
	self.part = self.Cleanup:Add(Instance.new("Part"))
	print("Part Name:", self.part.Name)
	print("initializing")
	
	self.Event:Listen("idk", function(...)
		print(...)
		return ...
	end)

	self.part.Parent = workspace
end

function New:preload(...)
	
	self.Cleanup:Connect(workspace.ChildAdded, function(child)
		print("cleaning connection working: child added to workspace", child)
	end)

	print(...)

    print("preloading")
end

function New:render(...)
	print("working")
	local Send = self.Event.Send("idk")
	local Get = self.Event.Get("idk")
	Send:Cross("idk", 1+ 1)
	print("items:", ...)
	print(Get:Cross("hello", "idk"))
	self.Cleanup:Remove(self.part)
end

function New:closing()
	local success = self.Cleanup:Clean()

	if success then
		print("clean up was successful")
	end

end
 
return New