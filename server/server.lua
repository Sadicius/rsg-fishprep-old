local RSGCore = exports['rsg-core']:GetCoreObject()

-- local function ShowId(source, item)
--     local src = source
--     local found = false
--     local Player = RSGCore.Functions.GetPlayer(src)
--     local PlayerPed = GetPlayerPed(src)
--     local PlayerCoords = GetEntityCoords(PlayerPed)
--     local info = {
--         -- ['name'] = Player.PlayerData.charinfo.firstname,
--         -- ['lastname'] = Player.PlayerData.charinfo.lastname,
--         -- ['gender'] = Player.PlayerData.charinfo.gender,
--         -- ['dob'] = Player.PlayerData.charinfo.birthdate,
--     }
-- end

----------------------------------------------------
-- items stash
----------------------------------------------------

RSGCore.Functions.CreateUseableItem("fishbasin_ms", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- ShowId(src, 'fishbasin_ms')
    TriggerClientEvent('rsg-fishprep:client:setupfishbasinB', src, item.info.mediumfishbackpackid)
end)

RSGCore.Functions.CreateUseableItem("fishbasin_xl", function(source, item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- ShowId(src, 'fishbasin_xl')
    TriggerClientEvent('rsg-fishprep:client:setupfishbasinC', src, item.info.bigfishbackpackid)
end)

----------------------------------------------------
-- break items
----------------------------------------------------

RegisterServerEvent('rsg-fishprep:server:breakknife')
AddEventHandler('rsg-fishprep:server:breakknife', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if item == Config.itemfishing then
        Player.Functions.RemoveItem(Config.itemfishing, 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[Config.itemfishing], "add")

        TriggerClientEvent('ox_lib:notify', src, {title = 'Success', description = 'your knife broke', type = 'success' })

    else
        TriggerClientEvent('ox_lib:notify', src, {title = 'Error', description = 'something went wrong', type = 'error' })
            print('something went wrong with the script could be exploint!')
    end
end)

----------------------------------------------------
-- check ingredients preparing
----------------------------------------------------

RSGCore.Functions.CreateCallback('rsg-fishprep:server:checkingredients', function(source, cb, ingredients)
    local src = source
    local hasItems = false
    local icheck = 0
    local Player = RSGCore.Functions.GetPlayer(src)
    for k, v in pairs(ingredients) do
        if Player.Functions.GetItemByName(v.item) and Player.Functions.GetItemByName(v.item).amount >= v.amount then
            icheck = icheck + 1
            if icheck == #ingredients then
                cb(true)
            end
        else
            TriggerClientEvent('ox_lib:notify', source, {title = 'Error', description = "You dont have the required ingredients", type = 'Error' })
            cb(false)
            return
        end
    end
end)

----------------------------------------------------
-- fail preparing / revice fish filet bad
----------------------------------------------------

RegisterServerEvent('rsg-fishprep:server:failcrafting')
AddEventHandler('rsg-fishprep:server:failcrafting', function(ingredients)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- remove ingredients
    for k, v in pairs(ingredients) do
        if Config.Debug then
            print(v.item)
            print(v.amount)
        end
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
    end

    local randomNumber = math.random(1,100)
    if randomNumber > 0 and randomNumber <= 70 then
        Player.Functions.AddItem('fishmeat', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['fishmeat'], "add")

    elseif randomNumber > 70 and randomNumber <= 100 then -- plants and seed
        local randomamount = math.random(1,2)
        Player.Functions.AddItem('fishmeat', randomamount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['fishmeat'], "add")
    end

    TriggerClientEvent('ox_lib:notify', source, {title = 'Success', description = "You dont prepared correctly", type = 'Success' })
end)

----------------------------------------------------
-- finish preparing
----------------------------------------------------

RegisterServerEvent('rsg-fishprep:server:finishcrafting')
AddEventHandler('rsg-fishprep:server:finishcrafting', function(ingredients, receive)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    -- remove ingredients
    for k, v in pairs(ingredients) do
        if Config.Debug then
            print(v.item)
            print(v.amount)
        end
        Player.Functions.RemoveItem(v.item, v.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[v.item], "remove")
    end

    local randomNumber = math.random(1,100)
    if randomNumber > 0 and randomNumber <= 5 then
        Player.Functions.AddItem(receive, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")

    elseif randomNumber > 5 and randomNumber <= 85 then -- plants and seed
        local randomamount = math.random(1,2)
        Player.Functions.AddItem(receive, randomamount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")

    elseif randomNumber > 90 and randomNumber <= 100 then -- plants and seed
        local amount = math.random(1, 2)
        Player.Functions.AddItem(receive, amount)
        Player.Functions.AddItem('fishmeat', amount)
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[receive], "add")
        TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items['fishmeat'], "add")
    end

    TriggerClientEvent('ox_lib:notify', source, {title = 'Success', description = "You Prepared The Food Correctly", type = 'Success' })

end)

