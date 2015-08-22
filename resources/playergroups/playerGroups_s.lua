local db = exports.db

function Player:getGroups()
	local charInfo = self:getData("charInfo")
	local groups = db:fetch("SELECT * FROM `rp_groups_members` WHERE `charid`=?", charInfo["UID"])
	return groups
end

function Player:havePermissionInGroup(UID, permission)
	local charGroups = self:getGroups()
	if charGroups then
		for i,v in ipairs(charGroups) do
			if v["groupid"] == UID then
				local rank = db:fetch("SELECT * FROM `rp_groups_ranks` WHERE `groupid`=? AND `UID`=?", v["groupid"], UID)
				if bitTest(rank["permissions"], permission) then
					return true
				end
			end
		end
	end
	return false
end

--exports
function getPlayerGroups(player)
	return player:getGroups()
end

function havePlayerPermissionInGroup(player, UID, permission)
	return player:havePermissionInGroup(UID, permission)
end