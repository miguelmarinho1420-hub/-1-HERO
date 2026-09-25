local AutoFarm = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Mapeamento completo: Área da Fase (AreaPos) e Almofada de Vitória (WinPos)
local StagePositions = {
    [106] = { AreaPos = Vector3.new(5250.61, 4.46, 215.25),  WinPos = Vector3.new(5238.47, 8.57, 230.90) },
    [107] = { AreaPos = Vector3.new(5252.48, 4.46, 307.55),  WinPos = Vector3.new(5238.68, 8.42, 321.96) },
    [108] = { AreaPos = Vector3.new(5252.12, 4.46, 416.19),  WinPos = Vector3.new(5238.80, 9.15, 432.81) },
    [109] = { AreaPos = Vector3.new(5252.41, 4.10, 507.29),  WinPos = Vector3.new(5239.01, 9.99, 522.61) },
    [110] = { AreaPos = Vector3.new(5252.14, 4.10, 600.08),  WinPos = Vector3.new(5239.07, 8.89, 613.58) },
    [111] = { AreaPos = Vector3.new(5252.11, 4.10, 707.39),  WinPos = Vector3.new(5238.88, 7.96, 721.40) },
    [112] = { AreaPos = Vector3.new(5251.38, 4.19, 796.83),  WinPos = Vector3.new(5239.20, 8.57, 812.62) },
    [113] = { AreaPos = Vector3.new(5251.83, 4.19, 889.44),  WinPos = Vector3.new(5238.42, 8.44, 906.12) },
    [114] = { AreaPos = Vector3.new(5251.67, 4.19, 995.83),  WinPos = Vector3.new(5239.16, 9.09, 1007.67) },
    [115] = { AreaPos = Vector3.new(5251.86, 4.03, 1088.21), WinPos = Vector3.new(5239.26, 8.21, 1103.50) },
    [116] = { AreaPos = Vector3.new(5250.86, 4.03, 1180.37), WinPos = Vector3.new(5239.17, 8.85, 1192.47) },
    [117] = { AreaPos = Vector3.new(5250.01, 4.03, 1285.70), WinPos = Vector3.new(5238.64, 8.03, 1304.30) },
    [118] = { AreaPos = Vector3.new(5250.62, 4.03, 1379.78), WinPos = Vector3.new(5238.50, 8.24, 1393.79) },
    [119] = { AreaPos = Vector3.new(5250.96, 4.03, 1468.97), WinPos = Vector3.new(5238.37, 8.93, 1485.47) },
    [120] = { AreaPos = Vector3.new(5249.88, 4.03, 1578.52), WinPos = Vector3.new(5239.13, 8.76, 1592.87) }
}

-- Função de deslizar (Glide)
local function GlideTo(targetPosition, speed)
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    speed = speed or 100
    local distance = (hrp.Position - targetPosition).Magnitude
    local duration = distance / speed

    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local tween = TweenService:Create(hrp, tweenInfo, { CFrame = CFrame.new(targetPosition) })
    tween:Play()
    tween.Completed:Wait()
end

function AutoFarm.FarmStage(currentStage, targetStage)
    local data = StagePositions[currentStage]
    if not data then return end

    -- 1. Se ainda não é o estágio final selecionado: desliza para a área e continua
    if currentStage < targetStage then
        GlideTo(data.AreaPos)
        
    -- 2. Se chegou no estágio final desejado: desliza para a área e depois vai para a almofada de vitória
    elseif currentStage == targetStage then
        GlideTo(data.AreaPos)
        task.wait(0.2)
        GlideTo(data.WinPos)
    end
end

return AutoFarm
