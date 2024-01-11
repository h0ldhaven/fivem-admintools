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