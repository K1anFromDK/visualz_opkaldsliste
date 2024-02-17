function GetPhoneNumber(identifier)
    local result = MySQL.Sync.fetchAll("SELECT phone_phones.phone_number FROM phone_phones WHERE phone_phones.id = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end

function SendTakenMessage(identifier, number, fromnumber, xPlayer)
    exports["lb-phone"]:SendMessage(number, fromnumber, Config.takecall)
end

function SendCallMessage(identifier, number, fromnumber, message, xPlayer)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer == nil then return end
    exports["lb-phone"]:SendMessage(number, fromnumber, message)
end

function GetPlayer(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then return end
    return xPlayer
end

function GetIdentifier(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer == nil then return end
    return xPlayer.identifier
end

function GetPlayerFromIdentifier(identifier)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer == nil then return end
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
