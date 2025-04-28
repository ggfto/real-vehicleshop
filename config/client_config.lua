local Zones = lib.require("client/interaction/zones")

local function openShop(key)
    if CheckPlayerJob(key) then
        if IsControlJustReleased(0, 38) then
            OpenVehicleshop(key)
        end
    else
        Config.Notification(Language("not_allowed_to_open_vs"), "error", false)
    end
end

local function openBossmenu(key)
    if IsControlJustReleased(0, 38) then
        if Config.Vehicleshops[key].Owner == "" then
            BuyCompany(key)
        else
            if CheckAccess(key) then
                OpenBossmenu(key)
            end
        end
    end
end

local function openComplaintForm(key)
    if IsControlJustReleased(0, 38) then
        OpenComplaintForm(key)
    end
end

RegisterNetEvent(
    "onResourceStart",
    function(resName)
        if resName == GetCurrentResourceName() then
            for k, v in pairs(Config.Vehicleshops) do
                local zoneName = string.format("vehicleshop-%s", k)
                Zones.add(
                    {
                        name = zoneName,
                        data = {
                            coords = v.ShopOpenCoords,
                            size = vector3(1.0, 1.0, 1.0),
                            debug = Config.Debug,
                            onEnter = function()
                                lib.showTextUI((v.Marker:gsub("~INPUT_PICKUP~", "[E]")))
                            end,
                            inside = function()
                                openShop(k)
                            end,
                            onExit = function()
                                lib.hideTextUI()
                            end
                        }
                    }
                )
                if v.Manageable then
                    local zoneName = string.format("bossmenu-%s", k)
                    Zones.add(
                        {
                            name = zoneName,
                            data = {
                                coords = v.BossmenuCoords,
                                size = vector3(1.0, 1.0, 1.0),
                                debug = Config.Debug,
                                onEnter = function()
                                    local message =
                                        ((v.Owner == "" and Language("buy_company_marker") or
                                        Language("bossmenu_marker")):gsub("~INPUT_PICKUP~", "[E]"))
                                    lib.showTextUI(message)
                                end,
                                inside = function()
                                    openBossmenu(k)
                                end,
                                onExit = function()
                                    lib.hideTextUI()
                                end
                            }
                        }
                    )
                end
                zoneName = string.format("complaintform-%s", k)
                Zones.add(
                    {
                        name = zoneName,
                        data = {
                            coords = v.ComplaintForm,
                            size = vector3(1.0, 1.0, 1.0),
                            debug = Config.Debug,
                            onEnter = function()
                                if Config.Vehicleshops[k].Owner == "" then
                                   return
                                end
                                lib.showTextUI((Language("complaint_form_marker"):gsub("~INPUT_PICKUP~", "[E]")))
                            end,
                            inside = function()
                                if Config.Vehicleshops[k].Owner == "" then
                                    return
                                 end
                                openComplaintForm(k)
                            end,
                            onExit = function()
                                lib.hideTextUI()
                            end
                        }
                    }
                )
            end
        end
    end
)

RegisterNetEvent(
    "real-vehicleshop:SendMailToOnlinePlayer",
    function(sender, subject, message) -- Here is the place to send mail to active players. You can organize it according to yourself.
        TriggerServerEvent(
            Config.PhoneMailOnline,
            {
                sender = sender,
                subject = subject,
                message = message
            }
        )
    end
)
