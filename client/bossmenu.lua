function GetPlayerIdentifier()
    while not frameworkObject do
        Citizen.Wait(0)
    end
    if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        return frameworkObject.Functions.GetPlayerData().citizenid
    else
        return frameworkObject.GetPlayerData().identifier
    end
end

function CheckAccess(id)
    local Identifier = GetPlayerIdentifier()
    for k, v in ipairs(Config.Vehicleshops[id].Employees) do
        if v.identifier == Identifier then
            return true
        end
    end
    if Config.Vehicleshops[id].Owner == Identifier then
        return true
    end
    return false
end

function BuyCompany(k)
    SendNUIMessage({
        action = 'BuyCompany',
        vehicleshop = k,
        price = Config.Vehicleshops[k].Price,
        name = Config.Vehicleshops[k].CompanyName
    })
    SetNuiFocus(true, true)
end

function OpenBossmenu(k)
    local data = Callback('real-vehicleshop:GetCompanyData', k)

    if data then
        SendNUIMessage({
            action = 'OpenBossmenu',
            vehicleshop = k,
            playername = data.Name,
            playermoney = data.Money,
            playerpfp = data.Pfp,
            playerrank = data.PlayerRank,
            allvehiclestable = Config.VehiclesData[Config.Vehicleshops[k].Type],
            vehicleshopname = Config.Vehicleshops[k].CompanyName,
            vehicleshopdescription = Config.Vehicleshops[k].CompanyDescriptionText,
            companymoney = Config.Vehicleshops[k].CompanyMoney,
            employees = Config.Vehicleshops[k].Employees,
            vehicles = Config.Vehicleshops[k].Vehicles,
            vehiclessold = Config.Vehicleshops[k].SoldVehicles,
            feedbacks = Config.Vehicleshops[k].Feedbacks,
            preorders = Config.Vehicleshops[k].Preorders,
        })
        SetNuiFocus(true, true)
        CurrentVehicleshop = k
    end
end

function AcceptedBuyCompany(data)
    local result = Callback('real-vehicleshop:BuyCompany', data)
    if result then
        SendNUIMessage({ action = 'CloseTransferReq' })
        Config.Notification(Language('successfully_bought_company'), 'success', false)
    else
        Config.Notification(Language('not_enough_money'), 'error', false)
    end
end

RegisterNUICallback('BuyCompany', AcceptedBuyCompany)