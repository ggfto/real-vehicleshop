function GetPlayerMoneyOnline(source, type)
    if Config.Framework == 'newqb' or Config.Framework == 'oldqb' then
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

function RemoveAddBankMoneyOnline(source, type, amount)
    if Config.Framework == 'newqb' or Config.Framework == 'oldqb' then
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if type == 'add' then
            Player.Functions.AddMoney('bank', tonumber(amount))
        elseif type == 'remove' then
            Player.Functions.RemoveMoney('bank', tonumber(amount))
        end
    else
        local Player = frameworkObject.GetPlayerFromId(tonumber(source))
        if type == 'add' then
            Player.addAccountMoney('bank', tonumber(amount))
        elseif type == 'remove' then
            Player.removeAccountMoney('bank', tonumber(amount))
        end
    end
end

function GetName(source)
    if Config.Framework == "newesx" or Config.Framework == "oldesx" then
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