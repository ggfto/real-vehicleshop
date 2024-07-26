Config.DiscordBotToken = 'OTMwODI3Mzg1MzI5MzA3NzMx.GQPatL.q0qjstbgFANq6d21rMjZK7A4v__UmNNxF0dti8' -- Discord bot token
Config.BucketID = 0 -- Default
Config.PhoneMailOffline = 'qb-phone:server:sendNewEventMail'
Config.DefaultPerms = {
    { -- Dont remove this one. You can just edit label and description (Check language folder).
        name = 'owner',
        label = 'Owner',
        permissions = {
            { name = 'administration', label = Language('administration'), description = Language('administration_description'), value = true },
            { name = 'withdrawdeposit', label = Language('withdraw_deposit'), description = Language('withdraw_deposit_description'), value = true },
            { name = 'preorder', label = Language('preorder_perm'), description = Language('preorder_description_perm'), value = true },
            { name = 'discount', label = Language('discount'), description = Language('discount_description_perm'), value = true },
            { name = 'removelog', label = Language('remove_log'), description = Language('remove_log_description'), value = true },
            { name = 'bonus', label = Language('bonus'), description = Language('bonus_description'), value = true },
            { name = 'raise', label = Language('raise'), description = Language('raise_description_perm'), value = true },
            { name = 'fire', label = Language('fire_employees'), description = Language('fire_employees_description'), value = true },
            { name = 'rankchange', label = Language('edit_staff_rank'), description = Language('edit_staff_rank_description'), value = true },
            { name = 'hire', label = Language('hire_staff'), description = Language('hire_staff_description'), value = true },
            { name = 'penalty', label = Language('give_penalty'), description = Language('give_penalty_description'), value = true },
            { name = 'category', label = Language('edit_remove_add_category'), description = Language('edit_remove_add_category_description'), value = true },
            { name = 'buyvehicle', label = Language('buy_vehicle_stock'), description = Language('buy_vehicle_stock_description'), value = true },
            { name = 'editvehicle', label = Language('edit_vehicles'), description = Language('edit_vehicles_description'), value = true },
            { name = 'removefeedback', label = Language('remove_feedbacks'), description = Language('remove_feedbacks_description'), value = true },
            { name = 'removecomplaints', label = Language('remove_complaints'), description = Language('remove_complaints_description'), value = true }
        },
        removable = false,
        editable = false,
    },
}

function SendMailToOfflinePlayer(identifier, sender, subject, message)
    TriggerEvent(Config.PhoneMailOffline, identifier, {
        sender = sender,
        subject = subject,
        Message = message
    })
end