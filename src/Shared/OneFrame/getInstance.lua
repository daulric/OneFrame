-- this returns file path used in debug.traceback() function

return function()
    local path = debug.traceback()
	local Split = string.split(path, ":")[3]
	local MessageGet = string.split(Split, " ")[3]
	local RawMessage = string.split(MessageGet, " ")[1]
	local RawFilePath = string.split(RawMessage, "InitClient\n")[2]
	local FilePath = string.split(RawFilePath, ".")

	local Script = game
	
	for index, value in pairs(FilePath) do
		Script = Script[value]
	end	
	
	return Script
end