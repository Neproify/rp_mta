local db = exports.db

addEvent("onLoginRequest", true)
addEventHandler("onLoginRequest", root, function(login, password)
	if not login or not password then
		local result = {success=false, message="Musisz podać login i hasło!"}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	local salt = db:fetch("SELECT `salt` FROM `mybb_users` WHERE `username`=? LIMIT 1;", login)
	salt = salt[1]["salt"]
	if not salt then
	--[[local passHash = db:fetch("SELECT `members_pass_hash`, `members_pass_salt` FROM `ipb_core_members` WHERE `name`=? LIMIT 1;", login)
	local salt = passHash[1]["members_pass_salt"]
	passHash = passHash[1]["members_pass_hash"]
	if not passHash then--]]
		local result = {success=false, message="Podane konto nie istnieje w bazie danych. Sprawdź czy wpisany login jest poprawny."}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	--[[local userPassHash = bcrypt_digest(password, "$2a$13$"..salt)
	if not (userPassHash == passHash) then
		local result = {success=false, message="Podałeś nieprawidłowy login i/lub hasło."}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end--]]

	local globalInfoTemp = db:fetch("SELECT `uid`, `username`, `score`, `admin`, `permissions` FROM `mybb_users` WHERE `username`=? AND `password`=md5(CONCAT(md5(?),md5(?))) LIMIT 1;", login, salt, password)
	--local globalInfoTemp = db:fetch("SELECT `member_id`, `name`, `score`, `admin`, `permissions` FROM `ipb_core_members` WHERE `name`=?", login)
	globalInfoTemp = globalInfoTemp[1]
	if not globalInfoTemp then
		local result = {success=false, message="Podałeś nieprawidłowy login i/lub hasło."}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	local globalInfo = {}
	globalInfo["UID"] = globalInfoTemp["uid"]
	globalInfo["name"] = globalInfoTemp["username"]
	--[[globalInfo["UID"] = globalInfoTemp["member_id"]
	globalInfo["name"] = globalInfoTemp["name"]--]]
	globalInfo["score"] = globalInfoTemp["score"]
	globalInfo["admin"] = globalInfoTemp["admin"]
	globalInfo["permissions"] = globalInfoTemp["permissions"]

	client:setData("globalInfo", globalInfo)
	local result ={success=true, message="Zalogowałeś się."}
	triggerClientEvent(client, "onLoginResult", root, result)
end)