addCommandHandler("character", function(cmd, uid)
	if not uid then
	end
	local globalInfo = localPlayer:getData("globalInfo")
	if not globalInfo then
		return
	end

end)

addEvent("onCharactersFetched", true)
addEventHandler("onCharactersFetched", root, function()
	local characters = localPlayer:getData("characters")
	localPlayer:outputChat("==== TWOJE POSTACIE ====")
	for i,v in ipairs(characters) do
		localPlayer:outputChat("UID: ".. v["UID"] ..", name: "..v["name"].."")
	end
	localPlayer:outputChat("Użyj /character [UID] by wybrać jedną z postaci.")
end)

addEvent("onCharacterSelected", true)
addEventHandler("onCharacterSelected", root, function()
	local charInfo = localPlayer:getData("charInfo")
	if not charInfo then
		return
	end
	localPlayer:outputChat("Postać wybrana")
end)