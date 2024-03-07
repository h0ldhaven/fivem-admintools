RegisterNetEvent('adminskin:LaunchCommand')
AddEventHandler('adminskin:LaunchCommand', function()
  if (isAdmin()) then
    ChangePedSkin()
  else
    TriggerEvent("AdminTools:IsNotAdmin")
  end
end)

-- change skin
function ChangePedSkin()
    AddTextEntry('FMMC_KEY_TIP8', "Nom")
    DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 50)

    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    
    if GetOnscreenKeyboardResult() then
		  local lashVehicle = GetPlayersLastVehicle()
      local pedHash = GetOnscreenKeyboardResult()

      pedHash = GetHashKey(pedHash)
 
      if IsModelInCdimage(pedHash) then
        RequestModel(pedHash)

        while not HasModelLoaded(pedHash) do
            Citizen.Wait(5)
        end

        if IsInVehicle() then
          SetPlayerModel(PlayerId(), pedHash)
          SetPedPropIndex(GetPlayerPed(-1), 0, 0, 0, 2)
          SetPedIntoVehicle(GetPlayerPed(-1), lashVehicle, - 1)
        else
          SetPlayerModel(PlayerId(), pedHash)
          SetPedPropIndex(GetPlayerPed(-1), 0, 0, 0, 2)
        end
  
        TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("skin_success"), 0.200)
      else
        TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("skin_fail"), 0.200)
      end
    end
end