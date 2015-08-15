addEventHandler("onPlayerChat", root, function(msg, msgType)
	cancelEvent()
	local charInfo = client:getData("charInfo")
	if not charInfo then
		return
	end
	if msgType == 0 then -- normalny chat
		local posX, posY, posZ = client.position
		local chatSphere = Colshape.Sphere(posX, posY, posZ, 15)
		local nearbyPlayers = chatSphere:getElementsWithin("player")
		for i,v in ipairs(nearbyPlayers) do
			local name = client.name
			outputChatBox(name.." mówi: "..msg, v)
		end
	end
end)