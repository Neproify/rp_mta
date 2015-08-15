addEvent("spawnPlayer", true)
addEventHandler("spawnPlayer", root, function()
	local charInfo = client:getData("charInfo")
	if not charInfo then
		return
	end
	client:spawn(1481.8495, -1687.1045, 14.0469, 178.7321)
	client:fadeCamera(true)
	client:setCameraTarget(client)
end)