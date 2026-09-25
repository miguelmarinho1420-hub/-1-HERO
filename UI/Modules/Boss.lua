local BossFarm = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local isBossActive = false
local dodgeConnection = nil
local guiConnection = nil

-- Configurações do Voo e Desvio
local HOVER_HEIGHT = 15 
local DODGE_SPEED = 180 
local DODGE_RADIUS = 12 

-- 1. Aceita a batalha do Boss
function BossFarm.AcceptBoss()
    local bossRemote = ReplicatedStorage:FindFirstChild("BossAccept", true) 
        or ReplicatedStorage:FindFirstChild("JoinBoss", true)
        or ReplicatedStorage:FindFirstChild("AcceptBoss", true)
        or ReplicatedStorage:FindFirstChild("BossEvent", true)

    if bossRemote and bossRemote:IsA("RemoteEvent") then
        bossRemote:FireServer(true)
    end

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Enabled then
                local yesBtn = gui:FindFirstChild("Yes", true) 
                    or gui:FindFirstChild("Accept", true) 
                    or gui:FindFirstChild("Confirm", true)
                
                if yesBtn and (yesBtn:IsA("TextButton") or yesBtn:IsA("ImageButton")) then
                    for _, connection in ipairs(getconnections(yesBtn.MouseButton1Click)) do
                        connection:Fire()
                    end
                end
            end
        end
    end
end

-- 2. Inicia/Para a esquiva aérea
function BossFarm.StartDodge(bossPosition)
    if isBossActive then return end
    isBossActive = true

    local angle = 0
    dodgeConnection = RunService.Heartbeat:Connect(function(dt)
        if not isBossActive or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            BossFarm.StopDodge()
            return
        end

        local hrp = LocalPlayer.Character.HumanoidRootPart
        angle = angle + (dt * (DODGE_SPEED / 10))
        
        local offsetX = math.cos(angle) * DODGE_RADIUS
        local offsetZ = math.sin(angle) * DODGE_RADIUS
        local targetPos = bossPosition + Vector3.new(offsetX, HOVER_HEIGHT, offsetZ)

        hrp.CFrame = CFrame.new(targetPos, bossPosition)
    end)
end

function BossFarm.StopDodge()
    isBossActive = false
    if dodgeConnection then
        dodgeConnection:Disconnect()
        dodgeConnection = nil
    end
end

-- 3. Função Principal de Execução com Ligar/Desligar
function BossFarm.Execute(flags)
    -- Se a chave AutoBoss estiver DESLIGADA na UI
    if not flags.AutoBoss then
        BossFarm.StopDodge()
        if guiConnection then
            guiConnection:Disconnect()
            guiConnection = nil
        end
        return
    end

    -- Se estiver LIGADA e o evento ainda não estiver escutando a UI do jogo
    if not guiConnection then
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        guiConnection = playerGui.ChildAdded:Connect(function(child)
            if flags.AutoBoss and string.find(string.lower(child.Name), "boss") then
                task.wait(0.1)
                BossFarm.AcceptBoss()
            end
        end)
    end
end

return BossFarm
