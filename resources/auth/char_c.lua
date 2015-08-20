--[[addCommandHandler("character", function(cmd, UID)
	if not UID then
	end
	local globalInfo = localPlayer:getData("globalInfo")
	if not globalInfo then
		return
	end
	triggerServerEvent("selectCharacter", localPlayer, UID)
end)--]]

local loginPed = nil
local selectedChar = 1

addEvent("onCharactersFetched", true)
addEventHandler("onCharactersFetched", root, function()
	local characters = localPlayer:getData("characters")
	loginPed = createPed(characters[1]["skin"], 1484.8495, -1694.1045, 15.0469)
	loginPed.dimension = localPlayer:getData("ID") + 50000
	localPlayer.dimension = loginPed.dimension
	Camera.setMatrix(1485.8495, -1687.1045, 13.0469, 1484.8495, -1694.1045, 16.0469)
	bindKey("arrow_l", "down", previousChar)
	bindKey("arrow_r", "down", nextChar)
	bindKey("enter", "down", selectChar)
	--[[exports.chat:clearChat()
	outputChatBox("==== TWOJE POSTACIE ====")
	for i,v in ipairs(characters) do
		outputChatBox("UID: ".. v["UID"] ..", name: "..v["name"].."")
	end
	outputChatBox("Użyj /character [UID] by wybrać jedną z postaci.")--]]
end)

function previousChar()
	local characters = localPlayer:getData("characters")
	selectedChar = selectedChar - 1
	if selectedChar < 1 then
		selectedChar = #characters
	end
end

function nextChar()
	local characters = localPlayer:getData("characters")
	selectedChar = selectedChar + 1
	if selectedChar > #characters then
		selectedChar = 1
	end
end

function selectChar()
	local characters = localPlayer:getData("characters")
	triggerServerEvent("selectCharacter", localPlayer, characters[selectedChar]["UID"])
end

addEvent("onCharacterSelected", true)
addEventHandler("onCharacterSelected", root, function()
	local charInfo = localPlayer:getData("charInfo")
	local globalInfo = localPlayer:getData("globalInfo")
	if not charInfo then
		return
	end
	unbindKey("arrow_l", "down", previousChar)
	unbindKey("arrow_r", "down", nextChar)
	unbindKey("enter", "down", selectChar)
	loginPed:destroy()
	-- spawnujemy gracza, itd.
	localPlayer:setData("characters", nil)
	exports.chat:clearChat()
	triggerServerEvent("spawnPlayer", localPlayer)
end)