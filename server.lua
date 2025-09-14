local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent("cmdJobbell:notify", function(job)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if not xPlayer then return end
    
    local notification = nil
    for _, position in ipairs(Config.Position) do
        if position.job == job then
            notification = position.helpNotification
            break
        end
    end
    
    if not notification then return end
    
    local onlineStaff = {}
    local players = ESX.GetExtendedPlayers('job', job)
    
    for _, player in pairs(players) do
        if player.source then
            table.insert(onlineStaff, player)
            TriggerClientEvent('ox_lib:notify', player.source, {
                title = 'Klingel',
                description = notification,
                type = 'inform',
                duration = 8000,
                position = 'top'
            })
        end
    end
    
    if #onlineStaff > 0 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Klingel',
            description = 'Du hast die Klingel aktiviert - ' .. #onlineStaff .. ' Mitarbeiter benachrichtigt',
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Klingel',
            description = 'Aktuell sind keine Mitarbeiter verfügbar',
            type = 'error'
        })
    end
end)
