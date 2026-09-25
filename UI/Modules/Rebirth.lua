local AutoRebirth = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rebirthRemote = nil

-- Função para varrer e encontrar o RemoteEvent de Rebirth automaticamente
local function CacheRebirthRemote()
    if rebirthRemote then return rebirthRemote end

    -- Procura por termos comuns relacionados a rebirth no ReplicatedStorage
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = string.lower(obj.Name)
            if string.find(name, "rebirth") or string.find(name, "revive") or string.find(name, "evolve") then
                rebirthRemote = obj
                break
            end
        end
    end

    return rebirthRemote
end

-- Função Principal de Execução
function AutoRebirth.Execute(flags)
    -- Se o botão de Auto Rebirth estiver desligado na UI
    if not flags or not flags.AutoRebirth then
        return
    end

    local remote = CacheRebirthRemote()
    if remote and remote:IsA("RemoteEvent") then
        -- Dispara o evento de rebirth de forma silenciosa para o servidor
        -- Alguns jogos aceitam argumentos como true, 1 ou nenhum valor
        remote:FireServer()
        remote:FireServer(1) 
    end
end

return AutoRebirthlocal AutoRebirth = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rebirthRemote = nil

-- Função para varrer e encontrar o RemoteEvent de Rebirth automaticamente
local function CacheRebirthRemote()
    if rebirthRemote then return rebirthRemote end

    -- Procura por termos comuns relacionados a rebirth no ReplicatedStorage
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = string.lower(obj.Name)
            if string.find(name, "rebirth") or string.find(name, "revive") or string.find(name, "evolve") then
                rebirthRemote = obj
                break
            end
        end
    end

    return rebirthRemote
end

-- Função Principal de Execução
function AutoRebirth.Execute(flags)
    -- Se o botão de Auto Rebirth estiver desligado na UI
    if not flags or not flags.AutoRebirth then
        return
    end

    local remote = CacheRebirthRemote()
    if remote and remote:IsA("RemoteEvent") then
        -- Dispara o evento de rebirth de forma silenciosa para o servidor
        -- Alguns jogos aceitam argumentos como true, 1 ou nenhum valor
        remote:FireServer()
        remote:FireServer(1) 
    end
end

return AutoRebirth
