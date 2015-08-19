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
			local name = globalInfo["name"]
			for i,v in ipairs(nearbyPlayers) do
				v:outputChat("#FFFFFF(("..name.."("..source:getData("ID").."): "..oocMsg.."))", 0, 0, 0, true)
			end
			return
		end
		local pos = source.position
		local chatSphere = ColShape.Sphere(pos, 15)
		local nearbyPlayers = chatSphere:getElementsWithin("player")
		msg = string.gsub(msg, "<", "#C2A2DA*")
		msg = string.gsub(msg, ">", "*#FFFFFF")
		local name = source.name
		for i,v in ipairs(nearbyPlayers) do
			v:outputChat("#FFFFFF"..name.." mówi: "..msg, 0, 0, 0, true)
		end
	end
end)

function Player:clearChat()
	local i = 0
	while i < 200 do
		self:outputChat("")
		i = i + 1
	end
end

-- clearChat export
function clearChat(plr)
	plr:clearChat()
end