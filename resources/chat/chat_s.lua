addEventHandler("onPlayerChat", root, function(msg, msgType)
	cancelEvent()
	local charInfo = source:getData("charInfo")
	local globalInfo = source:getData("globalInfo")
	if not charInfo then
		return
	end
	if msgType == 0 then -- normalny chat
		if string.sub(msg, 1, 1) == "." then -- chat ooc
			local pos = source.position
			local chatSphere = ColShape.Sphere(pos, 15)
			local nearbyPlayers = chatSphere:getElementsWithin("player")
			local oocMsg = string.sub(msg, 2)
			for i,v in ipairs(nearbyPlayers) do
				local name = globalInfo["name"]
				v:outputChat("#FFFFFF(("..name..": "..oocMsg.."))", 0, 0, 0, true)
			end
			return
		end
		local pos = source.position
		local chatSphere = ColShape.Sphere(pos, 15)
		local nearbyPlayers = chatSphere:getElementsWithin("player")
		for i,v in ipairs(nearbyPlayers) do
			local name = source.name
			v:outputChat("#FFFFFF"..name.." mówi: "..msg, 0, 0, 0, true)
		end
	end
end)