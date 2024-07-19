function RegisterCallback(name, cbFunc, data)
    while not frameworkObject do
        Citizen.Wait(0)
    end
    if Config.Framework == 'esx' or Config.Framework == 'oldesx' then
        frameworkObject.RegisterServerCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    else
        frameworkObject.Functions.CreateCallback(name, function(source, cb, data)
            cbFunc(source, cb, data)
        end)
    end
end

function ExecuteSql(query, parameters)
    local IsBusy = true
    local result = nil
    if Config.MySQL == "oxmysql" then
        if parameters then
            exports.oxmysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.oxmysql:execute(query, function(data)
                result = data
                IsBusy = false
            end)
        end

    elseif Config.MySQL == "ghmattimysql" then
        if parameters then
            exports.ghmattimysql:execute(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            exports.ghmattimysql:execute(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    elseif Config.MySQL == "mysql-async" then
        if parameters then
            MySQL.Async.fetchAll(query, parameters, function(data)
                result = data
                IsBusy = false
            end)
        else
            MySQL.Async.fetchAll(query, {}, function(data)
                result = data
                IsBusy = false
            end)
        end
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return result
end

function GetPlayerMoneyOnline(source, type)
    if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if type == 'bank' then
            return tonumber(Player.PlayerData.money.bank)
        elseif type == 'cash' then
            return tonumber(Player.PlayerData.money.cash)
        end
    elseif Config.Framework == 'newesx' or Config.Framework == 'oldesx' then
        local Player = frameworkObject.GetPlayerFromId(tonumber(source))
        if type == 'bank' then
            return tonumber(Player.getAccount('bank').money)
        elseif type == 'cash' then
            return tonumber(Player.getMoney())
        end
    end
end

function RemoveAddBankMoneyOnline(type, amount, id)
    if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
        local Player = frameworkObject.Functions.GetPlayer(id)
        if type == 'add' then
            Player.Functions.AddMoney('bank', tonumber(amount))
        elseif type == 'remove' then
            Player.Functions.RemoveMoney('bank', tonumber(amount))
        end
    else
        local Player = frameworkObject.GetPlayerFromId(id)
        if type == 'add' then
            Player.addAccountMoney('bank', tonumber(amount))
        elseif type == 'remove' then
            Player.removeAccountMoney('bank', tonumber(amount))
        end
    end
end

function GetName(source)
    if Config.Framework == "esx" or Config.Framework == "oldesx" then
        local Player = frameworkObject.GetPlayerFromId(tonumber(source))
        if Player then
            return Player.getName()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
        else
            return "0"
        end
    end
end

------------------------------ Start ------------------------------
function StartScript()
    for k, v in pairs(Config.Vehicleshops) do
        local result = ExecuteSql("SELECT * FROM `real_vehicleshop` WHERE id = '"..k.."'")
        local Information = {
            Owner = "",
            Name = v.CompanyName,
            Money = v.CompanyMoney,
            Rating = 0,
            Discount = 0,
            Raise = 0
        }
        if next(result) == nil and #result == 0 then
            ExecuteSql("INSERT INTO `real_vehicleshop` (id, information, vehicles, categories, feedbacks, complains, preorders, employees, soldvehicles, transactions, perms) VALUES (@id, @information, @vehicles, @categories, @feedbacks, @complains, @preorders, @employees, @soldvehicles, @transactions, @perms)", {
                ['@id'] = k,
                ['@information'] = json.encode(Information),
                ['@vehicles'] = json.encode(Config.BeginningVehicles),
                ['@categories'] = json.encode(Config.Categories),
                ['@feedbacks'] = json.encode(v.Feedbacks),
                ['@complains'] = json.encode(v.Complains),
                ['@preorders'] = json.encode(v.Preorders),
                ['@employees'] = json.encode(v.Employees),
                ['@soldvehicles'] = json.encode(v.SoldVehicles),
                ['@transactions'] = json.encode(v.Transactions),
                ['@perms'] = json.encode(v.Perms)
            })
        end
        LoadData()
    end
end

function RequestNewData()
    local source = source
    LoadData()
    TriggerClientEvent('real-vehicleshop:Update', source, Config.Vehicleshops)
end

RegisterNetEvent('real-vehicleshop:RequestData', RequestNewData)

function LoadData()
    local result = ExecuteSql("SELECT * FROM `real_vehicleshop`")
    for k, v in ipairs(result) do
        local information = json.decode(v.information)
        Config.Vehicleshops[k].Owner = information.Owner
        Config.Vehicleshops[k].CompanyName = information.Name
        Config.Vehicleshops[k].CompanyMoney = information.Money
        Config.Vehicleshops[k].Rating = information.Rating
        Config.Vehicleshops[k].Discount = information.Discount
        Config.Vehicleshops[k].Raise = information.Raise
        Config.Vehicleshops[k].Vehicles = json.decode(v.vehicles)
        Config.Vehicleshops[k].Categories = json.decode(v.categories)
        Config.Vehicleshops[k].Feedbacks = json.decode(v.feedbacks)
        Config.Vehicleshops[k].Complains = json.decode(v.complains)
        Config.Vehicleshops[k].Preorders = json.decode(v.preorders)
        Config.Vehicleshops[k].Employees = json.decode(v.employees)
        Config.Vehicleshops[k].SoldVehicles = json.decode(v.soldvehicles)
        Config.Vehicleshops[k].Transactions = json.decode(v.transactions)
        Config.Vehicleshops[k].Perms = json.decode(v.perms)
    end
    print("^2[real-vehicleshop]^0 - Vehicle shops loaded successfully")
end

Citizen.CreateThread(StartScript)