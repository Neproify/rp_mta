addCommandHandler("character", function(cmd, UID)
	if not UID then
	end
	local globalInfo = localPlayer:getData("globalInfo")
	if not globalInfo then
		return
	end
	triggerServerEvent("selectCharacter", localPlayer, UID)
end)

addEvent("onCharactersFetched", true)
addEventHandler("onCharactersFetched", root, function()
	local characters = localPlayer:getData("characters")
	exports.chat:clearChat()
	outputChatBox("==== TWOJE POSTACIE ====")
	for i,v in ipairs(characters) do
		outputChatBox("UID: ".. v["UID"] ..", name: "..v["name"].."")
	end
	outputChatBox("Użyj /character [UID] by wybrać jedną z postaci.")
end)

addEvent("onCharacterSelected", true)
addEventHandler("onCharacterSelected", root, function()
	local charInfo = localPlayer:getData("charInfo")
	local globalInfo = localPlayer:getData("globalInfo")
	if not charInfo then
		return
	end
	-- spawnujemy gracza, itd.
	exports.chat:clearChat()
	triggerServerEvent("spawnPlayer", localPlayer)
end)