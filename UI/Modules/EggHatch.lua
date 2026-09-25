local EggFarm = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local isEggOpening = false

-- Localiza os ovos espalhados pelos 8 mundos no Workspace
local function FindEggsInWorlds()
    local eggsList = {}
    local workspaceChildren = workspace:GetChildren()

    for _, child in ipairs(workspaceChildren) do
        -- Procura pastas de mundos ou objetos de ovos diretamente
        if string.find(string.lower(child.Name), "world") or string.find(string.lower(child.Name), "egg") then
            for _, obj in ipairs(child:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("Model") then
                    if string.find(string.lower(obj.Name), "egg") then
                        table.insert(eggsList, obj)
                    end
                end
            end
        end
    end

    return eggsList
end

-- Procura o RemoteEvent responsável por chocar/abrir ovos
local function GetHatchRemote()
    return ReplicatedStorage:FindFirstChild("HatchEgg", true)
        or ReplicatedStorage:FindFirstChild("OpenEgg", true)
        or ReplicatedStorage:FindFirstChild("BuyEgg", true)
        or ReplicatedStorage:FindFirstChild("Hatch", true)
end

-- Função Principal de Execução
function EggFarm.Execute(flags)
    -- Se o Auto Egg estiver desligado
    if not flags or not flags.AutoEgg then
        isEggOpening = false
        return
    end

    if isEggOpening then return end
    isEggOpening = true

    local hatchRemote = GetHatchRemote()
    local hatchAmount = flags.EggAmount or 1 -- 1 para abrir um, 2 para abrir dois ovos automáticos

    task.spawn(function()
        while flags.AutoEgg and isEggOpening do
            if hatchRemote and hatchRemote:IsA("RemoteEvent") then
                -- Dispara o evento de abertura ignorando animações visuais (HatchVisuals)
                hatchRemote:FireServer(flags.SelectedEggName or "DefaultEgg", hatchAmount)
            end

            -- Velocidade acelerada de abertura (intervalo menor para chocar mais rápido)
            task.wait(0.1) 
        end
        isEggOpening = false
    end)
end

return EggFarm
