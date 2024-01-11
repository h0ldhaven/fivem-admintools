-- check if player is admin before open menu
RegisterServerEvent('AdminTools:CheckPerm')
AddEventHandler('AdminTools:CheckPerm', function()
	local _source = source
    -- get player info
	TriggerEvent('es:getPlayerFromId', _source, function(user)
        -- get player group
		local group = user.getGroup();

        -- set args before sending result to client
        if (group == tostring("admin")) then
            rank.name = "admin"
            rank.isAdmin = true
        elseif (group == tostring("modo")) then
            rank.name = "modo"
            rank.isAdmin = false
        else
            rank.name = "user"
            rank.isAdmin = false
        end

        -- send client event with args rank.name and rank.isAdmin
		TriggerClientEvent('AdminTools:ResultPerm', _source, rank.name, rank.isAdmin)
	end)
end)