local groupsWindow = nil
local groupsLoaded = false
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

		addEventHandler("onClientBrowserDocumentReady", groupsWindow:getBrowser(), function(url)
			if url == "http://mta/local/playerGroups.html" then -- ładujemy grupy
				local groupshtml = ""
				local groups = localPlayer:getData("groups")
				for i,v in ipairs(groups) do
					local allGroups = Element.getAllByType("group")
					local groupInfo = nil
					for _,group in ipairs(allGroups) do
						if group:getData("groupInfo")["UID"] == v["groupid"] then
							groupInfo = group:getData("groupInfo")
							break
						end
					end
					if groupInfo then
						groupshtml = groupshtml .. "<tr><td>"..groupInfo["name"].."</td><td><a href='http://mta/local/group.html?groupid="..groupInfo["UID"].."'>Wejdź</a></td></tr>"
					end
				end
				groupsWindow:getBrowser():executeJavascript('$("'..groupshtml..'").appendTo(".table tbody");');
			elseif url:find("http://mta/local/group.html?") then -- ładujemy "dane" grupy
				local groupid = url:sub(37)
				if not groupid then
					groupsWindow:getBrowser():loadURL("http://mta/local/playerGroups.html")
					return
				end
				groupid = tonumber(groupid)
				outputDebugString(groupid)
			end
		end)
	end)
end)

function reloadGroupsInList()
	local groupshtml = ""
	local groups = localPlayer:getData("groups")
	for i,v in ipairs(groups) do
		local allGroups = Element.getAllByType("group")
		local groupInfo = nil
		for _,group in ipairs(allGroups) do
			if group:getData("groupInfo")["UID"] == v["groupid"] then
				groupInfo = group:getData("groupInfo")
				break
			end
		end
		if groupInfo then
			groupshtml = groupshtml .. "<tr><td>"..groupInfo["name"].."</td><td><a href='http://mta/local/group.html?groupid="..groupInfo["UID"].."'>Wejdź</a></td></tr>"
		end
	end
	groupsWindow:getBrowser():executeJavascript('$("'..groupshtml..'").appendTo(".table tbody");');
end

addCommandHandler("g", function()
	if not panelEnabled then
		if not localPlayer:getData("charInfo") or not localPlayer:getData("groups") then
			if not localPlayer:getData("groups") then
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