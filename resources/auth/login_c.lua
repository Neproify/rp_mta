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
	loginWindow = Browser(640, 480, true)
	addEventHandler("onClientBrowserCreated", loginWindow, function()
		loginWindow:loadURL("http://mta/local/login.html")
		showCursor(true)
		guiSetInputEnabled(true)
		loginWindow:focus()
		addEventHandler("onClientRender", root, renderLoginGUI)
	end)
end)

function renderLoginGUI()
	dxDrawImage(sw /2 - 320, sh /2 - 240, 640, 480, loginWindow, 0, 0, 0, tocolor(255,255,255,255), true)
end

addEvent("onLoginResult", true)
addEventHandler("onLoginResult", root, function(result)
	exports.notification:add(result.message)
	if result.success then
		triggerServerEvent("fetchCharacters", localPlayer)
	end
end)