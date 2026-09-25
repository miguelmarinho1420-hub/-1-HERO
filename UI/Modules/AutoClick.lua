local AutoClick = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local clickRemote = nil

-- Procura o evento de clique do jogo para disparar via rede
function AutoClick.CacheRemotes()
    clickRemote = ReplicatedStorage:FindFirstChild("Click", true) 
        or ReplicatedStorage:FindFirstChild("Tap", true) 
        or ReplicatedStorage:FindFirstChild("ClickRemote", true)
        or ReplicatedStorage:FindFirstChild("ClickEvent", true)
end

function AutoClick.Execute(flags)
    -- Se a flag de AutoClick estiver DESLIGADA na UI, não faz nada
    if flags and not flags.AutoClick then
        return
    end

    if clickRemote and clickRemote:IsA("RemoteEvent") then
        -- Dispara o evento direto no servidor sem mexer no mouse físico
        clickRemote:FireServer()
    else
        -- Tenta recarregar o remoto caso ainda não tenha achado
        AutoClick.CacheRemotes()
    end
end

return AutoClick
