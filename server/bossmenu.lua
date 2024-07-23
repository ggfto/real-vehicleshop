SrcTable = {}

CreateThread(function()
    RegisterCallback('real-vehicleshop:BuyCompany', function(source, cb, data)
        local src = source
        local result = ExecuteSql("SELECT * FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
        local identifier = GetIdentifier(src)
        local PlayerName = GetName(src)
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        local ProfilePicture = GetDiscordAvatar(src)
        if #result > 0 then
            local information = json.decode(result[1].information)
            local employees = json.decode(result[1].employees)
            if PlayerBank >= data.price then
                RemoveAddBankMoneyOnline('remove', data.price, src)
                information.Owner = identifier
                Config.Vehicleshops[data.id].Owner = identifier
                table.insert(employees, {
                    identifier = identifier,
                    name = PlayerName,
                    pp = ProfilePicture,
                    rank = 'owner',
                    salary = 0,
                    salarypenalty = 0,
                })
                Config.Vehicleshops[data.id].Employees = employees
                ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."', `employees` = '"..json.encode(employees).."' WHERE `id` = '"..data.id.."'")
                TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
                cb(true)
            else
                cb(false)
            end
        end
    end)

    RegisterCallback('real-vehicleshop:GetCompanyData', function(source, cb, k)
        local src = source
        local result = ExecuteSql("SELECT `employees`, `perms` FROM `real_vehicleshop` WHERE `id` = '"..k.."'")
        local identifier = GetIdentifier(src)
        local ProfilePicture = GetDiscordAvatar(src)
        local PlayerName = GetName(src)
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        local ExecuteData = nil
        local rank = nil
        local ranklabel = nil
        if #result > 0 then
            local employees = json.decode(result[1].employees)
            local perms = json.decode(result[1].perms)
            for k, v in ipairs(employees) do
                if v.identifier == identifier then
                    rank = v.rank
                    break
                end
            end
            for k, v in ipairs(perms) do
                if v.name == rank then
                    ranklabel = v.label
                    break
                end
            end
            if not SrcTable[k] then
                SrcTable[k] = {}
            end
            table.insert(SrcTable[k], src)
            ExecuteData = {
                Name = PlayerName,
                Money = PlayerBank,
                Pfp = ProfilePicture,
                PlayerRank = ranklabel
            }
        end
        cb(ExecuteData)
    end)

    RegisterCallback('real-vehicleshop:GetPlayerInformation', function(source, cb, k)
        local src = source
        local result = ExecuteSql("SELECT `employees`, `perms` FROM `real_vehicleshop` WHERE `id` = '"..k.."'")
        local identifier = GetIdentifier(src)
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        local rank = nil
        local ranklabel = nil
        local ExecuteData = nil
        if #result > 0 then
            local employees = json.decode(result[1].employees)
            local perms = json.decode(result[1].perms)
            for k, v in ipairs(employees) do
                if v.identifier == identifier then
                    rank = v.rank
                    break
                end
            end
            for k, v in ipairs(perms) do
                if v.name == rank then
                    ranklabel = v.label
                    break
                end
            end
            ExecuteData = {
                Money = PlayerBank,
                PlayerRank = ranklabel
            }
        end
        cb(ExecuteData)
    end)
end)

RegisterNetEvent('real-vehicleshop:MoneyAction', function(type, data)
    local src = source
    local result = ExecuteSql("SELECT `information` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
    local PlayerCash = GetPlayerMoneyOnline(src, 'cash')
    local ActionStatus = false
    if #result > 0 then
        local information = json.decode(result[1].information)
        if type == 'deposit' then
            if PlayerBank >= data.value then
                RemoveAddBankMoneyOnline('remove', data.value, src)
                information.Money = information.Money + data.value
                Config.Vehicleshops[data.id].CompanyMoney = Config.Vehicleshops[data.id].CompanyMoney + data.value
                AddTransactions(src, data.id, 'deposit', data.value)
                ActionStatus = true
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('successfully_deposited'), 3000)
            elseif PlayerCash >= data.value then
                RemoveAddCash('remove', data.value, src)
                information.Money = information.Money + data.value
                Config.Vehicleshops[data.id].CompanyMoney = Config.Vehicleshops[data.id].CompanyMoney + data.value
                AddTransactions(src, data.id, 'deposit', data.value)
                ActionStatus = true
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('successfully_deposited'), 3000)
            else
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_money'), 3000)
            end
        elseif type == 'withdraw' then
            if information.Money >= data.value then
                RemoveAddBankMoneyOnline('add', data.value, src)
                information.Money = information.Money - data.value
                Config.Vehicleshops[data.id].CompanyMoney = Config.Vehicleshops[data.id].CompanyMoney - data.value
                AddTransactions(src, data.id, 'withdraw', data.value)
                ActionStatus = true
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('successfully_withdrawn'), 3000)
            else
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_money_in_company'), 3000)
            end
        end
        if ActionStatus then
            ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."' WHERE `id` = '"..data.id.."'")
            TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
            UpdateForAllSrcTable(data.id)
        end
    end
