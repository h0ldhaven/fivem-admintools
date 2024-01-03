-- check if user use dev version
if (ADMINTOOLS_FIVEM_VERSION.isDev == true) then
	RconPrint("/!\\ Vous executez la version developpeur du script: ADMINTOOL !\n")
end

-- check version and compare with git
if (config.enableVersionNotifier) then
    Citizen.CreateThread(function() 
		updatepath = "/h0ldhaven/fivem-admintools" -- git path
		resourceName = "FiveM-AdminTools-VersionChecker ("..GetCurrentResourceName()..")" -- resource name

		function checkVersion(err, text, headers)
			currentVersion = LoadResourceFile(GetCurrentResourceName(), "version")

			if currentVersion ~= text and tonumber(currentVersion) < tonumber(text) then
				RconPrint("["..resourceName.."]: Une nouvelle version est disponible !\nVersion Actuelle : "..currentVersion.." | Nouvelle Version : "..text.."\n")
			elseif tonumber(currentVersion) > tonumber(text) then
				RconPrint("["..resourceName.."]: Vous avez sauté quelques versions ou avez modifié le script de base, nous vous conseillons de rétrograder sur la version officielle ou aucun support ne vous sera fourni.")
			else
				RconPrint("["..resourceName.."]: tout est à jour !")
			end
		end

        if (ADMINTOOLS_FIVEM_VERSION.isDev == true) then
            PerformHttpRequest("https://raw.githubusercontent.com"..updatepath.."dev/version", checkVersion, "GET")
        else
            PerformHttpRequest("https://raw.githubusercontent.com"..updatepath.."main/version", checkVersion, "GET")
        end
	end)
end

-- old code

-- if(config.enableVersionNotifier) then
-- 	PerformHttpRequest('http://127.0.0.1/Fivem/ADMINTOOL/version.json', function(err, text, headers)
-- 		if text then
-- 			local strToPrint = ""
		
-- 			local decode_text = json.decode(text)
-- 			if decode_text.num.prod_version > ADMINTOOLS_FIVEM_VERSION.num then
-- 				strToPrint = "[ADMIN-TOOLS]: Une nouvelle version est disponible !\nVersion Actuelle: "..ADMINTOOLS_FIVEM_VERSION.str.." | Nouvelle version : "..decode_text.str.prod_version.."\n"
-- 			elseif decode_text.num.prod_version < ADMINTOOLS_FIVEM_VERSION.num then
-- 				if decode_text.num.dev_version == ADMINTOOLS_FIVEM_VERSION.num then
-- 					strToPrint = "[ADMIN-TOOLS]: Votre version est a jour !\nVersion Actuelle: "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
-- 				else
-- 					strToPrint = "[ADMIN-TOOLS]: êtes-vous dans le futur !?\nCurrent version : "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
-- 				end
-- 			elseif decode_text.num.prod_version == ADMINTOOLS_FIVEM_VERSION.num then
-- 				if ADMINTOOLS_FIVEM_VERSION.isDev == true then
-- 					strToPrint = "[ADMIN-TOOLS]: Une nouvelle version est disponnible !\nVersion Actuelle : "..ADMINTOOLS_FIVEM_VERSION.str.." | Nouvelle Version : "..decode_text.str.dev_version.."\n"
-- 				else
-- 					strToPrint = "[ADMIN-TOOLS]: Votre version est a jour ! Version Actuelle : "..ADMINTOOLS_FIVEM_VERSION.str.."\n"
-- 				end
-- 			end
			
-- 			RconPrint(strToPrint);
-- 		else
-- 			RconPrint("The version provider service is unreachable !\n")
-- 		end
-- 	end, 'GET', '', {})
-- end