RegisterServerEvent('AdminTools_TP:RunCommandMarker')
AddEventHandler('AdminTools_TP:RunCommandMarker', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		if (group == "admin") then
			TriggerClientEvent('AdminTools_TP:TPMarker', _source)
		else
			TriggerClientEvent('AdminTools_General:IsNotAdmin', _source)
		end
	end)
end)