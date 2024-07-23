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
                information.Money += data.value
                Config.Vehicleshops[data.id].CompanyMoney += data.value
                AddTransactions(src, data.id, 'deposit', data.value)
                ActionStatus = true
            elseif PlayerCash >= data.value then
                RemoveAddCash('remove', data.value, src)
                information.Money += data.value
                Config.Vehicleshops[data.id].CompanyMoney += data.value
                AddTransactions(src, data.id, 'deposit', data.value)
                ActionStatus = true
            else
                TriggerClientEvent('real-vehicleshop:SendUINotify', src, 'error', Language('not_enough_money'), 3000)
            end
        elseif type == 'withdraw' then
            if information.Money >= data.value then
                RemoveAddBankMoneyOnline('add', data.value, src)
                information.Money -= data.value
                Config.Vehicleshops[data.id].CompanyMoney -= data.value
                AddTransactions(src, data.id, 'withdraw', data.value)
                ActionStatus = true
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