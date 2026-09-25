-- Tabs/main.lua
local MainTab = {}

function MainTab.Init(Window, flags)
    local tab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://6023426915"})

    tab:AddToggle({
        Name = "Auto Click",
        Default = false,
        Callback = function(Value)
            flags.AutoClick = Value
        end
    })

    tab:AddToggle({
        Name = "Auto Rebirth",
        Default = false,
        Callback = function(Value)
            flags.AutoRebirth = Value
        end
    })
end

return MainTab
