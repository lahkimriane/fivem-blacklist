ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("blacklist", function(source, args, rawCommand) 	
	idnum = tonumber(args[1])
	duration = tonumber(args[2])
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
		local playergroup = xPlayer.getGroup()
		if playergroup == 'superadmin' then	
	TriggerClientEvent("blacklist:set", idnum, duration)
else
	xPlayer.ShowNotification("Vous n'avez pas accès à cette commande")
  end
  end)
