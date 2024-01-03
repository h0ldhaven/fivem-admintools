-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
--------------------------------------------- SCRIPT ------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local playing_emote = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Menu.keyOpenMenu) then -- INPUT_MOVE_UP_ONLY
			TriggerServerEvent('AdminTools:CheckIfImAdminForMenu')
		end
		if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
			DisableControl()
        end
		if IsControlJustPressed(1, 32) then -- INPUT_MOVE_UP_ONLY
			if (playing_emote == true) then
				ClearPedTasksImmediately(GetPlayerPed(-1));
				playing_emote = false
			end
		end
	end
end)

-- le serveur renvoie le nom du groupe vers cette variable
RegisterNetEvent("AdminTools:ResultAdmin")
AddEventHandler("AdminTools:ResultAdmin", function(group)
	-- si le groupe testé retourne admin:
	if (group == "admin") then
		-- on ouvre le menu developpeur
		Menu.initMenu()
		Menu.isOpen = not Menu.isOpen
	end
end)

--[[############  MENU  ############]]--
Menu = {}
Menu.item = {
    ['Title'] = 'Menu Developpeur:',
    ['Items'] = {
	
		{['Title'] = 'Fonction Admin', ['SubMenu'] = {
            ['Title'] = 'Fonctions:',
                ['Items'] = {
                    { ['Title'] = 'Mode Noclip', ['Event'] = 'AdminTools:noclip', ['Close'] = false},
                    { ['Title'] = 'Vitesse Noclip', ['SubMenu'] = {
						['Title'] = 'Vitesse:',
						['Items'] = {
							{ ['Title'] = '+', ['Event'] = 'AdminTools:noclip+', ['Close'] = false},
							{ ['Title'] = '-', ['Event'] = 'AdminTools:noclip-', ['Close'] = false},
							{ ['Title'] = 'Reset', ['Event'] = 'AdminTools:noclip0', ['Close'] = false},
						},
					}},
					
					{ ['Title'] = 'Mode Invisible', ['Event'] = 'AdminTools:visible', ['Close'] = false},
					{ ['Title'] = 'Mode Skin Admin', ['Event'] = 'adminskin:LaunchCommand', ['Close'] = false},
                }
            }
		},
		
		{['Title'] = 'Menu Positions', ['SubMenu'] = {
            ['Title'] = 'HUD:',
                ['Items'] = {
                    { ['Title'] = 'Afficher', ['Event'] = 'AdminTools_HUD:ON', ['Close'] = true},
					{ ['Title'] = 'Cacher', ['Event'] = 'AdminTools_HUD:OFF', ['Close'] = true},
                }
            }
		},
		
		{['Title'] = 'Menu Téléportation', ['SubMenu'] = {
            ['Title'] = 'Téléportation:',
                ['Items'] = {
					{ ['Title'] = 'Se téléporter à un point', ['Event'] = 'AdminTools_TP:CheckAdminMarker', ['Close'] = true},
                    { ['Title'] = 'Se téléporter à un joueur', ['Event'] = '', ['Close'] = true},
                }
            }
		},
		
		{['Title'] = 'Menu Véhicules', ['SubMenu'] = {
            ['Title'] = 'Véhicule:',
                ['Items'] = {
                    { ['Title'] = 'Invoquer un véhicule', ['Event'] = 'AdminCar:SpawnVeh', ['Close'] = true},
					{ ['Title'] = 'Supprimer un véhicule', ['Event'] = 'AdminCar:ClearCar', ['Close'] = true},
					{ ['Title'] = 'Réparer un véhicule', ['Event'] = 'AdminCar:RepairCar', ['Close'] = true},
					{ ['Title'] = 'Détruire un véhicule', ['Event'] = 'AdminCar:DestroyCar', ['Close'] = true},
                }
            }
		},
		
		{['Title'] = 'Menu Annonces', ['SubMenu'] = {
            ['Title'] = 'Annonces:',
                ['Items'] = {
                    { ['Title'] = 'Annonces (30S)', ['Event'] = 'Decompte:LaunchCommand', ['Close'] = true},
					{ ['Title'] = 'Reboot serveur (30S)', ['Event'] = 'AdminTools_Reboot:RunCommandServer', ['Close'] = true},
                }
            }
		},
		
		{ ['Title'] = 'Envoyer la foudre', ['Event'] = 'AdminTools:Foudre', ['Close'] = true },
		
		--{ ['Title'] = 'Ajouter 100$ banque', ['Event'] = 'AdminTools:addbank', ['Close'] = false },
		--{ ['Title'] = 'Retirer 100$ banque', ['Event'] = 'AdminTools:rembank', ['Close'] = false },
		
		--[[{['Title'] = 'TEST Depanneur', ['SubMenu'] = {
            ['Title'] = 'TEST Depanneur',
                ['Items'] = {
                    { ['Title'] = 'Réparer le véhicule', ['Event'] = 'DepanneurFunction:repair', ['Close'] = true},
					{ ['Title'] = 'Attacher/Détacher', ['Event'] = 'depann:tow', ['Close'] = true},
					{ ['Title'] = 'Nettoyer le véhicule', ['Event'] = 'DepanneurFunction:clean', ['Close'] = true},
					{ ['Title'] = 'ouvrir/Fermer le capot', ['Event'] = 'depann:OPENCLOSECAPOTDEPANNEUR', ['Close'] = true},
					{ ['Title'] = 'test', ['Event'] = 'EmoteTest', ['Close'] = false},
                }
            }
		},]]--
		
		{ ['Title'] = 'Get player list', ['Event'] = 'AdminTools_TAB:GetPlayers', ['Close'] = true },
        
		{ ['Title'] = 'Fermer le Menu', ['Event'] = '', ['Close'] = true },
		
	-- EXEMPLES DE MENUS
	
       -- { ['Title'] = 'Fermer le Menu', ['Event'] = 'gc:openMeIdentity', ['Close'] = false },
		
		--submenu 1 (sous menu)
		--[[ 
		{['Title'] = 'SubMenu 1', ['SubMenu'] = {
            ['Title'] = 'Menu SubMenu 1',
            ['Items'] = {
                {['Title'] = 'SubMenu 2', ['SubMenu'] = {
                    ['Title'] = 'Menu SubMenu 2',
                    ['Items'] = {
                        {['Title'] = 'SubMenu 3', ['SubMenu'] = {
                            ['Title'] = 'Menu SubMenu 3',
                            ['Items'] = {
                                { ['Title'] = 'Function Data', ['Function'] = functionTest, ['extraData'] = 'I am Data' },
                            }
                        }}
                    }
                }},
                { ['Title'] = 'Function 1-1', ['Function'] = functionTest },
                { ['Title'] = 'Event 1-1', ['Event'] = 'gc:eventMenu' },
            }
        }}
		]]--	
		
    }
}

-- Exemple Function
function functionTest(data) 
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Function call: " .. data.Title)
    if data.extraData ~= nil then 
        TriggerEvent('chatMessage', "", {255, 0, 0}, "extraData : " .. data.extraData)
    end
end

-- Exemple Event
RegisterNetEvent("gc:eventMenu")
AddEventHandler("gc:eventMenu", function(data)
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Event call (" .. data.Event .. ") : " .. data.Title)
end)

RegisterNetEvent("AdminTools:Foudre")
AddEventHandler("AdminTools:Foudre", function()
	ForceLightningFlash()
end)

RegisterNetEvent("AdminTools:addbank")
AddEventHandler("AdminTools:addbank", function()
	TriggerServerEvent('AdminTools:addbank')
end)
RegisterNetEvent("AdminTools:rembank")
AddEventHandler("AdminTools:rembank", function()
	TriggerServerEvent('AdminTools:rembank')
end)

--------------------------------------------------------------------------------------------
----------------------------------------  GUI  ---------------------------------------------
--------------------------------------------------------------------------------------------
--====================================================================================
--  Option Menu
--====================================================================================
Menu.backgroundColor = { 52, 73, 94, 196 }
Menu.backgroundColorActive = { 38,168,221, 255 }
Menu.tileTextColor = { 255, 255, 255, 255 }
Menu.tileBackgroundColor = { 18,80,163, 155 }
Menu.textColor = { 255,255,255,255 }
Menu.textColorActive = { 255,255,255, 255 }

Menu.keyOpenMenu = 168 -- F7    
Menu.keyUp = 172 -- PhoneUp
Menu.keyDown = 173 -- PhoneDown
Menu.keyLeft = 174 -- PhoneLeft || Not use next release Maybe 
Menu.keyRight =	175 -- PhoneRigth || Not use next release Maybe 
Menu.keySelect = 176 -- PhoneSelect
Menu.KeyCancel = 177 -- PhoneCancel

Menu.posX = 0.760
Menu.posY = 0.25

Menu.ItemWidth = 0.20
Menu.ItemHeight = 0.03

Menu.isOpen = false   -- /!\ Ne pas toucher
Menu.currentPos = {1} -- /!\ Ne pas toucher

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

-- fonction pour desactiver toute interaction quand le menu est ouvert
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