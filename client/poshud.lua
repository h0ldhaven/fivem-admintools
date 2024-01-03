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

RegisterNetEvent("AdminTools_HUD:ON")
AddEventHandler("AdminTools_HUD:ON", function()
	HUDActive = true
end)

RegisterNetEvent("AdminTools_HUD:OFF")
AddEventHandler("AdminTools_HUD:OFF", function()
	HUDActive = false
end)

