-- QuantumKaitun/hud.lua
getgenv().QuantumKaitun = getgenv().QuantumKaitun or {}
local QuantumKaitun = getgenv().QuantumKaitun

do
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Contenedor principal de la UI
    if CoreGui:FindFirstChild("QuantumKaitunHUD") then
        CoreGui.QuantumKaitunHUD:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "QuantumKaitunHUD"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    -- Pantalla Negra (Black Screen / Optimization)
    local BlackScreenFrame = Instance.new("Frame")
    BlackScreenFrame.Name = "BlackScreen"
    BlackScreenFrame.Size = UDim2.new(1, 0, 1, 0)
    BlackScreenFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BlackScreenFrame.Visible = false
    BlackScreenFrame.ZIndex = 1
    BlackScreenFrame.Parent = ScreenGui

    -- Tarjeta Flotante estilo Matsune Hub
    local Card = Instance.new("Frame")
    Card.Name = "MainCard"
    Card.Size = UDim2.new(0, 280, 0, 240)
    Card.Position = UDim2.new(0.05, 0, 0.2, 0)
    Card.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    Card.BorderSizePixel = 0
    Card.Active = true
    Card.Draggable = true
    Card.ZIndex = 10
    Card.Parent = ScreenGui

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 10)
    CardCorner.Parent = Card

    -- Background Image Support
    local CardBG = Instance.new("ImageLabel")
    CardBG.Name = "BGImage"
    CardBG.Size = UDim2.new(1, 0, 1, 0)
    CardBG.BackgroundTransparency = 1
    CardBG.ImageTransparency = 0.85
    CardBG.ScaleType = Enum.ScaleType.Crop
    CardBG.ZIndex = 10
    CardBG.Parent = Card

    local BGCorner = Instance.new("UICorner")
    BGCorner.CornerRadius = UDim.new(0, 10)
    BGCorner.Parent = CardBG

    -- Titulo
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.BackgroundTransparency = 1
    Title.Text = "QuantumKaitun"
    Title.TextColor3 = Color3.fromRGB(0, 170, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 11
    Title.Parent = Card

    -- Informacion (Nivel, Beli, Fragmentos, Tarea)
    local InfoContainer = Instance.new("Frame")
    InfoContainer.Size = UDim2.new(1, -20, 0, 110)
    InfoContainer.Position = UDim2.new(0, 10, 0, 40)
    InfoContainer.BackgroundTransparency = 1
    InfoContainer.ZIndex = 11
    InfoContainer.Parent = Card

    local UIList = Instance.new("UIListLayout")
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 4)
    UIList.Parent = InfoContainer

    local function CreateLabel(name, text)
        local lbl = Instance.new("TextLabel")
        lbl.Name = name
        lbl.Size = UDim2.new(1, 0, 0, 20)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        lbl.TextSize = 13
        lbl.Font = Enum.Font.Gotham
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 11
        lbl.Parent = InfoContainer
        return lbl
    end

    local LevelLbl = CreateLabel("LevelLbl", "Nivel: 0")
    local BeliLbl = CreateLabel("BeliLbl", "Beli: $0")
    local FragmentsLbl = CreateLabel("FragmentsLbl", "Fragmentos: 0")
    local TaskLbl = CreateLabel("TaskLbl", "Tarea: Inicializando...")

    -- Botones / Controles en Tarjeta
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, -20, 0, 35)
    ButtonContainer.Position = UDim2.new(0, 10, 0, 155)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.ZIndex = 11
    ButtonContainer.Parent = Card

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0.48, 0, 1, 0)
    ToggleBtn.Position = UDim2.new(0, 0, 0, 0)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ToggleBtn.Text = "Pausar"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.ZIndex = 12
    ToggleBtn.Parent = ButtonContainer

    local BtnCorner1 = Instance.new("UICorner")
    BtnCorner1.CornerRadius = UDim.new(0, 6)
    BtnCorner1.Parent = ToggleBtn

    local BlackScreenBtn = Instance.new("TextButton")
    BlackScreenBtn.Size = UDim2.new(0.48, 0, 1, 0)
    BlackScreenBtn.Position = UDim2.new(0.52, 0, 0, 0)
    BlackScreenBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    BlackScreenBtn.Text = "Black Screen"
    BlackScreenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    BlackScreenBtn.Font = Enum.Font.GothamBold
    BlackScreenBtn.TextSize = 12
    BlackScreenBtn.ZIndex = 12
    BlackScreenBtn.Parent = ButtonContainer

    local BtnCorner2 = Instance.new("UICorner")
    BtnCorner2.CornerRadius = UDim.new(0, 6)
    BtnCorner2.Parent = BlackScreenBtn

    -- Eventos de Botones
    ToggleBtn.MouseButton1Click:Connect(function()
        if QuantumKaitun.Brain then
            local isRunning = QuantumKaitun.Brain:TogglePause()
            ToggleBtn.Text = isRunning and "Pausar" or "Reanudar"
            ToggleBtn.BackgroundColor3 = isRunning and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(200, 50, 50)
        end
    end)

    BlackScreenBtn.MouseButton1Click:Connect(function()
        BlackScreenFrame.Visible = not BlackScreenFrame.Visible
    end)

    -- Selector de Temas y Render
    local HUD = {
        ScreenGui = ScreenGui,
        Card = Card
    }

    function HUD:ApplyTheme(themeName)
        local themes = QuantumKaitun.Themes or {}
        local theme = themes[themeName] or themes.QuantumDark
        if theme then
            Card.BackgroundColor3 = theme.BG or Color3.fromRGB(15, 15, 20)
            Title.TextColor3 = theme.Accent or Color3.fromRGB(0, 170, 255)
            ToggleBtn.BackgroundColor3 = theme.Accent or Color3.fromRGB(0, 170, 255)
            if theme.BackgroundImage then
                CardBG.Image = theme.BackgroundImage
            end
        end
    end

    function HUD:Update()
        pcall(function()
            local data = LocalPlayer:FindFirstChild("Data")
            if data then
                LevelLbl.Text = "Nivel: " .. tostring(data:FindFirstChild("Level") and data.Level.Value or 0)
                BeliLbl.Text = "Beli: $" .. tostring(data:FindFirstChild("Beli") and data.Beli.Value or 0)
                FragmentsLbl.Text = "Fragmentos: " .. tostring(data:FindFirstChild("Fragments") and data.Fragments.Value or 0)
            end
            if QuantumKaitun.Brain then
                TaskLbl.Text = "Tarea: " .. tostring(QuantumKaitun.Brain.CurrentTask or "Idle")
            end
        end)
    end

    -- Loop de actualizacion de UI
    task.spawn(function()
        HUD:ApplyTheme(QuantumKaitun.CurrentTheme or "QuantumDark")
        while task.wait(0.5) do
            HUD:Update()
        end
    end)

    QuantumKaitun.HUD = HUD
end

return QuantumKaitun.HUD
