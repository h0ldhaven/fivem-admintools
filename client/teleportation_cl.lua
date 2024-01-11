-- script téléportation
RegisterNetEvent("AdminTools_TP:CheckAdminMarker")
AddEventHandler("AdminTools_TP:CheckAdminMarker", function()
	if (isAdmin()) then
		TriggerEvent("AdminTools_TP:TPMarker")
	else
		TriggerEvent("AdminTools:IsNotAdmin")
	end
end)

RegisterNetEvent("AdminTools_TP:TPMarker")
AddEventHandler("AdminTools_TP:TPMarker", function()
	--Citizen.CreateThread(function()
		--while true do
			--Citizen.Wait(0)
			
			local playerPed = GetPlayerPed(-1)
			local WaypointHandle = GetFirstBlipInfoId(8)
			if DoesBlipExist(WaypointHandle) then
				--if IsControlJustPressed(1, 201) then
					local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
					SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
					TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("teleport_confirm"), 0.200)
				--end
			end
		--end
	--end)
end)