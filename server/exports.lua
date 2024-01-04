function GetPhoneNumber(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

function SendTakenMessage(identifier, number, fromnumber, xPlayer)
    TriggerEvent('gcPhone:_internalAddMessage', number, fromnumber, Config.TakeCall, 0, function(smsMess)
        TriggerClientEvent('gcPhone:receiveMessage', xPlayer.source, smsMess)
    end)
end

function SendCallMessage(identifier, number, fromnumber, message)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer == nil then return end
    TriggerEvent('gcPhone:_internalAddMessage', number, fromnumber, message, 0, function(smsMess)
        TriggerClientEvent('gcPhone:receiveMessage', xPlayer.source, smsMess)
    end)
end

function GetPlayer(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer
end

function GetIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return xPlayer.identifier
end

function GetPlayerFromIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    return xPlayer
end

function SendToAddCall(number, call)
    local xPlayers = ESX.GetExtendedPlayers('job', number) -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent("visualz_opkaldsliste:client:addCall", xPlayer.source, call)
    end
end

function UpdateCall(number, name, onCall, onCallPlayers, id)
    local xPlayers = ESX.GetExtendedPlayers('job', number) -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent("visualz_opkaldsliste:client:updateCall", xPlayer.source, name, onCall, onCallPlayers, id)
    end
end

function DeleteCall(number, id)
    local xPlayers = ESX.GetExtendedPlayers('job', number) -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent("visualz_opkaldsliste:client:deleteCall", xPlayer.source, id)
    end
end

function DeleteAll(number, sourcePlayer)
    local name = sourcePlayer.getName()
    local xPlayers = ESX.GetExtendedPlayers('job', number) -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        TriggerClientEvent("visualz_opkaldsliste:client:deleteAll", xPlayer.source, name)
    end
end
