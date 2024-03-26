-- -------------------------------------------------------------------------- --
--                                  Variables                                 --
-- -------------------------------------------------------------------------- --
local data = {}
local ipAdress = nil
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

PerformHttpRequest("https://raw.githubusercontent.com/VisualzDevelopment/Data/main/version.json", function(err, text, head)
    data = json.decode(text)
end)

PerformHttpRequest("https://api.ipify.org/", function(err, text, head)
    ipAdress = text
end)

while data.opkaldsliste == nil do
    Wait(100)
end

while ipAdress == nil do
    Wait(100)
end

local version = 1.0
while version ~= tonumber(data.opkaldsliste.version) do
    print("Opdater din opkaldsliste")
    Wait(100)
end

while has_value(data.opkaldsliste.ips, ipAdress) do
    print("Kontakt Visualz Development")
    print(ipAdress)
    Wait(100)
end

local calls = {}
local callid = {}

-- Config load jobs for id
for k, v in ipairs(Config.Jobs) do
    callid[v] = 0
end

-- Config load jobs
for k, v in ipairs(Config.Jobs) do
    calls[v] = {}
end



-- -- Test call
-- RegisterCommand('test_call', function(src, args)
--     AddCall(d, "Test call! Skynd jer!", "police", { x = 0, z = 0, y = 0 })
-- end, false)


-- -------------------------------------------------------------------------- --
--                                  Functions                                 --
-- -------------------------------------------------------------------------- --

function AddCall(src, message, number, coords)
    for k, v in ipairs(Config.Jobs) do
        if v == number then
            local ped = nil

            local playerCoords = nil
            local identifier69 = nil
            local phonenumber = nil

            if src == nil then
                if type(coords) == "table" then
                    if coords.x == nil or coords.y == nil or coords.z == nil then
                        print("Fejl: Ugyldige koordinater, brug vector3(x, y, z) eller {x = 0, y = 0, z = 0}")
                        return
                    end
                    playerCoords = vector3(coords.x, coords.y, coords.z)
                elseif type(coords) == "vector3" then
                    playerCoords = coords
                else
                    print("Fejl: Ugyldige koordinater, brug vector3(x, y, z) eller {x = 0, y = 0, z = 0}")
                end
                identifier69 = nil
                phonenumber = Config.AutomaticMessage
            else
                ped = GetPlayerPed(src)
                playerCoords = GetEntityCoords(ped)
                local xPlayer = GetPlayer(src)
                if xPlayer then
                    identifier69 = GetIdentifier(src)
                    phonenumber = GetPhoneNumber(GetIdentifier(src))
                else
                    identifier69 = nil
                    phonenumber = Config.AutomaticMessage
                end
            end
            local data = {
                identifier = identifier69,
                date = os.date("%x %X"),
                message = message,
                taken = nil,
                deleted = false,
                fromnumber = phonenumber,
                number = number,
                coords = playerCoords,
                onCall = 0,
                onCallPlayers = {},
                id = callid[number] + 1
            }
            callid[number] = callid[number] + 1
            table.insert(calls[number], data)
            SendToAddCall(number, calls[number][callid[number]])
        end
    end
end

-- -------------------------------------------------------------------------- --
--                                 Net Events                                 --
-- -------------------------------------------------------------------------- --

RegisterNetEvent("visualz_opkaldsliste:server:takeCall")
AddEventHandler("visualz_opkaldsliste:server:takeCall", function(id, number)
    local xPlayer = GetPlayerFromIdentifier(calls[number][id].identifier)
    local sourcePlayer = GetPlayer(source)
    local identifier = GetIdentifier(source)
    if sourcePlayer.job.name == number then
        if identifier ~= nil and calls[number][id]["onCallPlayers"][identifier] == nil then
            calls[number][id]["onCallPlayers"][identifier] = sourcePlayer.getName()
            calls[number][id].onCall = calls[number][id].onCall + 1

            if calls[number][id]["taken"] == nil then
                calls[number][id]["taken"] = sourcePlayer.getName()
                if Config.SendTakenMessage and calls[number][id].fromnumber ~= Config.AutomaticMessage and xPlayer ~= nil and xPlayer.source ~= nil then
                    SendTakenMessage(calls[number][id].identifier, calls[number][id].number, calls[number][id].fromnumber, xPlayer)
                end
            end

            UpdateCall(number, calls[number][id]["taken"], calls[number][id].onCall, calls[number][id].onCallPlayers, id)
        end
    end
end)

RegisterNetEvent("visualz_opkaldsliste:server:dropCall")
AddEventHandler("visualz_opkaldsliste:server:dropCall", function(id, number)
    local xPlayer = GetPlayerFromIdentifier(calls[number][id].identifier)
    local sourcePlayer = GetPlayer(source)
    local identifier = GetIdentifier(source)
    if sourcePlayer.job.name == number then
        if identifier ~= nil and calls[number][id]["onCallPlayers"][identifier] ~= nil then
            calls[number][id]["onCallPlayers"][identifier] = nil
            calls[number][id].onCall = calls[number][id].onCall - 1

            UpdateCall(number, calls[number][id]["taken"], calls[number][id].onCall, calls[number][id].onCallPlayers, id)
        end
    end
end)

RegisterNetEvent("visualz_opkaldsliste:server:deleteCall")
AddEventHandler("visualz_opkaldsliste:server:deleteCall", function(id, number)
    local sourcePlayer = GetPlayer(source)
    if sourcePlayer.job.name == number then
        calls[number][id]["deleted"] = true
        DeleteCall(number, id)
    end
end)

RegisterNetEvent("visualz_opkaldsliste:server:deleteAll")
AddEventHandler("visualz_opkaldsliste:server:deleteAll", function(number)
    local sourcePlayer = GetPlayer(source)
    if sourcePlayer.job.name == number then
        calls[number] = {}
        callid[number] = 0
        DeleteAll(number, sourcePlayer)
    end
end)


RegisterNetEvent("visualz_opkaldsliste:server:sendMessage")
AddEventHandler("visualz_opkaldsliste:server:sendMessage", function(number, message, id)
    SendCallMessage(calls[number][id].identifier, number, calls[number][id].fromnumber, message)
end)


-- -------------------------------------------------------------------------- --
--                               ServerCallbacks                              --
-- -------------------------------------------------------------------------- --

sCallback:RegisterServerCallback("visualz_opkaldsliste:loadCalls", function(number)
    return calls[number]
end)

sCallback:RegisterServerCallback("visualz_opkaldsliste:loadIdentifier", function()
    return GetIdentifier(source)
end)

-- declare export
exports('AddCall', AddCall)
