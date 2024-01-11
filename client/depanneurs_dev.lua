--------------------------------------------------------------------------------------------
----------------------------------------  TEST  --------------------------------------------
--------------------------------------------------------------------------------------------

RegisterNetEvent("test")
AddEventHandler("test", function(data)
    ped = GetPlayerPed(-1);
	
	if ped then

		if (IsInVehicle()) then
			DisplayHelpText("~r~[Emote]: Pour effectuer cette action, descendez de votre vehicule !");
		else
			if (mp_pointing == true) then
				Notify("~r~Vous ne pouvez pas faire cela.")
			else
				Citizen.CreateThread(function()
					local pid = PlayerPedId()
					RequestAnimDict("random@shop_gunstore")
					while (not HasAnimDictLoaded("random@shop_gunstore")) do Citizen.Wait(0) end
					TaskPlayAnim(pid,"random@shop_gunstore","_positive_goodbye",1.0,-1.0, 5000, 0, 1, true, true, true)
				end)
			end
		end
	end
end)

RegisterNetEvent("EmoteTest")
AddEventHandler("EmoteTest", function(data)
    ped = GetPlayerPed(-1);
	
	if ped then

		if (IsInVehicle()) then
			DisplayHelpText("~r~[Emote]: Pour effectuer cette action, descendez de votre vehicule !");
		else
			if (mp_pointing == true) then
				Notify("~r~Vous ne pouvez pas faire cela.")
			else
				TaskStartScenarioInPlace(ped, "CODE_HUMAN_POLICE_INVESTIGATE", 0, true);
				playing_emote = true;
				Notify("~g~Vous jouez une emote.");
			end
		end
	end
end)

--EMOTE DEPANNEUR
RegisterNetEvent("DepanneurEmote:repair")
AddEventHandler("DepanneurEmote:repair", function(data)
    local ped = GetPlayerPed(-1);
	
	if ped then
		if (IsInVehicle()) then
			DisplayHelpText("~r~[Emote]: Pour effectuer cette action, descendez de votre vehicule !");
		else
			if (mp_pointing == true) then
				Notify("~r~Vous ne pouvez pas faire cela.")
			else
				Citizen.CreateThread(function()
					local pid = PlayerPedId()
					RequestAnimDict("mini")
					RequestAnimDict("mini@repair")
					while (not HasAnimDictLoaded("mini@repair")) do Citizen.Wait(0) end
					TaskPlayAnim(pid,"mini@repair","fixing_a_player",1.0,-1.0, -1, 0, 1, true, true, true)
					--TaskPlayAnim(pid,"mini@repair","fixing_a_car",8.0,0.0, -1, 1, 0, 0, 0, 0)
				end)
				Notify("~g~Vous réparez un vehicule.");
			end
		end
	end
end)

--EMOTE CLEAN DEPANNEUR
RegisterNetEvent("DepanneurEmote:clean")
AddEventHandler("DepanneurEmote:clean", function(data)
    local ped = GetPlayerPed(-1);
	
	if ped then
		if (IsInVehicle()) then
			DisplayHelpText("~r~[Emote]: Pour effectuer cette action, descendez de votre vehicule !");
		else
			if (mp_pointing == true) then
				Notify("~r~Vous ne pouvez pas faire cela.")
			else
				TaskStartScenarioInPlace(ped, "WORLD_HUMAN_MAID_CLEAN", 0, true);
				Notify("~g~Vous nettoyez un vehicule.");
			end
		end
	end
end)

