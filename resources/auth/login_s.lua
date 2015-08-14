local db = exports.db

addEvent("onLoginRequest", true)
addEventHandler("onLoginRequest", root, function(login, password)
	if not login or not password then
		local result = {success=false, message="Musisz podać login i hasło!"}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	local salt = db:fetch("SELECT `salt` FROM `mybb_users` WHERE `username`=? LIMIT 1;", login)
	salt = salt[0]["salt"]
	if not salt then
		local result = {success=false, message="Podane konto nie istnieje w bazie danych. Sprawdź czy wpisany login jest poprawny."}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	local globalInfoTemp = db:fetch("SELECT `uid`, `username` FROM `mybb_users` WHERE `username`=? AND `password`=md5(CONCAT(md5(?),md5(?))) LIMIT 1;", login, salt, password)
	globalInfoTemp = globalInfoTemp[0]
	if not globalInfoTemp then
		local result = {success=false, message="Podałeś nieprawidłowy login i/lub hasło."}
		triggerClientEvent(client, "onLoginResult", root, result)
		return
	end

	local globalInfo = {}
	globalInfo["UID"] = globalInfoTemp["uid"]
	globalInfo["name"] = globalInfoTemp["username"]

	client:setData("globalInfo", globalInfo)
	local result ={success=true, message="Zalogowałeś się."}
	triggerClientEvent(client, "onLoginResult", root, result)
end)