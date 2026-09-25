local EndlessCoop = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local isCoopRunning = false

-- Coordenadas exatas extraídas do console
local COOP_LOCATE_POS = Vector3.new(5204.12, 4.00, 29.43) -- 1º TP: Para aparecer o botão de entrada[cite: 5]
local COOP_WAIT_POS   = Vector3.new(4813.48, 15.50, -1305.00) -- 2º TP: Lugar para travar o boneco no coop[cite: 5]

-- Função para aceitar/entrar no Coop automaticamente
local function AcceptCoopInvite()
    local coopRemote = ReplicatedStorage:FindFirstChild("EndlessCoop", true)
        or ReplicatedStorage:FindFirstChild("JoinCoop", true)
        or ReplicatedStorage:FindFirstChild("AcceptCoop", true)
        or ReplicatedStorage:FindFirstChild("StartCoop", true)

    if coopRemote and coopRemote:IsA("RemoteEvent") then
        coopRemote:FireServer(true)
    end

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Enabled then
                local btn = gui:FindFirstChild("Accept", true) 
                    or gui:FindFirstChild("Join", true)
                    or gui:FindFirstChild("Yes", true)
                
                if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) then
                    for _, connection in ipairs(getconnections(btn.MouseButton1Click)) do
                        connection:Fire()
                    end
                end
            end
        end
    end
end

local function TeleportTo(position)
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Função Principal de Execução
function EndlessCoop.Execute(flags)
    -- Se o botão do Endless Coop estiver desligado
    if not flags or not flags.AutoEndless then
        isCoopRunning = false
        return
    end

    if isCoopRunning then return end
    isCoopRunning = true

    task.spawn(function()
        -- 1. Dá o primeiro TP até a localização para aparecer o botão de entrada[cite: 5]
        TeleportTo(COOP_LOCATE_POS)
        task.wait(0.6)

        -- 2. Aceita para entrar na partida
        AcceptCoopInvite()
        task.wait(1.5)

        -- 3. Vai para a segunda coordenada e trava o personagem lá dentro do coop[cite: 5]
        while flags.AutoEndless and isCoopRunning do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                if (char.HumanoidRootPart.Position - COOP_WAIT_POS).Magnitude > 5 then
                    TeleportTo(COOP_WAIT_POS)
                end
            end
            task.wait(0.5)
        end
        isCoopRunning = false
    end)
end

return EndlessCoop
