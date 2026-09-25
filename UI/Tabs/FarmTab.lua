-- Tabs/farm.lua
local FarmTab = {}

function FarmTab.Init(Window, flags)
    local tab = Window:MakeTab({Name = "Farm", Icon = "rbxassetid://6023426915"})

    tab:AddToggle({
        Name = "Auto Farm Win",
        Default = false,
        Callback = function(Value)
            flags.AutoFarm = Value
        end
    })

    tab:AddDropdown({
        Name = "Selecionar Estágio Alvo",
        Default = 120,
        Values = {106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120},
        Callback = function(Value)
            flags.TargetStage = tonumber(Value)
        end
    })
end

return FarmTab
