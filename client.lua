local notified = false

for _, position in ipairs(Config.Position) do
    exports.ox_target:addBoxZone({
        coords = position.position,
        size = vec3(2, 2, 2),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'box',
                icon = 'fa-solid fa-cube',
                label = 'klingeln',
                onSelect = function(job)
                    if not notified then
                        TriggerServerEvent("cmdJobbell:notify", position.job)
                        notified = true
                        Citizen.SetTimeout(300000, function()
                            notified = false
                        end)
                    else
                        ESX.ShowNotification("leck mich am arsch du kannst erst in 5 minuten klingeln")
                    end
                end
            }
        }
    })
end
