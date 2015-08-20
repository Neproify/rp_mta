addCommandHandler("zaloguj", function(cmd, login, password)
	local globalInfo = localPlayer:getData("globalInfo")
	if globalInfo then
		return
	end
	triggerServerEvent("onLoginRequest", localPlayer, login, password)
end)

local loginWindow = nil
local sw, sh = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()
	loginWindow = GuiBrowser(sw /2 - 150, sh /2 - 150, 300, 300, true, false, false)
	addEventHandler("onClientBrowserCreated", loginWindow, function()
		loginWindow:getBrowser():loadURL("http://mta/local/login.html")
		showCursor(true)
		guiSetInputEnabled(true)
		addEvent("onLoginForm", true)
		addEventHandler("onLoginForm", loginWindow:getBrowser(), function(login, password)
			local globalInfo = localPlayer:getData("globalInfo")
			if globalInfo then
				return
			end
			triggerServerEvent("onLoginRequest", localPlayer, login, password)
		end)
	end)
end)

addEvent("onLoginResult", true)
addEventHandler("onLoginResult", root, function(result)
	exports.notification:add(result.message)
	if result.success then
		loginWindow:destroy()
		showCursor(false)
		guiSetInputEnabled(false)
		triggerServerEvent("fetchCharacters", localPlayer)
	end
end)