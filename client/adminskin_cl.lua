RegisterNetEvent('adminskin:LaunchCommand')
AddEventHandler('adminskin:LaunchCommand', function(source)
	TriggerServerEvent('adminskin:checkperms', source)
end)

RegisterNetEvent('adminskin:executeskin')
AddEventHandler('adminskin:executeskin', function(source)
	ChangePedSkin(source)
end)

local notificationParam = 1

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
  
        TriggerEvent("AdminTools_General:sendNotification", notificationParam, "Skin Changé !", 0.200)
      else
        TriggerEvent("AdminTools_General:sendNotification", notificationParam, "Désolé, ce skin n'éxiste pas !", 0.200)
      end
    --else
      --TriggerEvent("AdminTools_General:sendNotification", notificationParam, "Vous n'avez rien renseigné !", 0.200)
    end
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end