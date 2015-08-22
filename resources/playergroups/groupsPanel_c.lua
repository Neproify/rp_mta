local groupsWindow = nil
local panelEnabled = false
local sw, sh = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()
	groupsWindow = GuiBrowser(sw /2 - 200, sh /2 - 150, 400, 300, true, true, false)
	addEventHandler("onClientBrowserCreated", groupsWindow, function()
		groupsWindow:getBrowser():loadURL("http://mta/local/playerGroups.html")
		groupsWindow:getBrowser():setRenderingPaused(true)
		guiSetVisible(groupsWindow, false)
	end)
end)

addCommandHandler("g", function()
	if panelEnabled then
		groupsWindow:getBrowser():setRenderingPaused(true)
		guiSetVisible(groupsWindow, false)
		panelEnabled = false
	else
		groupsWindow:getBrowser():setRenderingPaused(false)
		guiSetVisible(groupsWindow, true)
		panelEnabled = true
	end
end)