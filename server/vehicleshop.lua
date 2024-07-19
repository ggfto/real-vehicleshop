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

    RegisterCallback('real-vehicleshop:RemoveMoneyForTestDrive', function(source, cb)
        local src = source
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        if PlayerBank >= Config.TestDrivePrice then
            RemoveAddBankMoneyOnline('remove', Config.TestDrivePrice, src)
            cb(true)
        else
            cb(false)
        end
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

RegisterNetEvent('real-vehicleshop:TestDrive', function(started, netid)
    local src = source
    if started then
        local vehicle = NetworkGetEntityFromNetworkId(netid)
        SetPlayerRoutingBucket(src, src)
        SetEntityRoutingBucket(vehicle, src)
        SetRoutingBucketPopulationEnabled(src, false)
    else
        SetPlayerRoutingBucket(src, Config.BucketID)
        SetRoutingBucketPopulationEnabled(src, true)
    end
end)