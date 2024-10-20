CachedJob = nil


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    PlayerData = xPlayer
    PlayerLoaded = true
    local Job = GetJob()
    for k, v in ipairs(Config.Jobs) do
        if v == Job then
            LoadCalls(Job)
            CachedJob = v
            break
        end
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    PlayerLoaded = false
    PlayerData = {}
    CachedJob = nil
end)

RegisterNetEvent("QBCore:Client:OnJobUpdate")
AddEventHandler("QBCore:Client:OnJobUpdate", function(job)
    local found = false
    for _, v in ipairs(Config.Jobs) do
        if v == job.name then
            LoadCalls(job.name)
            CachedJob = v
            found = true
            break
        end
    end
    if not found then
        CachedJob = nil
    end
end)

function GetJob()
    local player = QBCore.functions.GetPlayer()
    return Player.PlayerData.job.name
end
