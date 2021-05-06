ESX = nil
local blacklist = 0
local bl = false
local time = 0

RegisterNetEvent("blacklist:set")
  AddEventHandler("blacklist:set", function(duration)
      blacklist = duration
	  bl = true
	  Citizen.CreateThread(function()
		time = blacklist 
		while (time ~= 0) do 
			Wait( 1000 ) 
			time = time - 1
		end
		bl = false
	end)	
  end)

Citizen.CreateThread(function()
	while true do
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
        if IsControlJustReleased(1, 168) then --F7                 		
		end
		Citizen.Wait(10)

	end
end)

local notifIn = false
local notifOut = false

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)

		if bl then  
			if not notifIn then																			
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				ESX.ShowNotification("You are Blacklisted")
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				
				ESX.ShowNotification("You are no longer Blacklisted")
				notifOut = true
				notifIn = false
			end
		end
		if notifIn then
		DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
		DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
      	DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
				local min        = time / 60
				local sec    = (min - math.floor(min)) * 60
				local txtmin     = math.floor(min)
				local txtsec = math.ceil(sec) 
				ESX.ShowNotification("You are Blacklisted : " ..  txtmin .. " minutes " .. txtsec .. " seconds")
			end
			if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
				local min        = time / 60
				local sec    = (min - math.floor(min)) * 60
				local txtmin     = math.floor(min)
				local txtsec = math.ceil(sec) 
				ESX.ShowNotification("You are Blacklisted : " ..  txtmin .. " minutes " .. txtsec .. " seconds")
			end
		end
		
	end
end)


