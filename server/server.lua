-- check admin pour le menu developpeur
RegisterServerEvent('AdminTools:CheckIfImAdminForMenu')
AddEventHandler('AdminTools:CheckIfImAdminForMenu', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		-- si le joueur est admin:
		--if (group == "admin") then
			TriggerClientEvent('AdminTools:ResultAdmin', _source, group)
		--end
	end)
end)

-- check admin pour le menu developpeur
RegisterServerEvent('AdminTools:addbank')
AddEventHandler('AdminTools:addbank', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		user.addBank(100)
		TriggerEvent('es:savemoney')
	end)
end)

RegisterServerEvent('AdminTools:rembank')
AddEventHandler('AdminTools:rembank', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		user.removeBank(100)
		TriggerEvent('es:savemoney')
	end)
end)


