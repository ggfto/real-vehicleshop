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
                DrawText3D(v.Marker, v.ShopOpenCoords)
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

-- Boss menu
Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local Player = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Player)
        for k, v in pairs(Config.Vehicleshops) do
            if v.Manageable then
                local Distance = #(PlayerCoords - v.BossmenuCoords)
                if Distance < 2.0 then
                    sleep = 3
                    if v.Owner ~= "" then
                        if CheckAccess(k) then
                            DrawText3D(Language('bossmenu_marker'), v.BossmenuCoords)
                            if IsControlJustReleased(0, 38) then
                                OpenBossmenu(k)
                            end
                        end
                    else
                        if v.Owner == "" then
                            DrawText3D(Language('buy_company_marker'), v.BossmenuCoords)
                            if IsControlJustReleased(0, 38) then
                                BuyCompany(k)
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

-- Complaint Form
Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local Player = PlayerPedId()
        local PlayerCoords = GetEntityCoords(Player)
        for k, v in pairs(Config.Vehicleshops) do
            if v.Owner ~= "" then
                local Distance = #(PlayerCoords - v.ComplaintForm)
                if Distance < 2.0 then
                    sleep = 3
                    DrawText3D(Language('complaint_form'), v.ComplaintForm)
                    if IsControlJustReleased(0, 38) then
                        OpenComplaintForm(k)
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('real-vehicleshop:SendMailToOnlinePlayer', function(sender, subject, message)
    TriggerServerEvent(Config.PhoneMailOnline, {
        sender = sender,
        subject = subject,
        message = message
    })
end)