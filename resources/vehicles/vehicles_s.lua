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

addEventHandler("onResourceStop", resourceRoot, function()
	for i,v in ipairs(Element.getAllByType("vehicle")) do
		v:save()
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
	vehicle:setHealth(vehInfoTemp["HP"])
	local panelState = string.explode(vehInfoTemp["panelstate"], ",")
	for i,v in ipairs(panelState) do
		vehicle:setPanelState(i-1, v)
	end
	local doorState = string.explode(vehInfoTemp["doorstate"], ",")
	for i,v in ipairs(doorState) do
		vehicle:setDoorState(i-1, v)
	end
	local wheelStates = string.explode(vehInfoTemp["wheelstates"], ",")
	vehicle:setWheelStates(wheelStates[1], wheelStates[2], wheelStates[3], wheelStates[4])
end

function Vehicle:save()
	local vehInfo = self:getData("vehInfo")
	if not vehInfo then
		return false
	end
	local panelState = {}
	for i=0,6 do
		table.insert(panelState, self:getPanelState(i))
	end
	panelState = table.concat(panelState, ",")
	local doorState = {}
	for i=0,5 do
		table.insert(doorState, self:getDoorState(i))
	end
	doorState = table.concat(doorState, ",")
	local wheelState = {}
	wheelState[0], wheelState[1], wheelState[2], wheelState[3] = self:getWheelStates()
	wheelState = table.concat(wheelState, ",")

	db:query("UPDATE `rp_vehicles` SET `model`=?, `ownerType`=?, `owner`=?, `HP`=?, `panelstates`=?, `doorstates`=?, `wheelstates`=? WHERE `UID`=?",
		vehInfo["model"], vehInfo["ownerType"], vehInfo["owner"], self.health, panelState, doorState, WheelState, vehInfo["UID"])
end

--kilka funkcji
function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

function string.explode(self, separator)
    Check("string.explode", "string", self, "ensemble", "string", separator, "separator")
 
    if (#self == 0) then return {} end
    if (#separator == 0) then return { self } end
 
    return loadstring("return {\""..self:gsub(separator, "\",\"").."\"}")()
end