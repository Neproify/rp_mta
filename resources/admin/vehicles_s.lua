addCommandHandler("apojazd", function(player, cmdname, param1, param2, param3)
	local globalInfo = player:getData("globalInfo")
	if not bitTest(globalInfo["permissions"], 1) then
		return
	end
	if param1 == "hp" then
		if not param2 or not param3 then
			exports.notification:add(player, "Użyj: /apojazd hp [uid pojazdu] [ilość hp]")
		end
		param2, param3 = tonumber(param2), tonumber(param3)
		local vehicle = exports.vehicles:getByUID(param2)
		if not vehicle then
			exports.notification:add(player, "Nie znaleziono pojazdu z UID: ".. param2)
			return
		end
		if param3 < 0 or param3 > 1000 then
			exports.notification:add(player, "Podałeś nieprawidłową liczbę HP.")
			return
		end
		vehicle:setHealth(param3)
	else
		exports.notification:add(player, "Użyj: /apojazd [hp]")
	end
end)