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

    RegisterCallback('real-vehicleshop:BuyPlayerVehicle', function(source, cb, data)
        local src = source
        local result = ExecuteSql("SELECT * FROM `real_vehicleshop` WHERE `id` = '"..data.id.."'")
        local PlayerBank = GetPlayerMoneyOnline(src, 'bank')
        local identifier = GetIdentifier(src)
        if PlayerBank >= data.price then
            if Config.Vehicleshops[data.id].Owner == "" then
                RemoveAddBankMoneyOnline('remove', data.price, src)
                if Config.Framework == 'qb' or Config.Framework == 'oldqb' then
                    local Player = frameworkObject.Functions.GetPlayer(src)
                    ExecuteSql("INSERT INTO `player_vehicles` (license, citizenid, vehicle, hash, mods, plate, garage, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @garage, @state)", {
                        ['@license'] = Player.PlayerData.license,
                        ['@citizenid'] = identifier,
                        ['@vehicle'] = data.model,
                        ['@hash'] = GetHashKey(data.props.model),
                        ['@mods'] = json.encode(data.props),
                        ['@plate'] = data.plate,
                        ['@garage'] = Config.DefaultGarage,
                        ['@state'] = 0
                    })
                    cb(true)
                else
                    local Player = frameworkObject.GetPlayerFromId(src)
                    ExecuteSql("INSERT INTO `owned_vehicles` (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)", {
                        ['@owner'] = identifier,
                        ['@plate'] = data.plate,
                        ['@vehicle'] = json.encode(data.props),
                    })
                    cb(true)
                end
            else
                -- If Owner
            end
        else
            cb(false)
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