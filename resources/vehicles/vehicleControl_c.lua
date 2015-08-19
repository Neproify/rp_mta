addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if player == localPlayer then
		local engineState, lights = source:getData("vehicleEngine"), source:getData("vehicleLights")
		source:setEngineState(engineState)
	end
end)