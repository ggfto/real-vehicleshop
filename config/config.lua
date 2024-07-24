Config = {}

Config.Framework = 'qb' -- qb, oldqb, esx, oldesx or autodetect
Config.MySQL = 'oxmysql' -- oxmysql, ghamattimysql, mysql-async | Don't forget to edit fxmanifest.lua
Config.Language = 'en'

Config.TestDriveTime = 15 -- seconds
Config.TestDrivePrice = 7500
Config.TestDrivePlate = 'TESTDRIVE'
Config.PlateChange = true
Config.PlateChangePrice = 1000

Config.DefaultGarage = 'pillboxgarage' -- Garage when buying vehicles

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

Config.DefaultPerms = {
    { -- Dont remove this one. You can just edit label and description.
        name = 'owner',
        label = 'Owner',
        permissions = {
            { name = 'administration', label = 'Administration', description = 'The player can, for example, change the company name and other management actions.', value = true },
            { name = 'withdrawdeposit', label = 'Withdraw & Deposit', description = 'Player can withdraw and deposit money.', value = true },
            { name = 'preorder', label = 'Preorder', description = 'Player can accept/reject preorder request.', value = true },
            { name = 'discount', label = 'Discount', description = 'Player can start discount campaign.', value = true },
            { name = 'removelog', label = 'Remove Log', description = 'Player can remove all log data.', value = true },
            { name = 'bonus', label = 'Bonus', description = 'Player can give bonus to other staff members.', value = true },
            { name = 'raise', label = 'Raise', description = 'Player can bring a raise.', value = true },
            { name = 'fire', label = 'Fire Employees', description = 'Player can fire staff members.', value = true },
            { name = 'rankchange', label = 'Edit Staff Rank', description = 'Player can demote and promote employees.', value = true },
            { name = 'hire', label = 'Hire Staff', description = 'Player can hire staff members.', value = true },
            { name = 'penalty', label = 'Give Penalty', description = 'Player can give penalty to other staff members.', value = true },
            { name = 'category', label = 'Edit/Remove/Add Category', description = 'Player can add, remove and edit categories.', value = true },
            { name = 'buyvehicle', label = 'Buy Vehicle Stock', description = 'Player can buy vehicle stock.', value = true },
            { name = 'editvehicle', label = 'Edit Vehicles', description = 'Player can edit vehicle category, price, give discount etc.', value = true },
            { name = 'removefeedback', label = 'Remove Feedbacks', description = 'Player can remove feedbacks.', value = true },
            { name = 'removecomplaints', label = 'Remove Complaints', description = 'Player can remove complaints.', value = true }
        },
        removable = false,
        editable = false,
    },
    {
        name = 'worker',
        label = 'Worker',
        permissions = {
            { name = 'administration', label = 'Administration', description = 'The player can, for example, change the company name and other management actions.', value = false },
            { name = 'withdrawdeposit', label = 'Withdraw & Deposit', description = 'Player can withdraw and deposit money.', value = false },
            { name = 'preorder', label = 'Preorder', description = 'Player can accept/reject preorder request.', value = true },
            { name = 'discount', label = 'Discount', description = 'Player can start discount campaign.', value = false },
            { name = 'removelog', label = 'Remove Log', description = 'Player can remove all log data.', value = false },
            { name = 'bonus', label = 'Bonus', description = 'Player can give bonus to other staff members.', value = false },
            { name = 'raise', label = 'Raise', description = 'Player can bring a raise.', value = false },
            { name = 'fire', label = 'Fire Employees', description = 'Player can fire staff members.', value = false },
            { name = 'rankchange', label = 'Edit Staff Rank', description = 'Player can demote and promote employees.', value = false },
            { name = 'hire', label = 'Hire Staff', description = 'Player can hire staff members.', value = false },
            { name = 'penalty', label = 'Give Penalty', description = 'Player can give penalty to other staff members.', value = false },
            { name = 'category', label = 'Edit/Remove/Add Category', description = 'Player can add, remove and edit categories.', value = false },
            { name = 'buyvehicle', label = 'Buy Vehicle Stock', description = 'Player can buy vehicle stock.', value = true },
            { name = 'editvehicle', label = 'Edit Vehicles', description = 'Player can edit vehicle category, price, give discount etc.', value = false },
            { name = 'removefeedback', label = 'Remove Feedbacks', description = 'Player can remove feedbacks.', value = false },
            { name = 'removecomplaints', label = 'Remove Complaints', description = 'Player can remove complaints.', value = false }
        },
        removable = true,
        editable = true,
    },
}

