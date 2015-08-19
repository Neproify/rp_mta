addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if player == localPlayer then
		local engineState, lights = source:getData("vehicleEngine")
		source:setEngineState(engineState)
	end
end)

addCommandHandler("silnik", function()
	if localPlayer.inVehicle then
		if localPlayer.vehicleSeat == 0 then
			localPlayer.vehicle:setData("vehicleEngine", not localPlayer.vehicle:getData("vehicleEngine"))
			localPlayer.vehicle:setEngineState(localPlayer.vehicle:getData("vehicleEngine"))
		end
	end
end)

addCommandHandler("swiatla", function()
	if localPlayer.inVehicle then
		if localPlayer.vehicleSeat == 0 then
			if localPlayer.vehicle.overrideLights == 1 then
				localPlayer.vehicle.overrideLights = 2
			elseif localPlayer.vehicle.overrideLights == 2 then
				localPlayer.vehicle.overrideLights = 1
			end
		end
	end
end)