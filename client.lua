CreateThread(function()
    while true do
        local sleep = 500
        local playerPed = PlayerPedId()
        for _,v in pairs(Config.Position) do
            local position = v.position
            local playerPosition = GetEntityCoords(playerPed)
            local distance = #(playerPosition - vector3(position.x, position.y, position.z))

            if distance <= 3.0 then
                sleep = 0
                DrawMarker(21, position.x, position.y, (position.z)-1.0,0.0, 0.0, 0.0, 360.0, 0.0, 0.0, 1.0, 1.0, 1.0, 60, 66, 207, 155)
            end
            if distance <= 1.0 then
                sleep = 0
                local helpNotificationText = v.helpNotification or Config.DefaultHelpNotification
                ShowHelpNotification(helpNotificationText)
                if IsControlJustPressed(1, Config.Control) then
                    TriggerServerEvent("cmdJobbell:notify", v.job)
                    Wait(Config.WaitAfterBell)
                end
            end
        end

        Wait(sleep)
    end
end)

exports.ox_target:addBoxZone({
    coords = vec3(438.74417114258, -987.93365478516, 30.724325180054),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'box',
            event = 'ox_target:debug',
            icon = 'fa-solid fa-cube',
            label = 'Debug Box',
        }
    }
})