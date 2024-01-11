-----------------------------------------------------------------------------------------------------------
--------------------------------------------- SCRIPT ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

---------------------------------
-------- local variables --------
---------------------------------

local playing_emote = false
local userGroup = rank.name
local isAnAdmin = rank.isAdmin

---------------------------------
-------- thread function --------
---------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- when player press F7
		if IsControlJustPressed(1, Menu.keyOpenMenu) then
			-- send server event to test player grade
			TriggerServerEvent('AdminTools:CheckPerm')
		end
		if IsControlJustPressed(1, 32) then -- INPUT_MOVE_UP_ONLY
			if (playing_emote == true) then
				ClearPedTasksImmediately(GetPlayerPed(-1));
				playing_emote = false
			end
		end
	end
end)

----------------------------------
-------- global functions --------
----------------------------------

-- return true if player has role "admin" and isAnAdmin = true
function isAdmin()
	--print("group = " .. userGroup .. " \nisAdmin = " .. tostring(isAnAdmin));
	if (userGroup == tostring("admin") and isAnAdmin == true) then
		return true
	else
		return false
	end
end

-- return true if player has role "mod" and isAnAdmin = false
function isMod()
	--print("group = " .. userGroup .. " \nisAdmin = " .. tostring(isAnAdmin));
	if (userGroup == tostring("mod") and isAnAdmin == false) then
		return true
	else
		return false
	end
end

-- return true if player has role "user" and isAnAdmin = false
function isPlayer()
	--print("group = " .. userGroup .. " \nisAdmin = " .. tostring(isAnAdmin));
	if (userGroup == tostring("user") and isAnAdmin == false) then
		return true
	else
		return false
	end
end

-- return true if player is in vehicle
function IsInVehicle()
	local ply = GetPlayerPed(-1)
	if IsPedSittingInAnyVehicle(ply) then
	  return true
	else
	  return false
	end
  end

-- Exemple Function
function functionTest(data) 
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Function call: " .. data.Title)
    if data.extraData ~= nil then 
        TriggerEvent('chatMessage', "", {255, 0, 0}, "extraData : " .. data.extraData)
    end
end

-- fonction to disable some controls when menu is open
function DisableControl()
	if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		DisableControlAction(1, 80, true) -- INPUT_SELECT_WEAPON
	end
	DisablePlayerFiring(entityPed, true) -- Disable weapon firing
	DisableControlAction(1, 0, true) -- Next camera
	DisableControlAction(1, 20, true) -- INPUT_MULTIPLAYER_INFO
	DisableControlAction(1, 21, true) -- INPUT_SPRINT
	DisableControlAction(1, 22, true) -- INPUT_JUMP
	--DisableControlAction(1, 23, true) -- Enter
	DisableControlAction(1, 24, true) -- Attack
	DisableControlAction(1, 25, true) -- INPUT_AIM
	DisableControlAction(1, 28, true) -- INPUT_SPECIAL_ABILITY
	DisableControlAction(1, 26, true) -- Look behind
	--DisableControlAction(1, 30, true) -- Movement
	--DisableControlAction(1, 31, true) -- Movement
	DisableControlAction(1, 36, true) -- INPUT_DUCK
	DisableControlAction(1, 37, true) -- INPUT_SELECT_WEAPON
	DisableControlAction(1, 38, true) -- INPUT_PICKUP
	DisableControlAction(1, 39, true) -- INPUT_SNIPER_ZOOM
	DisableControlAction(1, 44, true) -- cover
	DisableControlAction(1, 45, true) -- Reload
	DisableControlAction(1, 47, true) -- Detonate
	DisableControlAction(1, 48, true) -- INPUT_HUD_SPECIAL
	DisableControlAction(1, 49, true) -- INPUT_ARREST
	DisableControlAction(1, 52, true) -- INPUT_CONTEXT_SECONDARY
	DisableControlAction(1, 53, true) -- INPUT_WEAPON_SPECIAL
	DisableControlAction(1, 54, true) -- INPUT_WEAPON_SPECIAL_TWO
	DisableControlAction(1, 55, true) -- INPUT_DIVE
	DisableControlAction(1, 58, true) -- INPUT_THROW_GRENADE
	DisableControlAction(1, 140, true) -- Attack
	DisableControlAction(1, 141, true) -- Attack
	DisableControlAction(0, 142, true) -- Attack
	DisableControlAction(1, 142, true) -- Attack
	DisableControlAction(1, 199, true) -- Pause menu
	DisableControlAction(1, 245, true) -- INPUT_MP_TEXT_CHAT_ALL
	DisableControlAction(1, 257, true) -- Attack
	DisableControlAction(1, 263, true) -- Attack
	DisableControlAction(1, 264, true) -- Attack
end

----------------------------
-------- net events --------
----------------------------

RegisterNetEvent("AdminTools:ResultPerm")
AddEventHandler("AdminTools:ResultPerm", function(rankName, isAdmin)
	userGroup = rankName;
	isAnAdmin = isAdmin
	if (rankName == tostring("admin") and isAdmin == true) then
		Menu.initMenu()
		Menu.isOpen = not Menu.isOpen
		if (config.debugMessage == true) then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "Rank = " .. rankName .. "\nisAdmin = " .. tostring(isAdmin))
		end
	else
		if (config.debugMessage == true) then
			TriggerEvent('chatMessage', "", {255, 0, 0}, "Rank = " .. rankName .. "\nisAdmin = " .. tostring(isAdmin))
		end
	end
end)

-- Exemple Events
-- RegisterNetEvent("gc:eventMenu")
-- AddEventHandler("gc:eventMenu", function(data)
--     TriggerEvent('chatMessage', "", {255, 0, 0}, "Event call (" .. data.Event .. ") : " .. data.Title)
-- end)

-- RegisterNetEvent("AdminTools:Foudre")
-- AddEventHandler("AdminTools:Foudre", function()
-- 	ForceLightningFlash()
-- end)

-- RegisterNetEvent("AdminTools:addbank")
-- AddEventHandler("AdminTools:addbank", function()
-- 	TriggerServerEvent('AdminTools:addbank')
-- end)
-- RegisterNetEvent("AdminTools:rembank")
-- AddEventHandler("AdminTools:rembank", function()
-- 	TriggerServerEvent('AdminTools:rembank')
-- end)