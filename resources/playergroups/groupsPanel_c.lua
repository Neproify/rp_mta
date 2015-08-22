local groupsWindow = nil
local panelEnabled = false
local sw, sh = guiGetScreenSize()

addEventHandler("onClientResourceStart", resourceRoot, function()
	groupsWindow = GuiBrowser(sw /2 - 200, sh /2 - 150, 400, 300, true, true, false)
	addEventHandler("onClientBrowserCreated", groupsWindow, function()
		groupsWindow:getBrowser():loadURL("http://mta/local/playerGroups.html")
		groupsWindow:getBrowser():setRenderingPaused(true)
		guiSetVisible(groupsWindow, false)
		addEvent("onGroupPanelClose", true)
		addEventHandler("onGroupPanelClose", groupsWindow:getBrowser(), function()
			groupsWindow:getBrowser():setRenderingPaused(true)
			guiSetVisible(groupsWindow, false)
			showCursor(false)
			guiSetInputEnabled(false)
			panelEnabled = false
		end)
	end)
end)

addCommandHandler("g", function()
	--[[if panelEnabled then
		groupsWindow:getBrowser():setRenderingPaused(true)
		guiSetVisible(groupsWindow, false)
		showCursor(false)
		guiSetInputEnabled(false)
		panelEnabled = false--]]
	if not panelEnabled then
		if not localPlayer:getData("charInfo") or not localPlayer:getData("groups") then
			if not localPlayer:getData("groups")
				triggerServerEvent("loadPlayerGroups", localPlayer)
			end
			return
		end
		groupsWindow:getBrowser():setRenderingPaused(false)
		guiSetVisible(groupsWindow, true)
		showCursor(true, false)
		guiSetInputEnabled(true)
		panelEnabled = true
	end
end)