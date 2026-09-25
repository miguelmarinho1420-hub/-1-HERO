-- Tabs/eggs.lua
local EggsTab = {}

function EggsTab.Init(Window, flags)
    local tab = Window:MakeTab({Name = "Eggs", Icon = "rbxassetid://6023426915"})

    tab:AddToggle({
        Name = "Auto Egg (Abrir Rápido / Skip)",
        Default = false,
        Callback = function(Value)
            flags.AutoEgg = Value
        end
    })

    tab:AddDropdown({
        Name = "Quantidade de Abertura",
        Default = 1,
        Values = {1, 2},
        Callback = function(Value)
            flags.EggAmount = tonumber(Value)
        end
    })
end

return EggsTab
