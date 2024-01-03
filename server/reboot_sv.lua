RegisterServerEvent('AdminTools_Reboot:RunCommand')
AddEventHandler('AdminTools_Reboot:RunCommand', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		if (group == "admin") then
			TriggerClientEvent('AdminTools_Reboot:LaunchReboot', _source)
		else
			TriggerClientEvent('AdminTools_General:notadmin', _source)
		end
	end)
end)

RegisterServerEvent('AdminTools_Reboot:Stop')
AddEventHandler('AdminTools_Reboot:Stop', function()
	ExecuteCommand('quit "Le serveur Redémarre"')
end)
