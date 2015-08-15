addEventHandler("onPlayerChat", root, function(msg, msgType)
	cancelEvent()
	local charInfo = source:getData("charInfo")
	if not charInfo then
		return
	end
	if msgType == 0 then -- normalny chat
		local posX, posY, posZ = source.position
		local chatSphere = Colshape.Sphere(posX, posY, posZ, 15)
		local nearbyPlayers = chatSphere:getElementsWithin("player")
		for i,v in ipairs(nearbyPlayers) do
			local name = source.name
			outputChatBox(name.." mówi: "..msg, v)
		end
	end
end)