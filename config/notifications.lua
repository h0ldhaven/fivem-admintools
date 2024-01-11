-----------------------------------------------------------------------------------------------------------
----------------------------------------- NOTIFICATIONS ---------------------------------------------------
-----------------------------------------------------------------------------------------------------------

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

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function Text(text)
	SetTextColour(255, 0, 0, 255)
	SetTextFont(1)
	SetTextScale(0.400, 0.400)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEdge(0, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.0260, 0.2920)
	DrawRect(0.085,0.355,0.145,0.140,0,0,0,185)
end

function ACstatus(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Message envoyé à l'utilisateur s'il n'est pas admin (test)
RegisterNetEvent("AdminTools:IsNotAdmin")
AddEventHandler("AdminTools:IsNotAdmin", function()
	TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("not_an_admin"), 0.350)
end)
-- Message envoyé à l'utilisateur s'il est admin (test)
RegisterNetEvent("AdminTools:IsAnAdmin")
AddEventHandler("AdminTools:IsAnAdmin", function()
	TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("is_an_admin"), 0.350)
end)

---------------------------------------------------------------------------
--------------------------  NOTIFY GENERAL  -------------------------------
---------------------------------------------------------------------------

RegisterNetEvent("AdminTools_General:notify")
AddEventHandler("AdminTools_General:notify", function(image, text, time)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, image, image, true, 1, "Menu Admin", "", time)
	DrawNotification_4(false, true)
end)

RegisterNetEvent("AdminTools_General:sendNotification")
AddEventHandler("AdminTools_General:sendNotification", function(param, image, message, duration)
	if param == 1 then
		TriggerEvent("AdminTools_General:notify", image, message, duration)
	elseif param == 2 then
		TriggerEvent('chatMessage', 'AdminTools_General', { 255, 128, 0 }, message)
	end
end)