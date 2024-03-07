-- check if player is admin before open menu
RegisterServerEvent('AdminTools:CheckPerm')
AddEventHandler('AdminTools:CheckPerm', function()
    local _source = source
    -- es framework
    if (config.framework == tostring("es")) then
        -- get player info
        TriggerEvent('es:getPlayerFromId', _source, function(user)
            -- get player group
            local group = user.getGroup();

            -- set args before sending result to client
            -- if player is in admin group
            if (group == tostring("admin")) then
                rank.name = "admin"
                rank.isAdmin = true
            -- if player is in mod group
            elseif (group == tostring("mod")) then
                rank.name = "modo"
                rank.isAdmin = false
            -- player have another group, set own group to "user"
            else
                rank.name = "user"
                rank.isAdmin = false
            end

            -- send client event with args rank.name and rank.isAdmin
            TriggerClientEvent('AdminTools:ResultPerm', _source, rank.name, rank.isAdmin)
        end)
    -- es_extended framework
    elseif (config.framework == tostring("es_extended")) then

        -- player definition
        local xPlayer = ESX.GetPlayerFromId(_source)

        -- if player is in admin group
        if (xPlayer.group == tostring("admin")) then
            rank.name = "admin"
            rank.isAdmin = true
        -- if player is in mod group
        elseif (xPlayer.group == tostring("mod")) then
            rank.name = "modo"
            rank.isAdmin = false
        -- player have another group, set own group to "user"
        else
            rank.name = "user"
            rank.isAdmin = false
        end
        -- send result to client
        TriggerClientEvent('AdminTools:ResultPerm', _source, rank.name, rank.isAdmin)
    else
        -- if framework is incorrect, send error
        print(i18n.translate("unsupported_version"))
    end
end)