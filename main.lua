local RAW = "https://raw.githubusercontent.com/miguelmarinho1420-hub/1-HERO/main/"

local flags = {
    autoClick = false,
    autoRebirth = false,
    autoEquip = false,
    autoFarmWins = false,
    skipAnim = false,
    fastHatch = false,
    autoHatch = false,
    tripleHatch = false,
    autoBoss = false,
    autoDungeon = false,
    endlessCoop = false,
    antiAfk = false
}

local running = true

-- Carregamento dos Módulos de Lógica
local AutoClick = loadstring(game:HttpGet(RAW .. "Modules/AutoClick.lua"))()
local Rebirth = loadstring(game:HttpGet(RAW .. "Modules/Rebirth.lua"))()
local EquipBest = loadstring(game:HttpGet(RAW .. "Modules/EquipBest.lua"))()
local AutoFarm = loadstring(game:HttpGet(RAW .. "Modules/AutoFarm.lua"))()
local EggHatch = loadstring(game:HttpGet(RAW .. "Modules/EggHatch.lua"))()
local Boss = loadstring(game:HttpGet(RAW .. "Modules/Boss.lua"))()
local Dungeon = loadstring(game:HttpGet(RAW .. "Modules/Dungeon.lua"))()
local EndlessCoop = loadstring(game:HttpGet(RAW .. "Modules/EndlessCoop.lua"))()
local AntiAFK = loadstring(game:HttpGet(RAW .. "Modules/AntiAFK.lua"))()

-- Carregamento das Abas da Interface
local tabsModules = {
    MainTab = loadstring(game:HttpGet(RAW .. "UI/Tabs/MainTab.lua"))(),
    FarmTab = loadstring(game:HttpGet(RAW .. "UI/Tabs/FarmTab.lua"))(),
    EggsTab = loadstring(game:HttpGet(RAW .. "UI/Tabs/EggsTab.lua"))(),
    EventsTab = loadstring(game:HttpGet(RAW .. "UI/Tabs/EventsTab.lua"))(),
    ConfigTab = loadstring(game:HttpGet(RAW .. "UI/Tabs/ConfigTab.lua"))()
}

-- Carregamento da Interface Principal
local MainGui = loadstring(game:HttpGet(RAW .. "UI/MainGui.lua"))()

AutoClick.CacheRemotes()

MainGui.Init(flags, tabsModules, function()
    running = false
    for k in pairs(flags) do flags[k] = false end
end)

local Players = game:GetService("Players")
local idledConnection
idledConnection = Players.LocalPlayer.Idled:Connect(function()
    if flags.antiAfk and running then
        AntiAFK.Execute()
    end
end)

task.spawn(function()
    local stageIndex = 1
    while running do
        task.wait(0.1)
        if flags.autoClick then AutoClick.Execute() end
        if flags.autoRebirth then Rebirth.Execute() end
        if flags.autoEquip then EquipBest.Execute() end
        if flags.skipAnim then EggHatch.HandleSkipAnim(true) end
        if flags.fastHatch or flags.autoHatch then EggHatch.FastHatch() end
        if flags.autoBoss and Boss.KillBoss then Boss.KillBoss() end
        if flags.autoDungeon and Dungeon.Execute then Dungeon.Execute() end
        if flags.endlessCoop then EndlessCoop.Execute() end
        if flags.autoFarmWins then
            AutoFarm.FarmStage(stageIndex)
            stageIndex = stageIndex >= 120 and 1 or stageIndex + 1
        end
    end
    if idledConnection then idledConnection:Disconnect() end
end)
