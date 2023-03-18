local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TestEz = require(ReplicatedStorage:WaitForChild("TestEz"))

local TestLocations = {
    ReplicatedStorage:WaitForChild("OneFrame"),
}

local reporter = TestEz.Reporters.TextReporter

TestEz.TestBootstrap:run(TestLocations, reporter)