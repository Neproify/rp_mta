local db = exports.db

local testGroup = Element("group")
local Group = getmetatable(testGroup).__class
testGroup:destroy()

addEventHandler("onResourceStart", resourceRoot, function()
	local groups = db:fetch("SELECT `UID` FROM `rp_groups`")
	for i,v in ipairs(groups) do
		loadGroup(v.UID)
	end
end)

addEventHandler("onResourceStop", resourceRoot, function()
	local groups = Element.getAllByType("group")
	for i,v in ipairs(groups) do
		v:save()
	end
end)

function loadGroup(UID)
	local groupInfoTemp = db:fetch("SELECT * FROM `rp_groups` WHERE `UID`=?", UID)
	groupInfoTemp = groupInfoTemp[1]
	local groupInfo = {}
	groupInfo["UID"] = groupInfoTemp["UID"]
	groupInfo["name"] = groupInfoTemp["name"]
	local group = Element("group")
	group:setData("groupInfo", groupInfo)
end

function createGroup(name)
	db:query("INSERT INTO `rp_groups` SET `name`=?", name)
	local UID = db:fetch("SELECT MAX(`UID`) AS `UID` FROM `rp_groups`")
	UID = UID[1]["UID"]
	db:query("INSERT INTO `rp_groups_ranks` SET `groupid`=?, `name`=?", UID, "Lider")
	local headrank = db:fetch("SELECT * FROM `rp_groups_ranks` WHERE `groupid`=?", UID)
	db:query("UPDATE `rp_groups` SET `headrank`=? WHERE `UID`=?", headrank["UID"], UID)
	loadGroup(UID)
end

function Group:save()
	local groupInfo = self:getData("groupInfo")
	db:query("UPDATE `rp_groups` SET `name`=? WHERE `UID`=?", groupInfo["name"], groupInfo["UID"])
end

createGroup("testowa")