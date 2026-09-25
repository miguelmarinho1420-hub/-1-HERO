local AntiAFK = {}

local VirtualUser = game:GetService("VirtualUser")

function AntiAFK.Execute()
    -- Simula um clique de botão do mouse via serviço virtual para resetar o contador de AFK do jogo
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end

return AntiAFK
