local RSGCore = exports['rsg-core']:GetCoreObject()

local mediumfishback
local bigfishback
local isLoggedIn = false

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

-- PlayerGang = {}
-- PlayerJob = {}
------------------------------------------------------------------------------------------------------
-- crafting location
------------------------------------------------------------------------------------------------------

-- AddEventHandler('onResourceStart', function(resource)
--     if resource == GetCurrentResourceName() then
--         PlayerJob = RSGCore.Functions.GetPlayerData().job
--         PlayerGang = RSGCore.Functions.GetPlayerData().gang
--     end
-- end)

-- RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
--     PlayerJob = RSGCore.Functions.GetPlayerData().job
--     PlayerGang = RSGCore.Functions.GetPlayerData().gang
-- end)

-- RegisterNetEvent('RSGCore:Client:OnJobUpdate', function(JobInfo, InfoGang)
--     PlayerGang = InfoGang
--     PlayerJob = JobInfo
-- end)

------------------------------------------------------------------------------------------------------
-- crafting location
------------------------------------------------------------------------------------------------------

CreateThread(function()
    for _, v in pairs(Config.FishPrepLocations) do
        if not v.showtarget  then
            exports['rsg-core']:createPrompt(v.name, v.coords, RSGCore.Shared.Keybinds[Config.MenuKeybind], v.name, {
                type = 'client',
                event = 'rsg-fishprep:client:openmenu',
                args = { v.name },
            })
            
        else
            exports['rsg-target']:AddCircleZone(v.name, v.coords, 1, {
                name = v.name,
                debugPoly = false,
            }, {
                options = {
                {
                    type = "client",
                    event = 'rsg-fishprep:client:openmenu',
                    icon = "fas fa-gear",
                    label = "Fish Prep Area",
                },
                },
                distance = 2.0,
            })

            exports['rsg-target']:AddTargetModel(Config.Utility.StashModel.Medium, {
            options = {
                {   type = "client",
                    event = 'rsg-fishprep:client:openmenupropB',
                    --args = { v.name },
                    icon = "fas fa-gear",
                    label = "Fish Prep Area",
                },},
            distance = 2.0,

            })
            exports['rsg-target']:AddTargetModel(Config.Utility.StashModel.Big, {
            options = {
                {   type = "client",
                    event = 'rsg-fishprep:client:openmenupropC',
                    --args = { v.name },
                    icon = "fas fa-gear",
                    label = "Fish Prep Area",
                },},
            distance = 2.0,
            })
        end
        if v.showblip  then
            local CraftingBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(CraftingBlip, GetHashKey(Config.Blip.blipSprite), true)
            SetBlipScale(CraftingBlip, Config.Blip.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, CraftingBlip, Config.Blip.blipName)
        end
    end
end)

------------------------------------------------------------------------------------------------------
-- menu
------------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-fishprep:client:openmenu', function()
    lib.registerContext({
        id = 'fish_basin_menu',
        title = 'Fish Menu',
        options = {
            {
                title = 'Filet your fish',
                description = 'spawn your Fish',
                icon = 'fa-solid fa-eye',
                event = 'rsg-fishprep:client:fishprepMenu',
                arrow = true
            },
        }
    })
    lib.showContext('fish_basin_menu')
end)

RegisterNetEvent('rsg-fishprep:client:openmenupropB', function()
    if Config.Utility.UsefishbasinItem then
        lib.registerContext({
            id = 'fish_basinprop_menuB',
            title = 'Fish Menu',
            options = {
                {
                    title = 'Filet your fish',
                    description = 'spawn your Fish',
                    icon = 'fa-solid fa-eye',
                    event = 'rsg-fishprep:client:fishprepMenu',
                    arrow = true
                },

                {
                    title = 'Inventory',
                    description = 'open your Fish Basin',
                    icon = 'fa-solid fa-dollar-sign',
                    event = 'rsg-fishprep:Client:backpackB',
                    args = {},
                    arrow = true
                },
            }
        })
        lib.showContext('fish_basinprop_menuB')
    end
end)

RegisterNetEvent('rsg-fishprep:client:openmenupropC', function()
    if Config.Utility.UsefishbasinItem then
        lib.registerContext({
            id = 'fish_basinprop_menuC',
            title = 'Fish Menu',
            options = {
                {
                    title = 'Filet your fish',
                    description = 'spawn your Fish',
                    icon = 'fa-solid fa-eye',
                    event = 'rsg-fishprep:client:fishprepMenu',
                    arrow = true
                },

                {
                    title = 'Inventory',
                    description = 'open your Fish Basin',
                    icon = 'fa-solid fa-dollar-sign',
                    event = 'rsg-fishprep:Client:backpackC',
                    
                    args = {},
                    arrow = true
                },
            }
        })
        lib.showContext('fish_basinprop_menuC')
    end
end)

