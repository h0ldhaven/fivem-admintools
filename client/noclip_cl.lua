-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------    SCRIPT    ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

local noclip = false
local noclip_speed = 1.0
local RGBActiveNoclip = false
local StatusNoclip = i18n.translate("Noclip_enabled") .. i18n.translate("Noclip_speed") .. "("..noclip_speed..")."

RegisterNetEvent("AdminTools:noclip")
AddEventHandler("AdminTools:noclip", function()
	admin_no_clip()
end)

function admin_no_clip()
	noclip = not noclip
	local ped = GetPlayerPed(-1)
	if noclip then -- activé
		--SetEntityVisible(ped, false, false)
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_ON"), 0.080)
		RGBActiveNoclip = true
		while true do
			Citizen.Wait(0)
			if (RGBActiveNoclip == true) then
				ACstatus(0.01, 0.06, 1.0,1.0,0.4, i18n.translate("Noclip_HUD") .. StatusNoclip, 0, 255, 0, 255, 200)
			end
		end
	else -- désactivé
		--SetEntityVisible(ped, true, false)
		RGBActiveNoclip = false
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_OFF"), 0.080)
	end
end

RegisterNetEvent("AdminTools:noclip+")
AddEventHandler("AdminTools:noclip+", function()
	if noclip then
		if (noclip_speed >= 1.8) then
			TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_max_speed") .. "~y~ " .. noclip_speed .. "~r~." , 0.100)
		else
			--TriggerEvent("AdminTools_General:sendNotification", notificationParam, "~w~Vitesse du noclip: ".. noclip_speed ..".", 0.100)
			noclip_speed = noclip_speed + 0.2
			StatusNoclip = i18n.translate("Noclip_enabled") .. i18n.translate("Noclip_speed") .. "("..noclip_speed..")."
		end
	else
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_no_noclip"), 0.100)
	end
end)

RegisterNetEvent("AdminTools:noclip-")
AddEventHandler("AdminTools:noclip-", function()
	if noclip then
		if (noclip_speed <= 0.3) then
			TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_min_speed") .. "~y~ ".. noclip_speed .. "~r~." , 0.100)
		else
			--TriggerEvent("AdminTools_General:sendNotification", notificationParam, "~w~Vitesse du noclip: ".. noclip_speed ..".", 0.100)
			noclip_speed = noclip_speed - 0.2
			StatusNoclip = i18n.translate("Noclip_enabled") .. i18n.translate("Noclip_speed") .. "("..noclip_speed..")."
		end
	else
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_no_noclip"), 0.100)
	end
end)

RegisterNetEvent("AdminTools:noclip0")
AddEventHandler("AdminTools:noclip0", function()
	if noclip then
		noclip_speed = 1.0
		--TriggerEvent("AdminTools_General:sendNotification", notificationParam, "~w~Vitesse du noclip: ".. noclip_speed ..".", 0.100)
		StatusNoclip = i18n.translate("Noclip_enabled") .. i18n.translate("Noclip_speed") .. "("..noclip_speed..")."
	else
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Noclip_no_noclip"), 0.100)
	end
end)

function getPosition()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	return x,y,z
end

function getCamDirection()
	local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
	local pitch = GetGameplayCamRelativePitch()

	local x = -math.sin(heading*math.pi/180.0)
	local y = math.cos(heading*math.pi/180.0)
	local z = math.sin(pitch*math.pi/180.0)

	local len = math.sqrt(x*x+y*y+z*z)
	if len ~= 0 then
		x = x/len
		y = y/len
		z = z/len
	end

	return x,y,z
end

function isNoclip()
	return noclip
end

-- noclip/invisible
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if noclip then
			local ped = GetPlayerPed(-1)
			local x,y,z = getPosition()
			local dx,dy,dz = getCamDirection()
			local speed = noclip_speed

			-- reset du velocity
			SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

			-- aller vers le haut
			if IsControlPressed(0,32) then -- MOVE UP
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			-- aller vers le bas
			if IsControlPressed(0,269) then -- MOVE DOWN
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end

			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
	end
end)