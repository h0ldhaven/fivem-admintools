--------------------------------------------------------------------------------------------
----------------------------------   LOCAL VARIABLES   -------------------------------------
--------------------------------------------------------------------------------------------

local secondsRemaining = 0
local holdingupReboot = false
local hasBeenInitialised = false
local notificationParam = 1

announcestringR = false
lastforR = 5

----------------------------------------------------------------------------------------------
---------------------------------------   SCRIPT   -------------------------------------------
----------------------------------------------------------------------------------------------
RegisterNetEvent("AdminTools_Reboot:RunCommandServer")
AddEventHandler("AdminTools_Reboot:RunCommandServer", function()
	if (isAdmin()) then
		TriggerEvent("AdminTools_Reboot:LaunchReboot")
	else
		TriggerEvent("AdminTools:IsNotAdmin")
	end
end)

RegisterNetEvent("AdminTools_Reboot:LaunchReboot")
AddEventHandler("AdminTools_Reboot:LaunchReboot", function()
	TriggerEvent('es_countdown:reboot', -1)
	TriggerEvent("es_countdown:setSeason", -1)
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
	TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_CALL911", i18n.translate("reboot_warning"), 2.5)
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
				TriggerServerEvent('AdminTools:StopServer')
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