--REPARATION VEHICULES
RegisterNetEvent("DepanneurFunction:repair")
AddEventHandler("DepanneurFunction:repair", function(data)
	Menu.hidden = true
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	
	if(DoesEntityExist(vehicleHandle)) then
		Menu.hidden = true
		TriggerEvent("DepanneurEmote:repair")
		Citizen.Wait(15000)
		SetVehicleFixed(vehicleHandle, 1)
		SetVehicleDeformationFixed(vehicleHandle, 1)
		SetVehicleDoorsLocked(vehicleHandle, 1)
		SetVehicleDoorsLockedForPlayer(vehicleHandle, GetPlayerPed(-1), false)
			if GetVehicleDoorAngleRatio(vehicleHandle, 4) > 0.0 then 
				SetVehicleDoorShut(vehicleHandle, 4, false)
			else
				SetVehicleDoorOpen(vehicleHandle, 4, false)
				frontleft = true        
			end
		ClearPedTasksImmediately(GetPlayerPed(-1))
		Notify("~g~Vehicule Réparé. \n~r~Moteur Arreté.")
		TaskEnterVehicle(GetPlayerPed(-1), vehicleHandle, -1, -1, 1.0, 1, 0)
		SetVehicleUndriveable(vehicleHandle, true)
		Wait(5000)
		SetVehicleUndriveable(vehicleHandle, false)
		Wait(2000)
		TriggerEvent('VehiculeCapot')
		Wait(1000)
		TaskLeaveVehicle(GetPlayerPed(-1), vehicleHandle, 0)
	else
		Notify("~r~Il n'y a pas de vehicule devant vous.")
	end
end)

RegisterNetEvent("DepanneurFunction:clean")
AddEventHandler("DepanneurFunction:clean", function(data)
	Menu.hidden = true
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	
	if(DoesEntityExist(vehicleHandle)) then
		Menu.hidden = true
		TriggerEvent("DepanneurEmote:clean")
		Citizen.Wait(10000)
		SetVehicleDirtLevel(vehicleHandle, 0.0);
		ClearPedTasksImmediately(GetPlayerPed(-1))
		Notify("~g~Vehicule Nettoyé.")
	else
		Notify("~r~Il n'y a pas de vehicule devant vous.")
	end
end)

RegisterNetEvent('depann:OPENCLOSECAPOTDEPANNEUR')
AddEventHandler('depann:OPENCLOSECAPOTDEPANNEUR',function()

	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	
	if(DoesEntityExist(vehicleHandle)) then
		if not IsPedInAnyVehicle(playerped, true) then
			if GetVehicleDoorAngleRatio(vehicleHandle, 4) > 0.0 then 
				SetVehicleDoorShut(vehicleHandle, 4, false)
			else
				SetVehicleDoorOpen(vehicleHandle, 4, false)
				frontleft = true        
			end
		end
	else
		Notify("~r~Il n'y a pas de vehicule devant vous.")
	end
   
end)

RegisterNetEvent('depann:tow')
AddEventHandler('depann:tow',function()

    local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local towmodel = GetHashKey('flatbed') -- FlatBed
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
			
	if isVehicleTow then
	
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)
		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
		
		if currentlyTowedVehicle == nil then
			if(DoesEntityExist(vehicleHandle)) then
				if not IsPedInAnyVehicle(playerped, true) then
					if vehicle ~= vehicleHandle then
						AttachEntityToEntity(vehicleHandle, vehicle, 20, -0.5, -5.10, 1.1, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						--AttachEntityToEntityPhysically(vehicleHandle, vehicle, 20, GetPedBoneIndex(vehicleHandle), 0.0, -2.0, 1.25, 0.0, 0.0, 0.0, true, false, false, false, 20, true)
						currentlyTowedVehicle = vehicleHandle
					Notify("~g~Véhicule attaché !") -- Vehicle attached
					else
						Notify("~r~Vous ne pouvez pas dépanner votre véhicule !") -- You can't attach your vehicle
					end
				end
			else
			Notify("~b~Trop loin du véhicule !") -- You are not near vehicle
			end
		else
			--AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -13.0, 0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			AttachEntityToEntityPhysically(currentlyTowedVehicle, vehicle, 20, GetPedBoneIndex(vehicleHandle), 0.0, -10.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, true, true)
			DetachEntity(currentlyTowedVehicle, true, true)
			currentlyTowedVehicle = nil
			Notify("~r~Véhicule déttaché !") -- Vehicle removed
		end
	end

end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end