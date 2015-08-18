addCommandHandler("apojazd", function(player, cmdname, param1, param2, param3)
	local globalInfo = player:getData("globalInfo")
	if not bitTest(globalInfo["permissions"], 1) then
		return
	end
	if param1 == "hp" then
		if not param2 or not param3 then
			exports.notification:add(player, "Użyj: /apojazd hp [uid pojazdu] [ilość hp]")
		end
		local vehicle = nil
		for i,v in ipairs(Element.getAllByType("vehicle")) do
			local vehInfo = v:getData("vehInfo")
			if vehInfo["UID"] == tonumber(param2) then
				vehicle = v
				break
			end
		end
		if not vehicle then
			exports.notification:add(player, "Nie znaleziono pojazdu z UID: ".. param2)
			return
		end
		if param3 > 0 or param3 > 1000 then
			exports.notification:add(player, "Podałeś nieprawidłową liczbę HP.")
		end
		vehicle.health = param3
	else
		exports.notification:add(player, "Użyj: /apojazd [hp]")
	end
end)