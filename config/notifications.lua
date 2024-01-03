-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
----------------------------------------- NOTIFICATIONS ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
local notificationParam = 1

-- variables de notifications
function ShowNotification( text )
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end
function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

-- Message envoyé à l'utilisateur s'il n'est pas admin (test)
RegisterNetEvent("AdminTools_General:IsNotAdmin")
AddEventHandler("AdminTools_General:IsNotAdmin", function()
	TriggerEvent("AdminTools_General:sendNotification", notificationParam, "~r~Vous devez être administrateur pour faire cela.", 0.350)
end)
-- Message envoyé à l'utilisateur s'il est admin (test)
RegisterNetEvent("AdminTools_General:IsAnAdmin")
AddEventHandler("AdminTools_General:IsAnAdmin", function()
	TriggerEvent("AdminTools_General:sendNotification", notificationParam, "~g~Vous êtes administrateur, éxécution de la commande.", 0.350)
end)

---------------------------------------------------------------------------
--------------------------  NOTIFY GENERAL  -------------------------------
---------------------------------------------------------------------------

RegisterNetEvent("AdminTools_General:notify")
AddEventHandler("AdminTools_General:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_DETONATEPHONE", "CHAR_DETONATEPHONE", true, 1, "Menu Admin", "", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_General:sendNotification")
AddEventHandler("AdminTools_General:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_General:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_General', { 255, 128, 0 }, message)
	end
end)

---------------------------------------------------------------------------
--------------------------  NOTIFY CARCMD  --------------------------------
---------------------------------------------------------------------------
RegisterNetEvent("AdminTools_CarCmd:notify")
AddEventHandler("AdminTools_CarCmd:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_LS_CUSTOMS", "CHAR_LS_CUSTOMS", true, 1, "LS Customs", "", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_CarCmd:sendNotification")
AddEventHandler("AdminTools_CarCmd:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_CarCmd:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_CarCmd', { 255, 128, 0 }, message)
	end
end)

---------------------------------------------------------------------------
--------------------------  NOTIFY DECOMPTE  ------------------------------
---------------------------------------------------------------------------
RegisterNetEvent("AdminTools_Decompte:notify")
AddEventHandler("AdminTools_Decompte:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_CALL911", "CHAR_CALL911", true, 1, "ANNONCE", "c'est important", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_Decompte:sendNotification")
AddEventHandler("AdminTools_Decompte:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_Decompte:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_Decompte', { 255, 128, 0 }, message)
	end
end)

---------------------------------------------------------------------------
---------------------------  NOTIFY REBOOT  -------------------------------
---------------------------------------------------------------------------
RegisterNetEvent("AdminTools_Reboot:notify")
AddEventHandler("AdminTools_Reboot:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_CALL911", "CHAR_CALL911", true, 1, "URGENCES", "911", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_Reboot:sendNotification")
AddEventHandler("AdminTools_Reboot:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_Reboot:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_Reboot', { 255, 128, 0 }, message)
	end
end)

---------------------------------------------------------------------------
---------------------------  NOTIFY NOCLIP  -------------------------------
---------------------------------------------------------------------------
RegisterNetEvent("AdminTools_Noclip:notify")
AddEventHandler("AdminTools_Noclip:notify", function(text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_DETONATEPHONE", "CHAR_DETONATEPHONE", true, 1, "Menu Admin", "", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_Noclip:sendNotification")
AddEventHandler("AdminTools_Noclip:sendNotification", function(param, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_Noclip:notify", message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_Noclip', { 255, 128, 0 }, message)
	end
end)

