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

-- return player position (x, y, z)
function getPosition()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
	return x,y,z
end

-- return player look direction
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

-- Exemple Function
function functionTest(data) 
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Function call: " .. data.Title)
    if data.extraData ~= nil then 
        TriggerEvent('chatMessage', "", {255, 0, 0}, "extraData : " .. data.extraData)
    end
end

--====================================================================================
--  Menu System
--====================================================================================

function Menu.drawRect(posX, posY, width, heigh, color)
    DrawRect(posX + width / 2, posY + heigh / 2, width, heigh, color[1], color[2], color[3], color[4])
end

function Menu.initText(textColor, font, scale)
    font = font or 0
    scale = scale or 0.35
    SetTextFont(font)
    SetTextScale(0.0,scale)
    SetTextCentre(false)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextEntry("STRING")
end

function Menu.draw() 
    -- Draw Rect
    local pos = 0
    local menu = Menu.getCurrentMenu()
    local selectValue = Menu.currentPos[#Menu.currentPos]
    local nbItem = #menu.Items
    -- draw background title & title
    Menu.drawRect(Menu.posX, Menu.posY , Menu.ItemWidth, Menu.ItemHeight * 2, Menu.tileBackgroundColor)    
    Menu.initText(Menu.tileTextColor, 4, 0.7)
    AddTextComponentString(menu.Title)
    DrawText(Menu.posX + Menu.ItemWidth/20.0, Menu.posY+0.008)

    -- draw bakcground items
    Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * 2, Menu.ItemWidth, Menu.ItemHeight + (nbItem-1)*Menu.ItemHeight, Menu.backgroundColor)
    -- draw all items
    for pos, value in pairs(menu.Items) do
        if pos == selectValue then
            Menu.drawRect(Menu.posX, Menu.posY + Menu.ItemHeight * (1+pos), Menu.ItemWidth, Menu.ItemHeight, Menu.backgroundColorActive)
            Menu.initText(Menu.textColorActive)
        else
            Menu.initText(Menu.textColor)
        end
        AddTextComponentString(value.Title)
        DrawText(Menu.posX + 0.010, Menu.posY + Menu.ItemHeight * (pos+1))
    end
    
end

function Menu.getCurrentMenu()
    local currentMenu = Menu.item
    for i=1, #Menu.currentPos - 1 do
        local val = Menu.currentPos[i]
        currentMenu = currentMenu.Items[val].SubMenu
    end
    return currentMenu
end

function Menu.initMenu()
    Menu.currentPos = {1}
end

function Menu.keyControl()
    if IsControlJustPressed(1, Menu.keyDown) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = (Menu.currentPos[slcp] % size) + 1

    elseif IsControlJustPressed(1, Menu.keyUp) then 
        local cMenu = Menu.getCurrentMenu()
        local size = #cMenu.Items
        local slcp = #Menu.currentPos
        Menu.currentPos[slcp] = ((Menu.currentPos[slcp] - 2 + size) % size) + 1

    elseif IsControlJustPressed(1, Menu.KeyCancel) then 
        table.remove(Menu.currentPos)
        if #Menu.currentPos == 0 then
            Menu.isOpen = false 
        end

    elseif IsControlJustPressed(1, Menu.keySelect)  then
        local cSelect = Menu.currentPos[#Menu.currentPos]
        local cMenu = Menu.getCurrentMenu()
        if cMenu.Items[cSelect].SubMenu ~= nil then
            Menu.currentPos[#Menu.currentPos + 1] = 1
        else
            if cMenu.Items[cSelect].Function ~= nil then
                cMenu.Items[cSelect].Function(cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Event ~= nil then
                TriggerEvent(cMenu.Items[cSelect].Event, cMenu.Items[cSelect])
            end
            if cMenu.Items[cSelect].Close == nil or cMenu.Items[cSelect].Close == true then
                Menu.isOpen = false
            end
        end
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

RegisterCommand("giveweapon", function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)
	local weaponHash = GetHashKey(args[1])
	local ammoCount = 9999

	GiveWeaponToPed(playerPed, weaponHash, ammoCount, false)
	SetPedInfiniteAmmo(playerPed, true, weaponHash)
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