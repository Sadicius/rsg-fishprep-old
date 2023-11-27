# FISH PREPARED System

------------------------------------------------------------------------------------------------------
-- success and item
        - MenuKeybind = 'E'
        - DoMiniGame = true / false 
        - itemfishing = 'weapon_melee_knife' 
-- Jobs or Gang for utility 
        -- need = true / false 
        -- name group 
-- Utily bags
        - stashID -- true / false (DONT WORK IN true)
        - UsefishbasinItem -- ON / OFF
        - Config Bags (name item, model, weight, slots)
-- blip settings
-- FishPrepLocations 
        - showblip = true, -- true / false
        - showtarget = true -- true / false ACTIVE PROMP
-- FishCrafting
        - EXAMPLE RECIPE 
        -- { receive = "smallfish", time = 10000, category = 'small',  ingredients = { [1] = { item = "a_c_fishbluegil_01_sm",   amount = 1 } }, giveamount = 1  },

------------------------------------------------------------------------------------------------------

# Video
https://www.youtube.com/watch?v=LOEsIY-aqQ0

# Dependancies
- rsg-core
- ox_lib

# Installation
- ensure that the dependancies are added and started
- add rsg-fishprep to your resources folder
- add items to your "\rsg-core\shared\items.lua"
- add images to your "\rsg-inventory\html\images"

# Starting the resource
- add the following to your server.cfg file : ensure rsg-fishprep


# By
https://github.com/Sadicius

# Credits
- original resouce created by : https://github.com/qbcore-redm-framework
- convert and rework by : https://github.com/QRCore-RedM-Re
- RexShack / RexShack#3041 
- Sadicius / Sadicius#1150 / https://linktr.ee/sadicius
