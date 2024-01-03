RegisterServerEvent('AdminCar:CheckForSpawn')
AddEventHandler('AdminCar:CheckForSpawn', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		
		if (group == "admin") then
			TriggerClientEvent('admincar:spawncar', _source)
		else
			TriggerClientEvent('AdminTools:IsNotAdmin', _source)
		end
	end)
end)

RegisterServerEvent('AdminCar:ClearCar')
AddEventHandler('AdminCar:ClearCar', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		
		if (group == "admin") then
			TriggerClientEvent('admincar:clearcar', _source)
		else
			TriggerClientEvent('AdminTools_General:IsNotAdmin', _source)
		end
	end)
end)

RegisterServerEvent('AdminCar:RepairCar')
AddEventHandler('AdminCar:RepairCar', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		
		if (group == "admin") then
			TriggerClientEvent('admincar:repairthecar', _source)
		else
			TriggerClientEvent('AdminTools_General:IsNotAdmin', _source)
		end
	end)
end)

RegisterServerEvent('AdminCar:DestroyCar')
AddEventHandler('AdminCar:DestroyCar', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		
		if (group == "admin") then
			TriggerClientEvent('admincar:destroythecar', _source)
		else
			TriggerClientEvent('AdminTools_General:IsNotAdmin', _source)
		end
	end)
end)
