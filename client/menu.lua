Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

        if Menu.isOpen then
            Menu.draw()
            Menu.keyControl()
            -- disable control event here.
            DisableControl()
        end
    end
end)

--[[############  MENU  ############]]--
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