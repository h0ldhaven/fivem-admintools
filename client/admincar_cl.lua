-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
--------------------------------------------- SCRIPT ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
local notificationParam = 1

RegisterNetEvent("AdminCar:SpawnVeh")
AddEventHandler("AdminCar:SpawnVeh", function()
	TriggerServerEvent('AdminCar:CheckForSpawn')
end)

RegisterNetEvent("AdminCar:ClearCar")
AddEventHandler("AdminCar:ClearCar", function()
	TriggerServerEvent('AdminCar:ClearCar')
end)

RegisterNetEvent("AdminCar:RepairCar")
AddEventHandler("AdminCar:RepairCar", function()
	TriggerServerEvent('AdminCar:RepairCar')
end)

RegisterNetEvent("AdminCar:DestroyCar")
AddEventHandler("AdminCar:DestroyCar", function()
	TriggerServerEvent('AdminCar:DestroyCar')
end)

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

RegisterNetEvent("admincar:spawncar")
AddEventHandler("admincar:spawncar", function()
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 15)

    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
	
	if GetOnscreenKeyboardResult() then
		local veh = GetOnscreenKeyboardResult()
	
		if IsInVehicle() then
			TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~r~La livraison du véhicule ne peut pas être assuré.", 0.350)
		else
				
			if veh == nil then
				TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~r~La livraison du véhicule ne peut pas être assuré.", 0.350)
			else
				local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 8.0, 0.5))
				local myPed = GetPlayerPed(-1)
				local vehiclehash = GetHashKey(veh)
				
				RequestModel(vehiclehash)
				Citizen.CreateThread(function() 
					while not HasModelLoaded(vehiclehash) do
						Wait(1)
					end
					
					local plate = math.random(100, 900)
					
					local _source = source
					
					vehiclehashspawn = CreateVehicle(vehiclehash, x, y, z, GetEntityHeading(PlayerPedId())+90, true, false)
					SetVehicleOnGroundProperly(vehiclehashspawn)
					SetVehicleNumberPlateText(vehiclehashspawn, "DEV"..plate)
					SetPedIntoVehicle(myPed, vehiclehashspawn, - 1)
					SetVehicleDirtLevel(vehiclehashspawn, 0.0);
					
					SetVehRadioStation(vehiclehashspawn, "OFF")
					SetModelAsNoLongerNeeded(vehiclehashspawn, true, true)
					
					local namehaskcar = GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
					local namecar = GetDisplayNameFromVehicleModel(namehaskcar)
					TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~g~Votre " .. namecar .. " a bien été livré !", 0.350)
				end)
			end
		end
	end
end)

-- evenement pour despawner un véhicule (uniquement à l'extérieur d'un véhicule)
RegisterNetEvent("admincar:clearcar")
AddEventHandler("admincar:clearcar", function()
	if IsInVehicle() then
		local vehicleusing = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local namehaskcar = GetEntityModel(vehicleusing)
		local namecar = GetDisplayNameFromVehicleModel(namehaskcar)
		TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~g~Votre ".. namecar .." a bien été rangé.", 0.350)
		playerPed = GetPlayerPed(-1)
		Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(GetVehiclePedIsIn(playerPed, false)))
	else
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
		
		if(DoesEntityExist(vehicleHandle)) then
			local namehaskcar = GetEntityModel(vehicleHandle)
			local namecar = GetDisplayNameFromVehicleModel(namehaskcar)
			TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~g~Votre ".. namecar .." a bien été rangé.", 0.350)
			SetEntityAsMissionEntity(vehicleHandle, true, true)
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicleHandle))
		else
			TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~r~Il n'y a pas de véhicule à proximité.", 0.350)
		end
	end
end)

-- evenement pour réparer et nettoyer un vehicule instantanéement
RegisterNetEvent("admincar:repairthecar")
AddEventHandler("admincar:repairthecar", function()
	if IsInVehicle() then
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsUsing(ped)
		SetVehicleFixed(vehicle, 1)
		SetVehicleDeformationFixed(vehicle, 1)
		SetVehicleDirtLevel(vehicle, 0.0)
		SetVehicleUndriveable(vehicle, false)
		
		local namehaskcar = GetEntityModel(vehicle)
		local namecar = GetDisplayNameFromVehicleModel(namehaskcar)
		--TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~g~Votre ".. namecar .." a bien été réparé !", 0.350)
	else
		TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~r~Cela fonctionne uniquement si vous êtes dans un véhicule.", 0.350)
	end
end)

-- evenement pour réparer et nettoyer un vehicule instantanéement
RegisterNetEvent("admincar:destroythecar")
AddEventHandler("admincar:destroythecar", function()
	if IsInVehicle() then
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsUsing(ped)
		local health = -999.90002441406
			
		--SetVehicleUndriveable(vehicle, true)
		SetVehicleBodyHealth(vehicle, health)
		SetVehicleEngineHealth(vehicle, health)
			
		SetVehicleDoorBroken(vehicle, 0, true)
		SetVehicleDoorBroken(vehicle, 1, true)
		SetVehicleDoorBroken(vehicle, 2, true)
		SetVehicleDoorBroken(vehicle, 3, true)
		SetVehicleDoorBroken(vehicle, 4, true)
		SetVehicleDoorBroken(vehicle, 5, true)
			
		local namehaskcar = GetEntityModel(vehicle)
		local namecar = GetDisplayNameFromVehicleModel(namehaskcar)
		--TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~g~Votre ".. namecar .." a bien été détruite !", 0.350)
	else
		TriggerEvent("AdminTools_CarCmd:sendNotification", notificationParam, "~r~Cela fonctionne uniquement si vous êtes dans un véhicule.", 0.350)
	end
end)


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