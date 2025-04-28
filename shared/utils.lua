local function debug(msg1, msg2)
    if Config.Debug then
        print(string.format("[%s] %s: %s", GetCurrentResourceName(), msg1, msg2))
    end
end

return {
    debug = debug
}