---------------------------------------------------------------------
--  storage
---------------------------------------------------------------------

local citizenid = nil

RegisterNetEvent('rsg-fishprep:Client:backpackB', function()
	local job = RSGCore.Functions.GetPlayerData().job.name
	local gang = RSGCore.Functions.GetPlayerData().gang.name
    if Config.JobsorGang.NeedJob == true then
        if job ~= Config.JobsorGang.JobName then
            lib.notify({ title = 'NoJob', description = 'You dont have the necessary work', type = 'Error' })
            return false
        end
    end
    if Config.JobsorGang.NeedGang == true then
        if gang ~= Config.JobsorGang.GangName then
            lib.notify({ title = 'No Gang', description = 'You dont have the necessary gang', type = 'Error' })

            return false
        end
    end
    local citizenid = RSGCore.Functions.GetPlayerData().citizenid
    local mediumfishbackpackid = RSGCore.Functions.HasItem(Config.Utility.StashNames.Medium, 1)
    
    if Config.Utility.StashID then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Utility.StashNames.Medium..'_'..mediumfishbackpackid, {maxweight = Config.Utility.Weight.Medium, slots = Config.Utility.Slots.Medium})
        TriggerEvent("inventory:client:SetCurrentStash", Config.Utility.StashNames.Medium..'_'..mediumfishbackpackid)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Utility.StashNames.Medium..'_'..citizenid, {maxweight = Config.Utility.Weight.Medium, slots = Config.Utility.Slots.Medium})
        TriggerEvent("inventory:client:SetCurrentStash", Config.Utility.StashNames.Medium..'_'..citizenid)
    end

end)

RegisterNetEvent('rsg-fishprep:Client:backpackC', function()
	local job = RSGCore.Functions.GetPlayerData().job.name
	local gang = RSGCore.Functions.GetPlayerData().gang.name
    if Config.JobsorGang.NeedJob == true then
        if job ~= Config.JobsorGang.JobName then
            lib.notify({ title = 'NoJob', description = 'You dont have the necessary work', type = 'Error' })
            return false
        end
    end
    if Config.JobsorGang.NeedGang == true then
        if gang ~= Config.JobsorGang.GangName then
            lib.notify({ title = 'No Gang', description = 'You dont have the necessary gang', type = 'Error' })

            return false
        end
    end

    local citizenid = RSGCore.Functions.GetPlayerData().citizenid
    local bigfishbackpackid  = RSGCore.Functions.HasItem(Config.Utility.StashNames.Big, 1)
    if Config.Utility.StashID then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Utility.StashNames.Big..'_'..bigfishbackpackid, {maxweight = Config.Utility.Weight.Big, slots = Config.Utility.Slots.Big})
        TriggerEvent("inventory:client:SetCurrentStash", Config.Utility.StashNames.Big..'_'..bigfishbackpackid)
    else
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Config.Utility.StashNames.Big..'_'..citizenid, {maxweight = Config.Utility.Weight.Big, slots = Config.Utility.Slots.Big})
        TriggerEvent("inventory:client:SetCurrentStash", Config.Utility.StashNames.Big..'_'..citizenid)
    end
end)

------------------------------------------------------------------------------------------------------
-- crafting menu
------------------------------------------------------------------------------------------------------

-- create a table to store menu options by category
local CategoryMenus = {}

-- iterate through recipes and organize them by category
for _, v in pairs(Config.FishCrafting) do
    local IngredientsMetadata = {}

    local setheader = RSGCore.Shared.Items[tostring(v.receive)].label
    local itemimg = "nui://"..Config.Img..RSGCore.Shared.Items[tostring(v.receive)].image
    --print(setheader, v.receive)

    for i, ingredient in pairs(v.ingredients) do
        local setheader2 = RSGCore.Shared.Items[tostring(ingredient.item)].label
        table.insert(IngredientsMetadata, { label = setheader2, value = ingredient.amount })
    end

    local option = {
        title = setheader,
        icon = itemimg,
        event = 'rsg-fishprep:client:checkingredients',
        metadata = IngredientsMetadata,
        args = {
            title = setheader,
            category = v.category,
            ingredients = v.ingredients,
            time = v.time,
            receive = v.receive,
            giveamount = v.giveamount
        }
    }

   if not CategoryMenus[v.category] then
        CategoryMenus[v.category] = {
            id = 'fishking_menu_' .. v.category,
            title = v.category,
            menu = 'fish_main_menu',
            onBack = function() end,
            options = { option }
        }
    else
        table.insert(CategoryMenus[v.category].options, option)
    end
end

for category, MenuData in pairs(CategoryMenus) do
    RegisterNetEvent('rsg-fishprep:client:' .. category)
    AddEventHandler('rsg-fishprep:client:' .. category, function()
        lib.registerContext(MenuData)
        lib.showContext(MenuData.id)
    end)
