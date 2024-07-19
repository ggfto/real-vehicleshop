Config = {}

Config.Framework = 'qb' -- qb, oldqb, esx, oldesx or autodetect
Config.MySQL = 'oxmysql' -- oxmysql, ghamattimysql, mysql-async | Don't forget to edit fxmanifest.lua
Config.Language = 'en'

Config.TestDriveTime = 15 -- seconds
Config.TestDrivePrice = 7500
Config.TestDrivePlate = 'TESTDRIVE'
Config.PlateChange = true
Config.PlateChangePrice = 1000

Config.GiveVehicleKey = true
Config.VehicleKeySystem = 'qb-vehiclekeys' -- cd_garage | qs-vehiclekeys | wasabi-carlock | qb-vehiclekeys | custom
Config.GiveVehicleKeys = function(plate, model, vehicle)
    if Config.GiveVehicleKey then
        if Config.VehicleKeySystem == 'cd_garage' then
            TriggerEvent('cd_garage:AddKeys', exports['cd_garage']:GetPlate(vehicle))
        elseif Config.VehicleKeySystem == 'qs-vehiclekeys' then
            exports['qs-vehiclekeys']:GiveKeys(plate, model)
        elseif Config.VehicleKeySystem == 'wasabi-carlock' then
            exports.wasabi_carlock:GiveKey(plate)
        elseif Config.VehicleKeySystem == 'qb-vehiclekeys' then
            TriggerServerEvent('qb-vehiclekeys:server:AcquireVehicleKeys', plate)
        elseif Config.VehicleKeySystem == 'custom' then
            -- Your code here
        end
    end
end

Config.Notification = function(msg, type, server, src)
    if server then
        if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            TriggerClientEvent('QBCore:Notify', src, msg, type, 3000)
        else
            TriggerClientEvent('esx:showNotification', src, msg)
        end
    else
        if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            TriggerEvent('QBCore:Notify', msg, type, 3000)
        else
            TriggerEvent('esx:showNotification', msg)
        end
    end
end

Config.CheckProfanities = true
Config.Profanities = {
    "oç",
    "oc",
    "amk",
    "aq",
}

Config.FeedbackCharacterCheck = {
    MinimumCharacter = 50,
    MaximumCharacter = 150,
}

Config.ComplaintCharacterCheck = {
    MinimumCharacter = 50,
    MaximumCharacter = 150,
}