Config.VehiclesData = {
    ['car'] = {
        { name = 't20', label = 'T20', model = 'Custom', price = 150000, stock = 1, img = 'https://docs.fivem.net/vehicles/t20.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'sultanrs', label = 'Sultan RS', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/sultanrs.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'nero', label = 'Nero', model = 'Super', price = 100000, stock = 1, img = 'https://docs.fivem.net/vehicles/nero.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },

    ['boat'] = {
        { name = 'seashark2', label = 'Seashark2', model = 'Normal', price = 15000, stock = 1, img = 'https://docs.fivem.net/vehicles/seashark2.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'seashark3', label = 'Seashark3', model = 'Turbo', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/seashark3.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'toro2', label = 'Toro', model = 'Luxry', price = 100000, stock = 1, img = 'https://docs.fivem.net/vehicles/toro2.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },

    ['aircraft'] = {
        { name = 'hydra', label = 'Hydra', model = '', price = 15000, stock = 1, img = 'https://docs.fivem.net/vehicles/hydra.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'volatus', label = 'Volatus', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/volatus.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },
}

Config.Categories = {
    ['car'] = {
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
    },

    ['boat'] = {
        { -- DONT REMOVE THIS ONE
            name = 'all',
            label = 'All'
        },
    },

    ['aircraft'] = {
        { -- DONT REMOVE THIS ONE
            name = 'all',
            label = 'All'
        },
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
    ['car'] = {
        { name = 't20', label = 'T20', model = 'Custom', price = 150000, stock = 1, img = 'https://docs.fivem.net/vehicles/t20.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'sultanrs', label = 'Sultan RS', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/sultanrs.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },

    ['boat'] = {
        { name = 'seashark2', label = 'Seashark2', model = 'Normal', price = 15000, stock = 1, img = 'https://docs.fivem.net/vehicles/seashark2.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'seashark3', label = 'Seashark3', model = 'Turbo', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/seashark3.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },

    ['aircraft'] = {
        { name = 'hydra', label = 'Hydra', model = '', price = 15000, stock = 1, img = 'https://docs.fivem.net/vehicles/hydra.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
        { name = 'volatus', label = 'Volatus', model = '', price = 50000, stock = 1, img = 'https://docs.fivem.net/vehicles/volatus.webp', discount = 0, information = {TopSpeed = 273, Braking = 100, Acceleration = 89, Suspension = 100, Handling = 89} },
    },
}

Config.Colors = {
    ["0"] = {name = "Black", hex = "#0d1116"},
    ["147"] = {name = "Carbon Black", hex = "#11141a"},
    ["1"] = {name = "Graphite", hex = "#1c1d21"},
    ["11"] = {name = "Anthracite Black", hex = "#1d2129"},
    ["2"] = {name = "Black Steel", hex = "#32383d"},
    ["3"] = {name = "Dark Steel", hex = "#454b4f"},
    ["4"] = {name = "Silver", hex = "#999da0"},
    ["5"] = {name = "Bluish Silver", hex = "#c2c4c6"},
    ["6"] = {name = "Rolled Steel", hex = "#979a97"},
    ["7"] = {name = "Shadow Silver", hex = "#637380"},
    ["8"] = {name = "Stone Silver", hex = "#63625c"},
    ["9"] = {name = "Midnight Silver", hex = "#3c3f47"},
    ["10"] = {name = "Cast Iron Silver", hex = "#444e54"},
    ["27"] = {name = "Red", hex = "#c00e1a"},
    ["28"] = {name = "Torino Red", hex = "#da1918"},
    ["29"] = {name = "Formula Red", hex = "#b6111b"},
    ["150"] = {name = "Lava Red", hex = "#bc1917"},
    ["30"] = {name = "Blaze Red", hex = "#a51e23"},
    ["31"] = {name = "Grace Red", hex = "#7b1a22"},
    ["32"] = {name = "Garnet Red", hex = "#8e1b1f"},
    ["33"] = {name = "Sunset Red", hex = "#6f1818"},
    ["34"] = {name = "Cabernet Red", hex = "#49111d"},
    ["143"] = {name = "Wine Red", hex = "#0e0d14"},
    ["35"] = {name = "Candy Red", hex = "#b60f25"},
    ["135"] = {name = "Hot Pink", hex = "#f21f99"},
    ["137"] = {name = "Pfister Pink", hex = "#df5891"},
    ["136"] = {name = "Salmon Pink", hex = "#fdd6cd"},
    ["36"] = {name = "Sunrise Orange", hex = "#d44a17"},
    ["38"] = {name = "Orange", hex = "#f78616"},
    ["138"] = {name = "Bright Orange", hex = "#f6ae20"},
    ["99"] = {name = "Gold", hex = "#ac9975"},
    ["90"] = {name = "Bronze", hex = "#916532"},
    ["88"] = {name = "Yellow", hex = "#ffcf20"},
    ["89"] = {name = "Race Yellow", hex = "#fbe212"},
    ["91"] = {name = "Dew Yellow", hex = "#e0e13d"},
    ["49"] = {name = "Dark Green", hex = "#132428"},
    ["50"] = {name = "Racing Green", hex = "#122e2b"},
    ["51"] = {name = "Sea Green", hex = "#12383c"},
    ["52"] = {name = "Olive Green", hex = "#31423f"},
    ["53"] = {name = "Bright Green", hex = "#155c2d"},
    ["54"] = {name = "Gasoline Green", hex = "#1b6770"},
    ["92"] = {name = "Lime Green", hex = "#98d223"},
    ["141"] = {name = "Midnight Blue", hex = "#0a0c17"},
    ["61"] = {name = "Galaxy Blue", hex = "#222e46"},
    ["62"] = {name = "Dark Blue", hex = "#233155"},
    ["63"] = {name = "Saxon Blue", hex = "#304c7e"},
    ["64"] = {name = "Blue", hex = "#47578f"},
    ["65"] = {name = "Mariner Blue", hex = "#637ba7"},
    ["66"] = {name = "Harbor Blue", hex = "#394762"},
    ["67"] = {name = "Diamond Blue", hex = "#d6e7f1"},
    ["68"] = {name = "Surf Blue", hex = "#76afbe"},
    ["69"] = {name = "Nautical Blue", hex = "#345e72"},
    ["73"] = {name = "Racing Blue", hex = "#2354a1"},
    ["70"] = {name = "Ultra Blue", hex = "#0b9cf1"},
    ["74"] = {name = "Light Blue", hex = "#6ea3c6"},
    ["96"] = {name = "Chocolate Brown", hex = "#221b19"},
    ["101"] = {name = "Bison Brown", hex = "#402e2b"},
    ["95"] = {name = "Creen Brown", hex = "#473f2b"},
    ["94"] = {name = "Feltzer Brown", hex = "#503218"},
    ["97"] = {name = "Maple Brown", hex = "#653f23"},
    ["103"] = {name = "Beechwood Brown", hex = "#46231a"},
    ["104"] = {name = "Sienna Brown", hex = "#752b19"},
    ["98"] = {name = "Saddle Brown", hex = "#775c3e"},
    ["100"] = {name = "Moss Brown", hex = "#6c6b4b"},
    ["102"] = {name = "Woodbeech Brown", hex = "#a4965f"},
    ["105"] = {name = "Sandy Brown", hex = "#bfae7b"},
    ["106"] = {name = "Bleached Brown", hex = "#dfd5b2"},
    ["71"] = {name = "Schafter Purple", hex = "#2f2d52"},
    ["72"] = {name = "Spinnaker Purple", hex = "#282c4d"},
    ["142"] = {name = "Midnight Purple", hex = "#0c0d18"},
    ["145"] = {name = "Bright Purple", hex = "#621276"},
    ["107"] = {name = "Cream", hex = "#f7edd5"},
    ["111"] = {name = "Ice White", hex = "#fffff6"},
    ["112"] = {name = "Frost White", hex = "#eaeaea"}
}