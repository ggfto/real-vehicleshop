function DrawText3D(msg, coords)
    AddTextEntry('esxFloatingHelpNotification', msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

for k, v in pairs(Config.Vehicleshops) do
    if v.BlipSettings.Enable then
        blip = AddBlipForCoord(v.ShopOpenCoords.x, v.ShopOpenCoords.y, v.ShopOpenCoords.z)
        SetBlipSprite(blip, v.BlipSettings.Sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.BlipSettings.Scale)
        SetBlipColour(blip, v.BlipSettings.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.CompanyName)
        EndTextCommandSetBlipName(blip)
    end
end

function CreateBlips()
    for k, v in pairs(Config.Vehicleshops) do
        if v.BlipSettings.Enable then
            blip = AddBlipForCoord(v.ShopOpenCoords)
            SetBlipSprite(blip, v.BlipSettings.Sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.BlipSettings.Scale)
            SetBlipColour(blip, v.BlipSettings.Color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.CompanyName)
            EndTextCommandSetBlipName(blip)
            table.insert(Blips, blip)
        end
    end
end

-- Vehicleshop
Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local Player = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Player)
        for k, v in pairs(Config.Vehicleshops) do
            local Distance = #(PlayerCoords - v.ShopOpenCoords)
            if Distance < 2.0 then
                sleep = 3
                DrawText3D(Language('open_vehicleshop'), v.ShopOpenCoords)
                if CheckPlayerJob(k) then
                    if IsControlJustReleased(0, 38) then
                        OpenVehicleshop(k)
                    end
                else
                    Config.Notification(Language('not_allowed_to_open_vs'), 'error', false)
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)