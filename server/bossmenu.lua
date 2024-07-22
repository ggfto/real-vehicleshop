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
        local result = ExecuteSql("SELECT * FROM `real_vehicleshop` WHERE `id` = '"..k.."'")
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
            ExecuteData = {
                Name = PlayerName,
                Money = PlayerBank,
                Pfp = ProfilePicture,
                PlayerRank = ranklabel
            }
        end
        cb(ExecuteData)
    end)
end)