end

RegisterNetEvent('rsg-fishprep:client:fishprepMenu', function()
    local fishMenu = {
        id = 'fish_main_menu',
        title = 'Fish Menu',
        menu = 'fish_basin_menu',
        onBack = function() end,
        options = {}
    }

    for category, MenuData in pairs(CategoryMenus) do
        table.insert(fishMenu.options, {
            title = category,
            description = 'Recipes ' .. category,
            icon = 'fa-solid fa-fish',
            event = 'rsg-fishprep:client:' .. category,
            arrow = true
        })
    end

    lib.registerContext(fishMenu)
    lib.showContext(fishMenu.id)

end)


------------------------------------------------------------------------------------------------------
-- do checkingredients stuff
------------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-fishprep:client:checkingredients', function(data)
    RSGCore.Functions.TriggerCallback('rsg-fishprep:server:checkingredients', function(hasRequired)
    if (hasRequired) then
        if Config.Debug  then
            print("passed")
        end
        TriggerEvent('rsg-fishprep:crafting', data.title, data.category, data.ingredients, tonumber(data.time), data.receive, data.giveamount)
    else
        if Config.Debug then
            print("failed")
        end
        return
    end
    end, data.ingredients)
end)

------------------------------------------------------------------------------------------------------
-- animations
------------------------------------------------------------------------------------------------------

local Animation = 'amb_rest_lean@world_human_lean@table@sharpen_knife@male_a@idle_a'
local anim = 'idle_c'

local LoadAnimDict = function(dict)
    local isLoaded = HasAnimDictLoaded(dict)

    while not isLoaded do
        RequestAnimDict(dict)
        Wait(0)
        isLoaded = not isLoaded
    end
end

AddEventHandler('rsg-fishprep:client:Animation', function()
    local player = PlayerPedId()
    LoadAnimDict(Animation)
    while not HasAnimDictLoaded(Animation) do
        Wait(100)
    end
    TaskPlayAnim(player, Animation, anim, 3.0, 3.0, -1, 1, 0, false, false, false)
end)

------------------------------------------------------------------------------------------------------
-- do crafting stuff with success and animations fishing prep
------------------------------------------------------------------------------------------------------

RegisterNetEvent('rsg-fishprep:crafting', function(title, category, ingredients, time, receive, giveamount)

    -- check item
    local hasItem = RSGCore.Functions.HasItem(Config.itemfishing, 1)

    if not hasItem then
        lib.notify({ title = 'Error', description = 'You don\'t have a knife!', type = 'error' })
        return
    end

    local numberGenerator = math.random(1, 100)
    if numberGenerator <= 5 then
        TriggerServerEvent('rsg-fishprep:server:breakknife')
        lib.notify({ title = "¡Break knife!", description = "It was already old, you need a new one", type = 'error' })
        return
    end

    LocalPlayer.state:set("inv_busy", true, true)
    -- FIRST PART
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger00")
    local knife = CreateObject(GetHashKey("w_melee_knife06"), coords.x, coords.y, coords.z, true, true, true)

    local boneIndex2 = GetEntityBoneIndexByName(ped, "SKEL_L_Finger00")
    local fish = CreateObject(GetHashKey("s_inv_fishrainbowtrout01x_ms"), coords.x, coords.y, coords.z, true, true, true)

    SetCurrentPedWeapon(ped, "WEAPON_UNARMED", true)
    FreezeEntityPosition(ped, true)
    ClearPedTasksImmediately(ped)

    AttachEntityToEntity(knife, ped, boneIndex, 0.07, -0.00, 0.02, 75.0, 270.0, 120.0, true, false, true, false, 0, true)
    AttachEntityToEntity(fish, ped, boneIndex2, 0.27, -0.00, -0.04, -80.0, 90.0, 30.0, true, false, true, false, 0, true)


    TriggerEvent('rsg-fishprep:client:Animation')

    RSGCore.Functions.Progressbar('crafting', 'Preparing '..title..' '..category, time*0.7, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done

        SetEntityAsNoLongerNeeded(fish)
        DeleteEntity(fish)
    end)

    -- check success
    if Config.DoMiniGame then
        local success = lib.skillCheck({{areaSize = 50, speedMultiplier = 0.5}}, {'w', 'a', 's', 'd'})
        if not success then
            
            SetEntityAsNoLongerNeeded(knife)
            DeleteEntity(knife)

            FreezeEntityPosition(ped, false)
            ClearPedTasks(ped)

            TriggerServerEvent('rsg-fishprep:server:failcrafting', ingredients)
            
            SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)

            LocalPlayer.state:set("inv_busy", true, false)

            lib.notify({ title = 'Try again!', description = 'Have you never used a knife?', type = 'error' })
            return
        end
    end

    -- SECOND PART
    local fishfilet = CreateObject(GetHashKey("p_redfishfilet01xa"), coords.x, coords.y, coords.z, true, true, true)

    AttachEntityToEntity(knife, ped, boneIndex, 0.07, -0.00, 0.025, 90.0, 165.0, 105.0, true, false, true, false, 0, true)
    AttachEntityToEntity(fishfilet, ped, boneIndex2, 0.10, 0.01, -0.03, -30.0, 80.0, 90.0, true, false, true, false, 0, true)

    TriggerEvent('rsg-fishprep:client:Animation')

    Wait(100)
    RSGCore.Functions.Progressbar('crafting', 'Preparing Food '..title..' '..category, time*0.3, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done

        SetEntityAsNoLongerNeeded(knife)
        DeleteEntity(knife)

        SetEntityAsNoLongerNeeded(fishfilet)
        DeleteEntity(fishfilet)

        -- FINISH PART
        TriggerServerEvent('rsg-fishprep:server:finishcrafting', ingredients, receive, giveamount)

        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)

    end)
    LocalPlayer.state:set("inv_busy", true, false)
