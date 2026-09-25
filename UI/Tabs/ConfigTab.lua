-- Tabs/config.lua
local ConfigTab = {}

function ConfigTab.Init(Window, flags, destroyCallback)
    local tab = Window:MakeTab({Name = "Config", Icon = "rbxassetid://6023426915"})

    tab:AddToggle({
        Name = "Anti-AFK",
        Default = true,
        Callback = function(Value)
            flags.AntiAFK = Value
        end
    })

    tab:AddButton({
        Name = "Desligar / Destruir Script (Unload)",
        Callback = function()
            -- Desliga todas as flags principais
            flags.AutoFarm = false
            flags.AutoBoss = false
            flags.AutoDungeon = false
            flags.AutoEgg = false
            flags.AutoEndless = false
            flags.AutoRebirth = false
            flags.AutoClick = false
            flags.AntiAFK = false

            if destroyCallback then
                destroyCallback()
            end
        end
    })
end

return ConfigTab
