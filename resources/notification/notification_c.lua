function add(msg)
	outputChatBox(msg)
end

addEvent("notification:add", true)
addEventHandler("notification:add", root, function(msg)
	add(msg)
end)