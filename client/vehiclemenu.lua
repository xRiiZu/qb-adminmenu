QBCore = exports['qb-core']:GetCoreObject()

local function OpenCarModelsMenu(category)
    VehNameMenu:ClearItems()
    MenuV:OpenMenu(VehNameMenu)
    for k, v in pairs(category) do
        local menu_button10 = VehNameMenu:AddButton({
            label = v["name"],
            value = k,
            description = 'Spawn ' .. v["name"],
            select = function(btn)
                TriggerServerEvent('qb-admin:server:spawnVehicle', k)
            end
        })
    end
end

local performanceModIndices = { 11, 12, 13, 15, 16 }
function PerformanceUpgradeVehicle(vehicle, customWheels)
    customWheels = customWheels or false
    local max
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle, 0)
        for _, modType in ipairs(performanceModIndices) do
            max = GetNumVehicleMods(vehicle, tonumber(modType)) - 1
            SetVehicleMod(vehicle, modType, max, customWheels)
        end
        ToggleVehicleMod(vehicle, 18, true) -- Turbo
	SetVehicleFixed(vehicle)
    end
end

RegisterNetEvent('qb-admin:client:maxmodVehicle', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    PerformanceUpgradeVehicle(vehicle)
end)

local VehicleMenuButton1 = VehicleMenu:AddButton({
    icon = '🚗',
    label = Lang:t("menu.spawn_vehicle"),
    value = VehCategorieMenu,
    description = Lang:t("desc.spawn_vehicle_desc")
})
local vehicles = {}
VehicleMenuButton1:On('Select', function(item)
    VehCategorieMenu:ClearItems()
    for k, v in pairs(QBCore.Shared.Vehicles) do
        local category = v["category"]
        if vehicles[category] == nil then
            vehicles[category] = { }
        end
        vehicles[category][k] = v
    end
    for k, v in pairs(vehicles) do
        local menu_button10 = VehCategorieMenu:AddButton({
            label = k,
            value = v,
            description = Lang:t("menu.category_name"),
            select = function(btn)
                local select = btn.Value
                OpenCarModelsMenu(select)
            end
        })
    end
end)

local VehicleMenuButton2 = VehicleMenu:AddButton({
    icon = '🔧',
    label = Lang:t("menu.fix_vehicle"),
    value = 'fix',
    description = Lang:t("desc.fix_vehicle_desc")
})
VehicleMenuButton2:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "fix", {})
end)

local VehicleMenuButton3 = VehicleMenu:AddButton({
    icon = '⚒️',
    label = Lang:t("menu.max_mods"),
    value = 'maxmods',
    description = Lang:t("desc.apply_max_mods")
})
VehicleMenuButton3:On('Select', function(_)
    TriggerServerEvent('QBCore:CallCommand', "maxmods", {})
end)

local VehicleMenuButton4 = VehicleMenu:AddButton({
    icon = '💲',
    label = Lang:t("menu.buy"),
    value = 'buy',
    description = Lang:t("desc.buy_desc")
})
VehicleMenuButton4:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "admincar", {})
end)

local VehicleMenuButton5 = VehicleMenu:AddButton({
    icon = '☠',
    label = Lang:t("menu.remove_vehicle"),
    value = 'remove',
    description = Lang:t("desc.remove_vehicle_desc")
})
VehicleMenuButton5:On('Select', function(item)
    TriggerServerEvent('QBCore:CallCommand', "dv", {})
end)
