cCallback = {
    TriggerServerCallback = function(self, name, cb, ...)
        TriggerServerEvent("visualz_callBack:TriggerServerCallback", name, ...)
        self[name] = cb
    end
}

RegisterNetEvent("visualz_callBack:RecieveServerCallback")
AddEventHandler("visualz_callBack:RecieveServerCallback", function(name, ...)
    cCallback[name](...)
end)
