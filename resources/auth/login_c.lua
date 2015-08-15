addCommandHandler("zaloguj", function(cmd, login, password)
	local globalInfo = localPlayer:getData("globalInfo")
	if globalInfo then
		return
	end
	triggerServerEvent("onLoginRequest", localPlayer, login, password)
end)

addEvent("onLoginResult", true)
addEventHandler("onLoginResult", root, function(result)
	exports.notification:add(result.message)
	if result.success then
		triggerServerEvent("fetchCharacters", localPlayer)
	end
end)