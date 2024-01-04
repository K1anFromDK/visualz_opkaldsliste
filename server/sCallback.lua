sCallback = {
    RegisterServerCallback = function(self, name, func)
        self[name] = func
    end
}
RegisterServerEvent("visualz_callBack:TriggerServerCallback")
AddEventHandler("visualz_callBack:TriggerServerCallback", function(name, ...)
    local source = source
    TriggerClientEvent("visualz_callBack:RecieveServerCallback", source, name, sCallback[name](...))
end)
