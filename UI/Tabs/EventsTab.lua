-- Tabs/events.lua
local EventsTab = {}

function EventsTab.Init(Window, flags)
    local tab = Window:MakeTab({Name = "Events", Icon = "rbxassetid://6023426915"})

    tab:AddToggle({
        Name = "Auto Dungeon (Bypass Parkour)",
        Default = false,
        Callback = function(Value)
            flags.AutoDungeon = Value
        end
    })

    tab:AddToggle({
        Name = "Auto Boss (Aceitar & Desviar)",
        Default = false,
        Callback = function(Value)
            flags.AutoBoss = Value
        end
    })

    tab:AddToggle({
        Name = "Endless Coop",
        Default = false,
        Callback = function(Value)
            flags.AutoEndless = Value
        end
    })
end

return EventsTab
