----------------------------------------------------------------------------------------------
----------------------------------   VARIABLES LOCALES   -------------------------------------
----------------------------------------------------------------------------------------------

local secondsRemaining = 0
local holdingupReboot = false
local hasBeenInitialised = false
local notificationParam = 1

announcestringR = false
lastforR = 5

----------------------------------------------------------------------------------------------
----------------------------------   NOTIFICATIONS   -----------------------------------------
----------------------------------------------------------------------------------------------
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





----------------------------------------------------------------------------------------------
---------------------------------------   SCRIPT   -------------------------------------------
----------------------------------------------------------------------------------------------

RegisterNetEvent("AdminTools_Reboot:LaunchReboot")
AddEventHandler("AdminTools_Reboot:LaunchReboot", function()
	TriggerEvent('es_countdown:reboot', -1)
	TriggerEvent("es_countdown:setSeason", -1)
end)

RegisterNetEvent("AdminTools_Reboot:RunCommandServer")
AddEventHandler("AdminTools_Reboot:RunCommandServer", function()
	TriggerServerEvent('AdminTools_Reboot:RunCommand', source)
end)

RegisterNetEvent("es_countdown:setSeason")
AddEventHandler("es_countdown:setSeason", function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			SetWeatherTypePersist("THUNDER")
        	SetWeatherTypeNowPersist("THUNDER")
       		SetWeatherTypeNow("THUNDER")
       		SetOverrideWeather("THUNDER")
		end
	end)
end)

RegisterNetEvent('es_countdown:reboot')
AddEventHandler('es_countdown:reboot', function()
	holdingupReboot = true
	secondsRemaining = 30
	TriggerEvent("AdminTools_Reboot:sendNotification", notificationParam, "~w~Une ~r~tempête ~w~arrive en ville, ~g~protegez vous !", 2.5)
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  
		if holdingupReboot then
			Citizen.Wait(1000)
			if(secondsRemaining > 0)then
				secondsRemaining = secondsRemaining - 1
			end
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)

		if holdingupReboot then
			if (secondsRemaining >= 2) then
				DisplayHelpText("~w~Reboot du serveur dans ~r~".. secondsRemaining .. " ~w~Secondes.")
			elseif (secondsRemaining == 1) then
				DisplayHelpText("~w~Reboot du serveur dans ~r~".. secondsRemaining .. " ~w~Seconde.")
			elseif (secondsRemaining == 0) then
				TriggerEvent('announceR')
				holdingupReboot = false
				TriggerServerEvent('Spawn:SaveBeforeReboot')
				Citizen.Wait(3000)
				TriggerServerEvent('AdminTools_Reboot:Stop')
			end
		end
	end
end)

RegisterNetEvent('announceR')
announcestringR = false
AddEventHandler('announceR', function()
	announcestringR = "Reboot du serveur imminent, veuillez patienter.."
	PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 1)
	Citizen.Wait(lastforR * 1000)
	announcestringR = false
end)

function InitializeR(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
	PushScaleformMovieFunctionParameterString("~y~ATTENTION")
    PushScaleformMovieFunctionParameterString(announcestringR)
    PopScaleformMovieFunctionVoid()
    return scaleform
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if announcestringR then
			scaleform = InitializeR("mp_big_message_freemode")
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end
	end
end)
