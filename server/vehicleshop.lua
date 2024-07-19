CreateThread(function()
    RegisterCallback('real-vehicleshop:GetVehicleshopData', function(source, cb, k)
        local src = source
        local ProfilePicture = GetDiscordAvatar(src)
        local PlayerName = GetName(src)
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        local Execute = {
            Name = PlayerName,
            Money = PlayerBank,
            Pfp = ProfilePicture
        }
        cb(Execute)
    end)

    RegisterCallback('real-vehicleshop:CheckPlateStatus', function(source, cb, plate)
        if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
            local result = ExecuteSql("SELECT `plate` FROM `player_vehicles` WHERE `plate` = '"..plate.."'")
            if #result > 0 then
                cb(true)
            else
                cb(false)
            end
        else
            local result = ExecuteSql("SELECT `plate` FROM `owned_vehicles` WHERE `plate` = '"..plate.."'")
            if #result > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    end)
end)