end)

RegisterNetEvent('real-vehicleshop:RemoveFromSrcTable', function(id)
    local src = source
    RemoveFromSrcTable(id, src)
end)

RegisterNetEvent('real-vehicleshop:ChangeCompanyName', function(data)
    local result = ExecuteSql("SELECT `information` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local information = json.decode(result[1].information)
        information.Name = data.value
        Config.Vehicleshops[data.id].CompanyName = data.value
        ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."' WHERE `id` = '"..data.id.."'")
        TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
        UpdateForAllSrcTable(data.id)
    end
end)

RegisterNetEvent('real-vehicleshop:SendTransferRequest', function(data)
    local src = source
    local result = ExecuteSql("SELECT `information` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    local identifier = GetIdentifier(src)
    if #result > 0 then
        local information = json.decode(result[1].information)
        if identifier == information.Owner then
            if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
                local TargetPlayer = frameworkObject.Functions.GetPlayer(data.targetid)
                if TargetPlayer then
                    if src ~= data.targetid then
                        TriggerClientEvent('real-vehicleshop:ShowTransferReqToPlayer', data.targetid, src, data.targetid, data.id, data.price)
                        TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('request_sent'), 3000)
                    else
                        TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('same_player_error'), 3000)
                    end
                else
                    TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('player_not_found'), 3000)
                end
            else
                -- ESX
            end
        end
    end
end)

RegisterNetEvent('real-vehicleshop:MakeDiscount', function(data)
    local result = ExecuteSql("SELECT `information`, `vehicles` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local information = json.decode(result[1].information)
        local vehicles = json.decode(result[1].vehicles)
        for k, v in ipairs(vehicles) do
            v.discount = 0
        end
        information.Discount = data.value
        Config.Vehicleshops[data.id].Discount = data.value
        Config.Vehicleshops[data.id].Vehicles = vehicles
        ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."', `vehicles` = '"..json.encode(vehicles).."' WHERE `id` = '"..data.id.."'")
        TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
        UpdateForAllSrcTable(data.id)
    end
end)

RegisterNetEvent('real-vehicleshop:CancelDiscount', function(id)
    local result = ExecuteSql("SELECT `information` FROM `real_vehicleshop` WHERE `id` = '"..id.."'")
    if #result > 0 then
        local information = json.decode(result[1].information)
        information.Discount = 0
        Config.Vehicleshops[id].Discount = 0
        ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."' WHERE `id` = '"..id.."'")
        TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
        UpdateForAllSrcTable(id)
    end
end)

RegisterNetEvent('real-vehicleshop:DeleteAllLogs', function(id)
    Config.Vehicleshops[id].SoldVehicles = {}
    Config.Vehicleshops[id].Transactions = {}
    ExecuteSql("UPDATE `real_vehicleshop` SET `soldvehicles` = @soldvehicles, `transactions` = @transactions WHERE `id` = @id", {
        ['@id'] = id,
        ['@soldvehicles'] = json.encode(Config.Vehicleshops[id].SoldVehicles),
        ['@transactions'] = json.encode(Config.Vehicleshops[id].Transactions)
    })
    TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
    UpdateForAllSrcTable(id)
end)

