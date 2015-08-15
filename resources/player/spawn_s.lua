addEvent("spawnPlayer", true)
addEventHandler("spawnPlayer", root, function()
	local globalInfo = client:getData("globalInfo")
	local charInfo = client:getData("charInfo")
	if not globalInfo or not charInfo then
		return
	end
	--[[spawnPlayer(client, 1481.8495, -1687.1045, 14.0469, 178.7321)
	fadeCamera(client, true)
	setCameraTarget(client, client)--]]
	client:spawn(1481.8495, -1687.1045, 14.0469, 178.7321)
	client:fadeCamera(true)
	client:setCameraTarget(client)
end)