end)

---------------------------
-- fish basin prop small
---------------------------

local fishbasincraft2 = false
local fishbasin2

local fishbasincraft3 = false
local fishbasin3

local inspect = GetHashKey('WORLD_HUMAN_CROUCH_INSPECT')
local notebook = GetHashKey("WORLD_HUMAN_WRITE_NOTEBOOK")

RegisterNetEvent('rsg-fishprep:client:setupfishbasinB')
AddEventHandler('rsg-fishprep:client:setupfishbasinB', function()
    local ped = PlayerPedId()
    if Config.Utility.UsefishbasinItem then

        ClearPedTasks(ped)

        if fishbasincraft2 then

            TaskStartScenarioInPlace(ped, inspect, 2000, true)
            Wait(2000)
            ClearPedTasks(ped)

            SetEntityAsMissionEntity(fishbasin2)
            DeleteObject(fishbasin2)
            lib.notify({ title = 'Save item', description = 'your item is picked up', type = 'inform' })
            fishbasincraft2 = false

        else

            ClearPedTasks(ped)
            TaskStartScenarioInPlace(ped, inspect, 2000, true)
            Wait(2000)

            local coords = GetEntityCoords(ped)
            local forward = GetEntityForwardVector(ped)
            local x, y, z = table.unpack(coords + forward * 0.5)

            local prop = CreateObject(GetHashKey(Config.Utility.StashModel.Medium), x, y, z, true, false, true)
            SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop)
            Wait(500)
            FreezeEntityPosition(prop, true)
            SetModelAsNoLongerNeeded(prop)
            fishbasin2 = prop

            lib.notify({ title = 'Deployed item', description = 'your gold basin is deployed', type = 'inform' })
            fishbasincraft2 = true

        end

        ClearPedTasks(ped)

    end
end, false)

RegisterNetEvent('rsg-fishprep:client:setupfishbasinC')
AddEventHandler('rsg-fishprep:client:setupfishbasinC', function()
    local ped = PlayerPedId()    
    if Config.Utility.UsefishbasinItem then

        ClearPedTasks(ped)

        if fishbasincraft3 then

            TaskStartScenarioInPlace(ped, inspect, 2000, true)
            Wait(2000)
            ClearPedTasks(ped)

            TaskStartScenarioInPlace(ped, notebook, 2000, true)
            Wait(2000)

            SetEntityAsMissionEntity(fishbasin3)
            DeleteObject(fishbasin3)
            lib.notify({ title = 'Save item', description = 'your item is picked up', type = 'inform' })
            fishbasincraft3 = false

        else

            TaskStartScenarioInPlace(ped, notebook, 2000, true)
            Wait(2000)

            ClearPedTasks(ped)
            TaskStartScenarioInPlace(ped, inspect, 2000, true)
            Wait(5000)

            local coords = GetEntityCoords(ped)
            local forward = GetEntityForwardVector(ped)
            local x, y, z = table.unpack(coords + forward * 0.5)

            local prop3 = CreateObject(GetHashKey(Config.Utility.StashModel.Big), x, y, z, true, false, true)
            SetEntityHeading(prop3, GetEntityHeading(PlayerPedId()))
            PlaceObjectOnGroundProperly(prop3)
            Wait(500)
            FreezeEntityPosition(prop3, true)
            SetModelAsNoLongerNeeded(prop3)
            fishbasin3 = prop3

            lib.notify({ title = 'Deployed item', description = 'your gold basin is deployed', type = 'inform' })
            fishbasincraft3 = true

        end

        ClearPedTasks(ped)

    end
end, false)
