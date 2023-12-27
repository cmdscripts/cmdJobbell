
CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        for _, v in pairs(Config.Position or {}) do
            if v and v.pos then
                local position = v.pos
                local playerPosition = GetEntityCoords(playerPed)
                local distance = #(playerPosition - vector3(position.x, position.y, position.z))

                if distance <= 3.0 then
                    sleep = 0
                    DrawMarker(Config.Marker, position.x, position.y, (position.z) - 1.0, 0.0, 0.0, 0.0, 360.0, 0.0, 0.0, 1.0, 1.0, 1.0, 60, 66, 207, 155)
                end
                if distance <= 1.0 then
                    sleep = 0
                    local helpNotificationText = v.helpNotification or Config.DefaultHelpNotification
                    ESX.ShowHelpNotification(helpNotificationText)
                    if IsControlJustPressed(1, Config.Control) then
                        TriggerServerEvent("cmdJobbell:notify", v.job)
                        Wait(Config.WaitAfterBell)
                    end
                end
            end
        end

        Wait(sleep)
    end
end)