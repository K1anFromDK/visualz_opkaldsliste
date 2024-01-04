RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
    for k, v in ipairs(Config.Jobs) do
        if v == ESX.PlayerData.job.name then
            LoadCalls(ESX.PlayerData.job.name)
        end
    end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    for k, v in ipairs(Config.Jobs) do
        if v == job.name then
            LoadCalls(job.name)
        end
    end
end)

function GetJob()
    return ESX.PlayerData.job.name
end
