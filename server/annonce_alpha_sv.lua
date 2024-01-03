RegisterServerEvent('decompte:checkperms')
AddEventHandler('decompte:checkperms', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		--print(group);
		if (group == "admin") then
			TriggerClientEvent('decompte:ISOK', _source)
			--print(group .. " 1");
		else
			TriggerClientEvent('decompte:ISNOTOK', _source)
			--print(group .. " 0");
		end
	end)
end)