local dbAddress = "127.0.0.1"
local dbUser = "santosrp"
local dbPassword = "neproify.kl[000]cek"
local dbDatabase = "santosrp"
local dbHandle = nil

addEventHandler("onResourceStart", resourceRoot, function()
	dbHandle = Connection("mysql", "dbname=".. dbDatabase .. ";host=".. dbAddress ..";charset=utf8", dbUser, dbPassword)
	if dbHandle then
		-- Wszystko okej, mamy połączenie
	else
		shutdown("Brak połączenia z bazą MySQL")
	end
end)

function query(...)
	local qh = dbHandle:query(...)
	qh:free()
end

function fetch(...)
	local qh = dbHandle:query(...)
	local result = qh:poll(-1)
	return result
end