RegisterNetEvent('real-vehicleshop:SendBonusToStaff', function(data)
    local src = source
    local result = ExecuteSql("SELECT `information`, `employees` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local information = json.decode(result[1].information)
        local employees = json.decode(result[1].employees)
        local Check = false
        if #employees == 1 and employees[1].rank == 'owner' then
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_employee_for_bonus'), 5000)
            return
        end
        local TotalBonus = 0
        for k, v in ipairs(employees) do
            if v.rank ~= 'owner' then
                TotalBonus = TotalBonus + data.value
            end
        end
        if RemoveMoneyFromCompany(data.id, TotalBonus) then
            if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
                for k, v in ipairs(employees) do
                    if v.rank ~= 'owner' then
                        local Player = frameworkObject.Functions.GetSource(v.identifier)
                        if Player then
                            RemoveAddBankMoneyOnline('add', data.value, Player)
                            Check = true
                            -- Send Mail To Target Player
                        else
                            AddBankMoneyOffline(v.identifier, data.value)
                            Check = true
                            -- Send Mail To Target Player
                        end
                    end
                end
            else
                for k, v in ipairs(employees) do
                    if v.rank ~= 'owner' then
                        local Player = frameworkObject.GetPlayerFromIdentifier(v.identifier)
                        if Player then
                            RemoveAddBankMoneyOnline('add', data.value, Player)
                            Check = true
                            -- Send Mail To Target Player
                        else
                            AddBankMoneyOffline(v.identifier, data.value)
                            Check = true
                            -- Send Mail To Target Player
                        end
                    end
                end
            end
        else
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_money_in_company'), 3000)
        end
        if Check then
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('successfully_sent_bonus'), 3000)
        end
    end
end)

RegisterNetEvent('real-vehicleshop:RaisePrices', function(data)
    local result = ExecuteSql("SELECT `vehicles`, `employees` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local vehicles = json.decode(result[1].vehicles)
        for k, v in ipairs(vehicles) do
            v.price = v.price + (v.price * data.value / 100)
        end
        Config.Vehicleshops[data.id].Vehicles = vehicles
        ExecuteSql("UPDATE `real_vehicleshop` SET `vehicles` = '"..json.encode(vehicles).."' WHERE `id` = '"..data.id.."'")
        TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
        UpdateForAllSrcTable(data.id)
    end
end)

RegisterNetEvent('real-vehicleshop:TransferCompany', function(data)
    local src = data.sender
    local targetsrc = data.target
    local result = ExecuteSql("SELECT `information`, `employees` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    local TargetIdentifier = GetIdentifier(targetsrc)
    local TargetBank = GetPlayerMoneyOnline(targetsrc, 'bank')
    if #result > 0 then
        local information = json.decode(result[1].information)
        local employees = json.decode(result[1].employees)
        if TargetBank >= data.price then
            RemoveAddBankMoneyOnline('remove', data.price, targetsrc)
            RemoveAddBankMoneyOnline('add', data.price, src)
            information.Owner = TargetIdentifier
            Config.Vehicleshops[data.id].Owner = TargetIdentifier
            for k, v in ipairs(employees) do
                if v.rank == 'owner' then
                    v.identifier = TargetIdentifier
                    v.name = GetName(targetsrc)
                    v.pp = GetDiscordAvatar(targetsrc)
                    break
                end
            end
            Config.Vehicleshops[data.id].Employees = employees
            CloseBossmenuForAllTable(data.id)
            Config.Notification(Language('sold_company'), 'success', true, src)
            Config.Notification(Language('successfully_bought_company'), 'success', true, targetsrc)
            ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."', `employees` = '"..json.encode(employees).."' WHERE `id` = '"..data.id.."'")
            TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
            TriggerClientEvent('real-vehicleshop:CloseTransferReqForTarget', targetsrc)
        else
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('targetplayer_does_not_have_money'), 3000)
            Config.Notification(Language('not_enough_money'), 'error', true, targetsrc)
            TriggerClientEvent('real-vehicleshop:CloseTransferReqForTarget', targetsrc)
        end
    end
end)

RegisterNetEvent('real-vehicleshop:SendCancelTransferReqNotifyToSender', function(src)
    TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'information', Language('targetplayer_rejected'), 3000)
end)

RegisterNetEvent('real-vehicleshop:SendJobRequest', function(data)
    local src = source
    local result = ExecuteSql("SELECT `perms` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local perms = json.decode(result[1].perms)
        if #perms == 1 and perms[1].name == "owner" then
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_perms'), 4000)
            return
        end
        if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            local TargetPlayer = frameworkObject.Functions.GetPlayer(data.targetid)
            if TargetPlayer then
                if src ~= data.targetid then
                    TriggerClientEvent('real-vehicleshop:ShowJobReqToPlayer', data.targetid, src, data.targetid, data.id, data.salary)
                    TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('request_sent'), 3000)
                else
                    TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('same_player_error'), 3000)
                end
            else
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('player_not_found'), 3000)
            end
        else
            -- ESX
        end
    end
end)