Config.VehiclesData = {
    { name = 't20', label = 'T20', model = 'Custom', price = 150000, stock = 1, img = 'https://docs.fivem.net/vehicles/t20.webp', information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    { name = 'sultanrs', label = 'Sultan RS', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/sultanrs.webp', information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
}

Config.Categories = {
    { -- DONT REMOVE THIS ONE
        name = 'all',
        label = 'All'
    },
    {
        name = 'sports',
        label = 'Sports'
    },
    {
        name = 'sedans',
        label = 'Sedans'
    },
    {
        name = 'suv',
        label = 'SUVs'
    },
    {
        name = 'trucks',
        label = 'Trucks'
    },
}

Config.BossmenuCategories = { -- Dont touch names. Just edit labels.
    {name = 'dashboard', label = 'Dashboard'}, 
    {name = 'company', label = 'Company'}, 
    {name = 'category', label = 'Categories'}, 
    {name = 'vehicles', label = 'Vehicles'}, 
    {name = 'perms', label = 'Perms'}, 
    {name = 'feedbackcomplains', label = 'Feedback & Complains'}, 
}

Config.BeginningVehicles = {
    { name = 't20', label = 'T20', model = 'Custom', price = 150000, stock = 1, img = 'https://docs.fivem.net/vehicles/t20.webp', information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    { name = 'sultanrs', label = 'Sultan RS', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/sultanrs.webp', information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
}

Config.Colors = {
    ["0"] = {13, 17, 22}, -- Metallic Black
    ["1"] = {17, 17, 19}, -- Graphite
    ["2"] = {29, 30, 33}, -- Black Steel
    ["3"] = {36, 37, 41}, -- Dark Steel
    ["4"] = {156, 156, 152}, -- Silver
    ["5"] = {163, 162, 159}, -- Bluish Silver
    ["6"] = {183, 191, 206}, -- Rolled Steel
    ["7"] = {118, 120, 122}, -- Shadow Silver
    ["8"] = {132, 136, 141}, -- Stone Silver
    ["9"] = {132, 146, 156}, -- Midnight Silver
    ["10"] = {88, 89, 90}, -- Cast Iron Silver
    ["11"] = {26, 26, 29}, -- Anthracite Black
    ["21"] = {30, 35, 47}, -- Worn Black
    ["27"] = {208, 25, 25}, -- Red
    ["28"] = {218, 25, 24}, -- Metallic Torino Red
    ["29"] = {227, 34, 24}, -- Formula Red
    ["30"] = {255, 40, 0}, -- Blaze Red
    ["31"] = {218, 24, 24}, -- Grace Red
    ["32"] = {255, 0, 0}, -- Garnet Red
    ["33"] = {255, 99, 71}, -- Sunset Red
    ["34"] = {139, 0, 0}, -- Cabernet Red
    ["35"] = {255, 8, 127}, -- Candy Red
    ["38"] = {255, 140, 0}, -- Orange
    ["39"] = {255, 0, 0}, -- Matte Red
    ["40"] = {128, 0, 0}, -- Matte Dark Red
    ["41"] = {255, 165, 0}, -- Matte Orange
    ["42"] = {255, 255, 0}, -- Matte Yellow
    ["49"] = {0, 100, 0}, -- Dark Green
    ["50"] = {0, 128, 0}, -- Racing Green
    ["51"] = {32, 178, 170}, -- Sea Green
    ["52"] = {107, 142, 35}, -- Olive Green
    ["53"] = {0, 255, 0}, -- Bright Green
    ["54"] = {175, 238, 238}, -- Gasoline Green
    ["55"] = {0, 255, 0}, -- Matte Lime Green
    ["61"] = {0, 0, 128}, -- Galaxy Blue
    ["62"] = {0, 0, 139}, -- Dark Blue
    ["63"] = {15, 82, 186}, -- Saxon Blue
    ["64"] = {0, 0, 255}, -- Blue
    ["65"] = {100, 149, 237}, -- Mariner Blue
    ["66"] = {72, 61, 139}, -- Harbor Blue
    ["67"] = {173, 216, 230}, -- Diamond Blue
    ["68"] = {0, 191, 255}, -- Surf Blue
    ["69"] = {0, 0, 139}, -- Nautical Blue
    ["70"] = {0, 85, 255}, -- Ultra Blue
    ["71"] = {75, 0, 130}, -- Schafter Purple
    ["72"] = {138, 43, 226}, -- Spinnaker Purple
    ["73"] = {0, 116, 217}, -- Racing Blue
    ["74"] = {173, 216, 230}, -- Light Blue
    ["80"] = {66, 113, 225}, -- Util Maui Blue Poly
    ["82"] = {0, 0, 128}, -- Matte Dark Blue
    ["83"] = {0, 0, 139}, -- Matte Blue
    ["84"] = {25, 25, 112}, -- Matte Midnight Blue
    ["88"] = {255, 255, 0}, -- Yellow
    ["89"] = {255, 255, 85}, -- Race Yellow
    ["90"] = {205, 127, 50}, -- Bronze
    ["91"] = {255, 239, 61}, -- Dew Yellow
    ["92"] = {50, 205, 50}, -- Lime Green
    ["95"] = {101, 67, 33}, -- Creeen Brown
    ["96"] = {210, 105, 30}, -- Chocolate Brown
    ["97"] = {139, 69, 19}, -- Maple Brown
    ["98"] = {139, 69, 19}, -- Saddle Brown
    ["99"] = {212, 175, 55}, -- Gold
    ["100"] = {101, 67, 33}, -- Moss Brown
    ["101"] = {165, 42, 42}, -- Bison Brown
    ["102"] = {204, 136, 0}, -- Woodbeech Brown
    ["103"] = {193, 154, 107}, -- Beechwood Brown
    ["104"] = {160, 82, 45}, -- Sienna Brown
    ["105"] = {244, 164, 96}, -- Sandy Brown
    ["106"] = {245, 222, 179}, -- Bleached Brown
    ["107"] = {255, 253, 208}, -- Cream
    ["111"] = {255, 250, 250}, -- Ice White
    ["112"] = {237, 237, 237}, -- Metallic Frost White
    ["117"] = {122, 122, 122}, -- Metals Brushed Steel
    ["118"] = {96, 96, 96}, -- Metals Brushed Black Steel
    ["119"] = {145, 145, 145}, -- Metals Brushed Aluminum
    ["128"] = {0, 128, 0}, -- Matte Green
    ["131"] = {250, 250, 255}, -- Matte Ice White
    ["135"] = {255, 105, 180}, -- Hot Pink
    ["136"] = {255, 182, 193}, -- Salmon Pink
    ["137"] = {223, 88, 145}, -- Metallic Vermillion Pink
    ["138"] = {255, 69, 0}, -- Bright Orange
    ["141"] = {25, 25, 112}, -- Midnight Blue
    ["142"] = {48, 25, 52}, -- Midnight Purple
    ["143"] = {130, 0, 0}, -- Wine Red
    ["145"] = {147, 112, 219}, -- Bright Purple
    ["147"] = {0, 0, 0}, -- Carbon Black
    ["148"] = {147, 112, 219}, -- Matte Schafter Purple
    ["149"] = {48, 25, 52}, -- Matte Midnight Purple
    ["150"] = {148, 33, 23}, -- Lava Red
    ["151"] = {34, 139, 34}, -- Matte Forest Green
    ["152"] = {107, 107, 71}, -- Matte Olive Darb
    ["153"] = {85, 85, 70}, -- Matte Dark Earth
    ["154"] = {153, 153, 102}, -- Matte Desert Tan
    ["155"] = {107, 142, 35}, -- Matte Foliage Green
    ["158"] = {255, 215, 0}, -- Metals Pure Gold
    ["159"] = {184, 134, 11}, -- Metals Brushed Gold
}