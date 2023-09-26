RegisterNetEvent("cmdJobbell:notify")
AddEventHandler("cmdJobbell:notify", function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local isJob = false

    for k, playerId in pairs(GetPlayers()) do
        local tPlayer = ESX.GetPlayerFromId(playerId)

        if tPlayer.job.name == job then
            tPlayer.showNotification('Ein Kunde sucht einen Mitarbeiter an der Rezeption')
            xPlayer.showNotification('Du hast die klingel aktiviert')
            isJob = true
        end
    end
    if not isJob then xPlayer.showNotification('Es sind keine Mitarbeiter verfügbar') end
end)