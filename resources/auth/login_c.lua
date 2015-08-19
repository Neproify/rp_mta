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
	loginWindow:loadURL("http://mta/local/login.html")
	addEventHandler("onClientRender", root, renderLoginGUI)
end)

function renderLoginGUI()
	dxDrawImage(sw - 320, sh - 240, 640, 480, loginWindow)
end

addEvent("onLoginResult", true)
addEventHandler("onLoginResult", root, function(result)
	exports.notification:add(result.message)
	if result.success then
		triggerServerEvent("fetchCharacters", localPlayer)
	end
end)