if ADMINTOOLS_FIVEM_VERSION.isDev == true then
	RconPrint("/!\\ Vous executez la version developpeur du script: ADMINTOOL !\n")
end

if(config.enableVersionNotifier) then
	PerformHttpRequest('http://127.0.0.1/Fivem/ADMINTOOL/version.json', function(err, text, headers)
		if text then
			local strToPrint = ""
		
			local decode_text = json.decode(text)
			if decode_text.num.prod_version > ADMINTOOLS_FIVEM_VERSION.num then
				strToPrint = "[ADMIN-TOOLS]: Une nouvelle version est disponible !\nVersion Actuelle: "..ADMINTOOLS_FIVEM_VERSION.str.." | Nouvelle version : "..decode_text.str.prod_version.."\n"
			elseif decode_text.num.prod_version < ADMINTOOLS_FIVEM_VERSION.num then
				if decode_text.num.dev_version == ADMINTOOLS_FIVEM_VERSION.num then
					strToPrint = "[ADMIN-TOOLS]: Votre version est a jour !\nVersion Actuelle: "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
				else
					strToPrint = "[ADMIN-TOOLS]: êtes-vous dans le futur !?\nCurrent version : "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
				end
			elseif decode_text.num.prod_version == ADMINTOOLS_FIVEM_VERSION.num then
				if ADMINTOOLS_FIVEM_VERSION.isDev == true then
					strToPrint = "[ADMIN-TOOLS]: Une nouvelle version est disponnible !\nVersion Actuelle : "..ADMINTOOLS_FIVEM_VERSION.str.." | Nouvelle Version : "..decode_text.str.dev_version.."\n"
				else
					strToPrint = "[ADMIN-TOOLS]: Votre version est a jour ! Version Actuelle : "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
				end
			end
			
			RconPrint(strToPrint);
		else
			RconPrint("The version provider service is unreachable !\n")
		end
	end, 'GET', '', {})
end

-- check admin pour le menu developpeur
RegisterServerEvent('AdminTools:CheckIfImAdminForMenu')
AddEventHandler('AdminTools:CheckIfImAdminForMenu', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		local group = user.getGroup();
		-- si le joueur est admin:
		--if (group == "admin") then
			TriggerClientEvent('AdminTools:ResultAdmin', _source, group)
		--end
	end)
end)

-- check admin pour le menu developpeur
RegisterServerEvent('AdminTools:addbank')
AddEventHandler('AdminTools:addbank', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		user.addBank(100)
		TriggerEvent('es:savemoney')
	end)
end)

RegisterServerEvent('AdminTools:rembank')
AddEventHandler('AdminTools:rembank', function()
	local _source = source
	TriggerEvent('es:getPlayerFromId', _source, function(user)
		user.removeBank(100)
		TriggerEvent('es:savemoney')
	end)
end)


