frameworkObject = nil
Blips = {}

Citizen.CreateThread(function()
    frameworkObject, Config.Framework = GetCore()
    while not frameworkObject do
        Citizen.Wait(0)
    end
    Citizen.Wait(1500)
    SendNUIMessage({
        action = 'Setup',
        language = Locales[Config.Language],
        colorstable = Config.Colors,
        allvehiclestable = Config.VehiclesData,
        bossmenucategories = Config.BossmenuCategories,
        checkprofanities = Config.CheckProfanities,
        profanities = Config.Profanities,
        feedbackcharacters = Config.FeedbackCharacterCheck,
        complaintcharacters = Config.ComplaintCharacterCheck,
        testdriveprice = Config.TestDrivePrice,
        platechange = Config.PlateChange,
        platechangeprice = Config.PlateChangePrice,
    })
end)

function CheckPlayerJob(k)
    while not frameworkObject do
        Citizen.Wait(0)
    end
    for k, v in pairs(Config.Vehicleshops[k].Jobs) do
        if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            if frameworkObject.Functions.GetPlayerData().job and frameworkObject.Functions.GetPlayerData().job.name == v or v == 'all' then
                return true
            else
                print("PlayerData problem when checking player job.")
            end
        else
            if frameworkObject.PlayerData.job and frameworkObject.PlayerData.job.name == v or v == 'all' then
                return true
            else
                print("PlayerData problem when checking player job.")
            end
        end
    end
    return false
end