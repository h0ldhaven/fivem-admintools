-- stop server command
RegisterServerEvent('AdminTools:StopServer')
AddEventHandler('AdminTools_Reboot:Stop', function()
	ExecuteCommand('quit "Le serveur Redémarre"')
end)


----------------------------------------
---------- TEMPORARY DISABLED ----------
----------------------------------------

-- RegisterServerEvent('AdminTools:addbank')
-- AddEventHandler('AdminTools:addbank', function()
-- 	local _source = source
-- 	TriggerEvent('es:getPlayerFromId', _source, function(user)
-- 		user.addBank(100)
-- 		TriggerEvent('es:savemoney')
-- 	end)
-- end)

-- RegisterServerEvent('AdminTools:rembank')
-- AddEventHandler('AdminTools:rembank', function()
-- 	local _source = source
-- 	TriggerEvent('es:getPlayerFromId', _source, function(user)
-- 		user.removeBank(100)
-- 		TriggerEvent('es:savemoney')
-- 	end)
-- end)
