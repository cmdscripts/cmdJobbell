local ESX = exports['es_extended']:getSharedObject()
local cooldowns = {}

local function isOnCooldown(position)
    local currentTime = GetGameTimer()
    return cooldowns[position] and (currentTime - cooldowns[position]) < 300000
end

local function setCooldown(position)
    cooldowns[position] = GetGameTimer()
end

local function triggerBell(position)
    if isOnCooldown(position.position) then
        lib.notify({
            title = 'Klingel',
            description = 'Du kannst erst in 5 Minuten wieder klingeln',
            type = 'error'
        })
        return
    end

    TriggerServerEvent("cmdJobbell:notify", position.job)
    setCooldown(position.position)
end

if Config.UseOXTarget then
    for _, position in ipairs(Config.Position) do
        exports.ox_target:addBoxZone({
            coords = position.position,
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = Config.Debug,
            options = {
                {
                    name = 'jobbell_' .. position.job,
                    icon = 'fa-solid fa-bell',
                    label = 'Klingeln',
                    onSelect = function()
                        triggerBell(position)
                    end
                }
            }
        })
    end
else
    local inMarker = {}
    local currentMarker = nil

    CreateThread(function()
        while true do
            local sleep = 1000
            local playerCoords = GetEntityCoords(PlayerPedId())
            local nearMarker = false

            for i, position in ipairs(Config.Position) do
                local distance = #(playerCoords - position.position)
                
                if distance < 10.0 then
                    sleep = 0
                    DrawMarker(
                        1,
                        position.position.x, position.position.y, position.position.z - 1.0,
                        0.0, 0.0, 0.0,
                        0.0, 0.0, 0.0,
                        2.0, 2.0, 1.0,
                        255, 255, 0, 100,
                        false, true, 2, false, nil, nil, false
                    )
                    
                    if distance < 2.0 then
                        nearMarker = true
                        if not inMarker[i] then
                            inMarker[i] = true
                            currentMarker = i
                            lib.showTextUI('[E] Klingeln', {
                                position = "top-center",
                                icon = 'bell'
                            })
                        end
                    elseif inMarker[i] then
                        inMarker[i] = false
                        if currentMarker == i then
                            currentMarker = nil
                            lib.hideTextUI()
                        end
                    end
                elseif inMarker[i] then
                    inMarker[i] = false
                    if currentMarker == i then
                        currentMarker = nil
                        lib.hideTextUI()
                    end
                end
            end

            if not nearMarker and currentMarker then
                currentMarker = nil
                lib.hideTextUI()
                for j = 1, #Config.Position do
                    inMarker[j] = false
                end
            end

            Wait(sleep)
        end
    end)

    CreateThread(function()
        while true do
            if currentMarker and IsControlJustReleased(0, 38) then
                triggerBell(Config.Position[currentMarker])
            end
            Wait(0)
        end
    end)
end
