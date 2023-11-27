--local RSGCore = exports['rsg-core']:GetCoreObject()
Config = {}

Config.Debug = false
Config.Img = "rsg-inventory/html/images/"

------------------------------------------------------------------------------------------------------
-- success and item
------------------------------------------------------------------------------------------------------
Config.MenuKeybind = 'E'
Config.DoMiniGame = true
Config.itemfishing = 'weapon_melee_knife' -- 'weapon_melee_knife_jawbone'

------------------------------------------------------------------------------------------------------
-- jobs/gangs
------------------------------------------------------------------------------------------------------

Config.JobsorGang = {
    NeedJob = false, -- Need job for opening the bag?
    JobName = "butcher", -- Job
    NeedGang = false, -- Need gang for opening the bag?
    GangName = "ballas", -- Gang 
}

------------------------------------------------------------------------------------------------------
-- bag / store
------------------------------------------------------------------------------------------------------

Config.Utility = {
    StashID = false, -- NOTE 1*
    UsefishbasinItem = true, -- item
    StashNames = {
        Medium = "fishbasin_ms",   -- Name of stash
        Big = "fishbasin_xl",   -- Name of stash
    },
    StashModel = {
        Medium = 'p_barrelsalt01x',   -- Name of stash
        Big = 'p_group_fishstall01',   -- Name of stash
    },
    Weight = {
        Medium = 25000,
        Big = 37500,
    },
    Slots = {
        Medium = 24,   -- Name of stash
        Big = 36,
    },
}

------------------------------------------------------------------------------------------------------
-- locations
------------------------------------------------------------------------------------------------------
-- blip settings
Config.Blip = {
    blipName = 'Fishprep', -- Config.Blip.blipName
    blipSprite = -758970771, -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

Config.FishPrepLocations = {
    {   name = 'Fish Prep Station', 
        coords = vector3(900.85278, -1792.931, 43.080608),
        showblip = true, showtarget = true, showText = false
    }
}

------------------------------------------------------------------------------------------------------
-- craft
------------------------------------------------------------------------------------------------------

Config.FishCrafting = {
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = "a_c_fishbluegil_01_sm",   amount = 1 },
        },
        giveamount = 1
    },
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = 'a_c_fishbullheadcat_01_sm',   amount = 1 },
        },
        giveamount = 1
    },
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = 'a_c_fishchainpickerel_01_sm',   amount = 1 }
        },
        giveamount = 1
    },
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = 'a_c_fishperch_01_sm',   amount = 1 },
        },
        giveamount = 1
    },
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = 'a_c_fishredfinpickerel_01_sm',   amount = 1 },
        },
        giveamount = 1
    },
    {   receive = "smallfish",
        time = 10000,
        category = 'small',
        ingredients = { 
            [1] = { item = 'a_c_fishrockbass_01_sm',   amount = 1 },
        },
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishsmallmouthbass_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishsalmonsockeye_01_ms',   amount = 1 }
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishrockbass_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishrainbowtrout_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishredfinpickerel_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishperch_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishlargemouthbass_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishchainpickerel_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishbullheadcat_01_ms',	   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishbluegil_01_ms',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'medium',
        time = 20000,
        ingredients = {
            [1] = { item = 'a_c_fishsalmonsockeye_01_ml',   amount = 1 },
        },
        receive = "mediumfish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishlakesturgeon_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishlargemouthbass_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishchannelcatfish_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishchannelcatfish_01_xl',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishlongnosegar_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishmuskie_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishnorthernpike_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishrainbowtrout_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishsalmonsockeye_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
    {   category = 'large',
        time = 30000,
        ingredients = {
            [1] = { item = 'a_c_fishsmallmouthbass_01_lg',   amount = 1 }
        },
        receive = "largefish",
        giveamount = 1
    },
}
