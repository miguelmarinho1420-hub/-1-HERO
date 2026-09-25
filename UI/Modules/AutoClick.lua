local AutoClick = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local clickRemote = nil

-- Procura o evento de clique do jogo para disparar via rede
function AutoClick.CacheRemotes()
    -- Tenta localizar remotos comuns de clique/tap dentro do ReplicatedStorage
    clickRemote = ReplicatedStorage:FindFirstChild("Click", true) 
        or ReplicatedStorage:FindFirstChild("Tap", true) 
        or ReplicatedStorage:FindFirstChild("ClickRemote", true)
        or ReplicatedStorage:FindFirstChild("ClickEvent", true)
end

function AutoClick.Execute()
    if clickRemote and clickRemote:IsA("RemoteEvent") then
        -- Dispara o evento direto no servidor (não usa o mouse físico da tela)
        clickRemote:FireServer()
    else
        -- Tenta recarregar o remoto caso ainda não tenha achado
        AutoClick.CacheRemotes()
    end
end

return AutoClick
