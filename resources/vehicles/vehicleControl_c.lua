addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if player == localPlayer then
		local engineState = source:getData("vehicleEngine")
		source:setEngineState(engineState)
	end
end)