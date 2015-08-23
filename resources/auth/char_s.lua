local db = exports.db

addEvent("fetchCharacters", true)
addEventHandler("fetchCharacters", root, function()
	local globalInfo = client:getData("globalInfo")
	if not globalInfo then
		return
	end
	local characters = db:fetch("SELECT * FROM `rp_characters` WHERE `global`=?", globalInfo["UID"])
	if not characters then
		client:kick("Nie posiadasz żadnej postaci.")
		return
	end
	client:setData("characters", characters)
	triggerClientEvent(client, "onCharactersFetched", root)
end)

addEvent("selectCharacter", true)
addEventHandler("selectCharacter", root, function(UID)
	local globalInfo = client:getData("globalInfo")
	if not UID or not globalInfo then
		return
	end
	local charInfo = db:fetch("SELECT * FROM `rp_characters` WHERE `UID`=? AND `global`=? LIMIT 1;", UID, globalInfo["UID"])
	charInfo = charInfo[1]
	if not charInfo then
		return
	end
	client:setData("characters", nil)
	client:setData("charInfo", charInfo)
	client:setName(charInfo["name"])
	triggerEvent("loadPlayerGroups", client)
	triggerClientEvent(client, "onCharacterSelected", root)
end)