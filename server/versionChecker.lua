-- check if user use dev version
if (config.isDev == true) then
	RconPrint(i18n.translate("console_use_dev"))
end

-- check version and compare with git
if (config.enableVersionNotifier) then
    print("["..GetCurrentResourceName().."]: " .. i18n.translate("console_checking_update"))

    Citizen.CreateThread( function() 
        local resourceName = GetCurrentResourceName() -- resource name

        function checkVersion(err, responseText, headers)
            local currentVersion = LoadResourceFile(GetCurrentResourceName(), "version") -- get local file

            if not responseText then
                print(i18n.translate("console_update_fail"))
            elseif currentVersion ~= responseText and tonumber(currentVersion) < tonumber(responseText) then
                --print("["..resourceName.."]: Une nouvelle version est disponible !\n Version Actuelle : " .. currentVersion .. " | Nouvelle Version : " .. responseText)
                print(i18n.translate("script_name") .. i18n.translate("console_update_version_available") .. i18n.translate("console_update_actual_version") .. "^1" .. currentVersion .. " ^7| " .. i18n.translate("console_update_new_version") .. "^2" .. responseText .. "^7")
            elseif tonumber(currentVersion) > tonumber(responseText) then
                print(i18n.translate("script_name") .. i18n.translate("console_update_version_sup"))
            else
                print(i18n.translate("script_name") .. i18n.translate("console_update_version_ok"))
            end
        end

        if (config.isDev == true) then
            PerformHttpRequest("https://raw.githubusercontent.com" .. git.path .. git.dev, checkVersion, "GET")
        else
            PerformHttpRequest("https://raw.githubusercontent.com" .. git.path .. git.main, checkVersion, "GET")
        end
    end)

end