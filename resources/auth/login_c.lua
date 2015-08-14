addCommandHandler("login", function(cmd, login, password)
	triggerServerEvent("onLoginRequest", localPlayer, login, password)
end)

addEvent("onLoginResult", true)
addEventHandler("onLoginResult", root, function(result)
	outputChatBox(result.message)
end)