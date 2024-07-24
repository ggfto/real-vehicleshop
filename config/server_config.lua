Config.DiscordBotToken = 'OTMwODI3Mzg1MzI5MzA3NzMx.GQPatL.q0qjstbgFANq6d21rMjZK7A4v__UmNNxF0dti8' -- Discord bot token
Config.BucketID = 0 -- Default
Config.PhoneMailOffline = 'qb-phone:server:sendNewEventMail'

function SendMailToOfflinePlayer(identifier, sender, subject, message)
    TriggerEvent(Config.PhoneMailOffline, identifier, {
        sender = sender,
        subject = subject,
        Message = message
    })
end