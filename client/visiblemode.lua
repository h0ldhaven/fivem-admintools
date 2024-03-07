-----------------------------------------------------------------------------------------------------------
-----------------------------------------    SCRIPT    ----------------------------------------------------
-----------------------------------------------------------------------------------------------------------

local visible = false
local RGBActiveInvisible = false
local StatusVisible = i18n.translate("Visible_enabled")

RegisterNetEvent("AdminTools:visible")
AddEventHandler("AdminTools:visible", function()
	if (isAdmin()) then
		admin_visible()
	else
		TriggerEvent("AdminTools:IsNotAdmin")
	end
end)

function admin_visible()
	visible = not visible
	local ped = GetPlayerPed(-1)
	if visible then -- activé
		SetEntityVisible(ped, false, false)
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Visible_ON"), 0.080)
		RGBActiveInvisible = true
		while true do
			Citizen.Wait(0)
			if (RGBActiveInvisible == true) then
				ACstatus(0.01, 0.09, 1.0,1.0,0.4, i18n.translate("Visible_HUD") .. StatusVisible, 0, 255, 0, 255, 200)
			end
		end
	else -- désactivé
		SetEntityVisible(ped, true, false)
		RGBActiveInvisible = false
		TriggerEvent("AdminTools_General:sendNotification", config.notificationParam, "CHAR_DETONATEPHONE", i18n.translate("Visible_Off"), 0.080)
	end
end
