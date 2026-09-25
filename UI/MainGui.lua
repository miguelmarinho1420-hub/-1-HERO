local MainGui = {}

function MainGui.Init(flags, tabsModules, onCloseCallback)
    local CoreGui = game:GetService("CoreGui")
    if CoreGui:FindFirstChild("OneHeroGui") then
        CoreGui.OneHeroGui:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OneHeroGui"
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Text = "1 Superhero Evolution"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 16
    Title.Parent = MainFrame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 2.5)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = MainFrame

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        if onCloseCallback then onCloseCallback() end
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 120, 1, -35)
    Sidebar.Position = UDim2.new(0, 5, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -135, 1, -35)
    ContentArea.Position = UDim2.new(0, 130, 0, 30)
    ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    ContentArea.BorderSizePixel = 0
    ContentArea.Parent = MainFrame

    local tabButtons = {
        {"Principal", "MainTab"},
        {"Farm", "FarmTab"},
        {"Ovos", "EggsTab"},
        {"Eventos", "EventsTab"},
        {"Config", "ConfigTab"}
    }

    local loadedTabs = {}

    for i, tabInfo in ipairs(tabButtons) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 5)
        btn.Text = tabInfo[1]
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
        btn.BorderSizePixel = 0
        btn.Parent = Sidebar

        local tabFrame = Instance.new("ScrollingFrame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = ContentArea
        tabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        tabFrame.ScrollBarThickness = 4

        loadedTabs[tabInfo[2]] = tabFrame

        if tabsModules[tabInfo[2]] and tabsModules[tabInfo[2]].Render then
            tabsModules[tabInfo[2]].Render(tabFrame, flags)
        end

        btn.MouseButton1Click:Connect(function()
            for _, frame in pairs(loadedTabs) do
                frame.Visible = false
            end
            tabFrame.Visible = true
        end)
    end

    if loadedTabs["MainTab"] then
        loadedTabs["MainTab"].Visible = true
    end
end

return MainGui
