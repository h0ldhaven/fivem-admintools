RegisterServerEvent('adminskin:checkperms')
AddEventHandler('adminskin:checkperms', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		if (group == "admin") then
			TriggerClientEvent('adminskin:executeskin', _source)
		else
			TriggerClientEvent('AdminTools_General:notadmin', _source)
		end
	end)
end)