RegisterNetEvent('real-vehicleshop:AcceptedJobRequest', function(data)
    local src = data.sender
    local targetsrc = data.target
    local result = ExecuteSql("SELECT `employees`, `perms` FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
    if #result > 0 then
        local employees = json.decode(result[1].employees)
        local perms = json.decode(result[1].perms)
        local PermToBeGive = GetPermissionWithMostFalseValues(perms)
        if PermToBeGive then
            local NewTable = {
                identifier = GetIdentifier(targetsrc),
                name = GetName(targetsrc),
                pp = GetDiscordAvatar(targetsrc),
                rank = PermToBeGive,
                salary = data.salary,
                salarypenalty = 0
            }
            table.insert(employees, NewTable)
            Config.Vehicleshops[data.id].Employees = employees
            ExecuteSql("UPDATE `real_vehicleshop` SET `employees` = '"..json.encode(employees).."' WHERE `id` = '"..data.id.."'")
            TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
            Config.Notification(Language('got_job'), 'success', true, targetsrc)
            TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'success', Language('accepted_job_offer'), 3000)
            TriggerClientEvent('real-vehicleshop:CloseJobReqScreen', targetsrc)
            UpdateForAllSrcTable(data.id)
        else
            print("Something wrong with to be give permission.")
        end
    end
end)

RegisterNetEvent('real-vehicleshop:SendRejectedJobReqToSender', function(src)
    TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'information', Language('rejected_job_offer'), 3000)
end)

function RemoveFromSrcTable(id, src)
    if SrcTable[id] then
        for k, v in ipairs(SrcTable[id]) do
            if v == src then
                table.remove(SrcTable[id], k)
                break
            end
        end
    end
end

function UpdateForAllSrcTable(id)
    if SrcTable[id] then
        for k, v in ipairs(SrcTable[id]) do
            TriggerClientEvent('real-vehicleshop:UpdateUI', v)
        end
    end
end

function CloseBossmenuForAllTable(id)
    if SrcTable[id] then
        for k, v in ipairs(SrcTable[id]) do
            TriggerClientEvent('real-vehicleshop:CloseBossmenu', v)
        end
    end
end

function GetPermissionWithMostFalseValues(perms)
    local Name = nil
    for k, v in ipairs(perms) do
        local FalseCount = 0
        for a, b in pairs(v.permissions) do
            if b.value == false then
                FalseCount = FalseCount + 1
            end
        end
        if FalseCount > 0 then
            Name = v.name
        end
    end
    return Name
end

function RemoveMoneyFromCompany(id, amount)
    local result = ExecuteSql("SELECT `information` FROM `real_vehicleshop` WHERE `id` = '"..id.."'")
    if #result > 0 then
        local information = json.decode(result[1].information)
        if information.Money >= amount then
            information.Money = information.Money - amount
            Config.Vehicleshops[id].CompanyMoney = Config.Vehicleshops[id].CompanyMoney - amount
            ExecuteSql("UPDATE `real_vehicleshop` SET `information` = '"..json.encode(information).."' WHERE `id` = '"..id.."'")
            TriggerClientEvent('real-vehicleshop:Update', -1, Config.Vehicleshops)
            UpdateForAllSrcTable(id)
            return true
        end
    end
    return false
end

function AddTransactions(source, id, type, amount)
    local src = source
    local result = ExecuteSql("SELECT `transactions`, `employees`, `perms` FROM `real_vehicleshop` WHERE `id` = '"..id.."'")
    local identifier = GetIdentifier(src)
    local ProfilePicture = GetDiscordAvatar(src)
    local PlayerName = GetName(src)
    local PlayerRank = nil
    local PlayerRankLabel = nil
    local NewTable = {}
    if #result > 0 then
        local transactions = json.decode(result[1].transactions)
        local employees = json.decode(result[1].employees)
        local perms = json.decode(result[1].perms)
        for k, v in ipairs(employees) do
            if v.identifier == identifier then
                PlayerRank = v.rank
                break
            end
        end
        for k, v in ipairs(perms) do
            if v.name == PlayerRank then
                PlayerRankLabel = v.label
                break
            end
        end
        local date = os.date('%d.%m.%Y | %H:%M')
        NewTable = {
            name = PlayerName,
            pfp = ProfilePicture,
            rank = PlayerRankLabel,
            amount = amount,
            date = date,
            type = type  
        }
        table.insert(transactions, NewTable)
        table.insert(Config.Vehicleshops[id].Transactions, NewTable)
        ExecuteSql("UPDATE `real_vehicleshop` SET `transactions` = '"..json.encode(transactions).."' WHERE `id` = '"..id.."'")
    end
end