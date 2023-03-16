local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEz = require(ReplicatedStorage:WaitForChild("TestEz"))

local Reporter = TestEz.TextReporter

local roots = {
    ReplicatedStorage:WaitForChild("OneFrame")
}

TestEz.TestBootstrap:run(roots, Reporter)