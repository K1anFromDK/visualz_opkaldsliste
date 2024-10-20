local QBCore = exports['qb-core']:GetCoreObject()

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
    local xPlayer = QBCore.Functions.GetPlayer(identifier)
    if xPlayer == nil then return end
    exports["lb-phone"]:SendMessage(number, fromnumber, message)
end

function GetPlayer(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer == nil then return end
    return xPlayer
end

function GetIdentifier(source)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer == nil then return end
    return GetPlayerIdentifierByType(xPlayer, "steam")
end

function GetPlayerFromIdentifier(identifier)
    local xPlayer = QBCore.Functions.GetPlayer(identifier)
    if xPlayer == nil then return end
    return xPlayer
end

function SendToAddCall(number, call)
    local xPlayers = QBCore.Functions.GetPlayers() -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.PlayerData.job.name == number then
        TriggerClientEvent("visualz_opkaldsliste:client:addCall", xPlayer.source, call)
        end
    end
end

function UpdateCall(number, name, onCall, onCallPlayers, id)
    local xPlayers = QBCore.Functions.GetPlayers() -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.PlayerData.job.name == number then
        TriggerClientEvent("visualz_opkaldsliste:client:updateCall", xPlayer.source, name, onCall, onCallPlayers, id)
        end
    end
end

function DeleteCall(number, id)
    local xPlayers = QBCore.Functions.GetPlayers() -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.PlayerData.job.name == number then
        TriggerClientEvent("visualz_opkaldsliste:client:deleteCall", xPlayer.source, id)
        end
    end
end

function DeleteAll(number, sourcePlayer)
    local name = sourcePlayer.getName()
    local xPlayers = QBCore.Functions.GetPlayers() -- Returns xPlayers with the police job
    for _, xPlayer in pairs(xPlayers) do
        if xPlayer.PlayerData.job.name == number then
        TriggerClientEvent("visualz_opkaldsliste:client:deleteAll", xPlayer.source, name)
        end
    end
end
