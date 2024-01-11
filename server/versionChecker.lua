-- check if user use dev version
if (config.isDev == true) then
	RconPrint("/!\\ Vous executez la version developpeur du script: ADMINTOOL !\n")
end

-- check version and compare with git
if (config.enableVersionNotifier) then
    print("["..GetCurrentResourceName().."] Checking for updates...\n")

    Citizen.CreateThread( function() 
        local updatepath = "/h0ldhaven/fivem-admintools" -- git path
        local resourceName = GetCurrentResourceName() -- resource name

        function checkVersion(err, responseText, headers)
            local currentVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- get local file

            if not responseText then
                print("Update check failed, where did the remote repository go ? ")
            elseif currentVersion ~= responseText and tonumber(currentVersion) < tonumber(responseText) then
                print("["..resourceName.."]: Une nouvelle version est disponible !\n Version Actuelle : " .. currentVersion .. " | Nouvelle Version : " .. responseText)
            elseif tonumber(currentVersion) > tonumber(responseText) then
                print("[".. resourceName .."]: version supérieur à l'originale.")
            else
                print("["..resourceName.."]: tout est à jour !")
            end
        end

        if (config.isDev == true) then
            PerformHttpRequest("https://raw.githubusercontent.com"..updatepath.."/dev/version", checkVersion, "GET")
        else
            PerformHttpRequest("https://raw.githubusercontent.com"..updatepath.."/main/version", checkVersion, "GET")
        end
    end)

end