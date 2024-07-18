Config = {}

Config.Framework = 'qb' -- qb, oldqb, esx, oldesx or autodetect
Config.MySQL = 'oxmysql' -- oxmysql, ghamattimysql, mysql-async | Don't forget to edit fxmanifest.lua
Config.Language = 'en'

Config.TestDrivePrice = 7500
Config.PlateChange = true
Config.PlateChangePrice = 1000

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

Config.Colors = {
    { color = "#FF5733" },
    { color = "#33FF57" },
    { color = "#3357FF" },
    { color = "#FF33A1" },
    { color = "#A133FF" },
    { color = "#33FFA1" },
    { color = "#FF5733" },
    { color = "#FFBD33" },
    { color = "#33FFBD" },
    { color = "#BD33FF" },
    { color = "#5733FF" },
    { color = "#FFA133" },
    { color = "#A1FF33" },
    { color = "#33A1FF" },
    { color = "#FF33BD" },
    { color = "#33BDFF" },
    { color = "#BDFF33" },
    { color = "#33FF57" },
    { color = "#57FF33" },
    { color = "#FF33FF" },
    { color = "#33FF33" },
    { color = "#FF3333" }
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