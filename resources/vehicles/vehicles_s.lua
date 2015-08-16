--[[
	OWNER_NONE - 0
	OWNER_PLAYER - 1
]]--

local db = exports.db

addEventHandler("onResourceStart", resourceRoot, function()
	local vehiclesToSpawn = db:fetch("SELECT `UID` FROM `rp_vehicles` WHERE `ownerType`=1")
	for i,v in ipairs(vehiclesToSpawn) do
		spawnVehicle(v["UID"])
	end
end)

function spawnVehicle(UID)
	local vehInfoTemp = db:fetch("SELECT * FROM `rp_vehicles` WHERE `UID`=?", UID)
	vehInfoTemp = vehInfoTemp[1]
	local vehInfo = {}
	vehInfo["UID"] = vehInfoTemp["UID"]
	vehInfo["model"] = vehInfoTemp["model"]
	vehInfo["ownerType"] = vehInfoTemp["ownerType"]
	vehInfo["owner"] = vehInfoTemp["owner"]
	vehInfo["position"] = Vector3(vehInfoTemp["posX"], vehInfoTemp["posY"], vehInfoTemp["posZ"])
	vehInfo["rotation"] = Vector3(vehInfoTemp["rotX"], vehInfoTemp["rotY"], vehInfoTemp["rotZ"])
	local vehicle = Vehicle(vehInfo["model"], vehInfo["position"], vehInfo["rotation"], "LS"..vehInfo["UID"])
	vehicle:setData("vehInfo", vehInfo)
end