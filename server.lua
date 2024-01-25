RegisterNetEvent("cmdJobbell:notify")
AddEventHandler("cmdJobbell:notify", function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local isJob = false

    for k, playerId in pairs(GetPlayers()) do
        local tPlayer = ESX.GetPlayerFromId(playerId)

        if tPlayer.job.name == job then
            for _, position in ipairs(Config.Position) do
                if position.job == job then
                    tPlayer.showNotification(position.helpNotification)
                    xPlayer.showNotification('Du hast die Klingel aktiviert')
                    isJob = true
                    break
                end
            end
        end
    end

    if not isJob then
        xPlayer.showNotification('Es sind keine Mitarbeiter verfügbar')
    end
end)
