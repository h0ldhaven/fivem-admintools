local HUDActive = false
Citizen.CreateThread(function()
	while true do
	
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(GetPlayerPed(-1))
		local playerHeading = GetEntityHeading(GetPlayerPed(-1))
		if (HUDActive == true) then
			Text("POSITIONS:\nX: " .. math.ceil(playerPos.x) .." \nY: " .. math.ceil(playerPos.y) .." \nZ: " .. math.ceil(playerPos.z) .." \nHeading: " .. math.ceil(playerHeading) .."")
		end
	end
end)

RegisterNetEvent("AdminTools_HUD:ON")
AddEventHandler("AdminTools_HUD:ON", function()
	HUDActive = true
end)

RegisterNetEvent("AdminTools_HUD:OFF")
AddEventHandler("AdminTools_HUD:OFF", function()
	HUDActive = false
end)

