-- ================================================
--   STEAL A BRAINROT - ADMIN SPAMMER
--   Executor / LocalScript olarak çalışır
-- ================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Komutları gönderme fonksiyonu
local function sendCommand(cmd)
    -- Yeni Roblox chat sistemi
    local success = pcall(function()
        local TextChatService = game:GetService("TextChatService")
        local channel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if channel then
            channel:SendAsync(cmd)
        end
    end)
    -- Eski chat sistemi (fallback)
    if not success then
        pcall(function()
            game:GetService("ReplicatedStorage")
                .DefaultChatSystemChatEvents
                .SayMessageRequest:FireServer(cmd, "All")
        end)
    end
end

-- ============================
--   GUI OLUŞTURMA
-- ============================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdminSpammer"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Ana pencere
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 280, 0, 420)
Main.Position = UDim2.new(0.5, -140, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- Kenarlık efekti
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 80, 30)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = Main

-- Arka plan gradient
local BgGradient = Instance.new("UIGradient")
BgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 15))
})
BgGradient.Rotation = 135
BgGradient.Parent = Main

-- ============================
--   BAŞLIK BÖLÜMÜ
-- ============================

local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 52)
Header.BackgroundColor3 = Color3.fromRGB(255, 60, 20)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 10))
})
HeaderGradient.Rotation = 90
HeaderGradient.Parent = Header

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

-- Alt köşeleri düzeltme
local HeaderFix = Instance.new("Frame")
HeaderFix.Size = UDim2.new(1, 0, 0, 12)
HeaderFix.Position = UDim2.new(0, 0, 1, -12)
HeaderFix.BackgroundColor3 = Color3.fromRGB(255, 60, 20)
HeaderFix.BorderSizePixel = 0
HeaderFix.Parent = Header

local HeaderGradient2 = Instance.new("UIGradient")
HeaderGradient2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 10))
})
HeaderGradient2.Rotation = 90
HeaderGradient2.Parent = HeaderFix

-- Icon
local Icon = Instance.new("TextLabel")
Icon.Size = UDim2.new(0, 36, 0, 36)
Icon.Position = UDim2.new(0, 10, 0, 8)
Icon.BackgroundTransparency = 1
Icon.Text = "⚡"
Icon.TextSize = 22
Icon.Font = Enum.Font.GothamBold
Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
Icon.Parent = Header

-- Başlık yazısı
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 48, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Admin Spammer"
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Alt başlık
local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -100, 0, 14)
SubTitle.Position = UDim2.new(0, 48, 0, 28)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Steal a Brainrot"
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextColor3 = Color3.fromRGB(255, 200, 180)
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- Yenile butonu
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 32, 0, 32)
RefreshBtn.Position = UDim2.new(1, -76, 0, 10)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.BackgroundTransparency = 0.8
RefreshBtn.Text = "↺"
RefreshBtn.TextSize = 18
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Parent = Header

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 8)
RefreshCorner.Parent = RefreshBtn

-- Kapat butonu
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundTransparency = 0.8
CloseBtn.Text = "✕"
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- ============================
--   OYUNCU LİSTESİ BÖLÜMÜ
-- ============================

local PlayerLabel = Instance.new("TextLabel")
PlayerLabel.Size = UDim2.new(1, -20, 0, 20)
PlayerLabel.Position = UDim2.new(0, 10, 0, 60)
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.Text = "🎮  SUNUCUDAKI OYUNCULAR"
PlayerLabel.TextSize = 10
PlayerLabel.Font = Enum.Font.GothamBold
PlayerLabel.TextColor3 = Color3.fromRGB(180, 120, 100)
PlayerLabel.TextXAlignment = Enum.TextXAlignment.Left
PlayerLabel.Parent = Main

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 230)
ScrollFrame.Position = UDim2.new(0, 10, 0, 84)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 80, 30)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = Main

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollFrame

local ScrollStroke = Instance.new("UIStroke")
ScrollStroke.Color = Color3.fromRGB(255, 80, 30)
ScrollStroke.Thickness = 1
ScrollStroke.Transparency = 0.7
ScrollStroke.Parent = ScrollFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.Name
ListLayout.Padding = UDim.new(0, 4)
ListLayout.Parent = ScrollFrame

local ListPadding = Instance.new("UIPadding")
ListPadding.PaddingTop = UDim.new(0, 4)
ListPadding.PaddingLeft = UDim.new(0, 4)
ListPadding.PaddingRight = UDim.new(0, 4)
ListPadding.Parent = ScrollFrame

-- ============================
--   DURUM VE SPAM BÖLÜMÜ
-- ============================

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 322)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Bir oyuncu seç..."
StatusLabel.TextSize = 11
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Main

local SpamBtn = Instance.new("TextButton")
SpamBtn.Size = UDim2.new(1, -20, 0, 56)
SpamBtn.Position = UDim2.new(0, 10, 0, 348)
SpamBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 20)
SpamBtn.BorderSizePixel = 0
SpamBtn.Text = "⚡  SPAM BAŞLAT"
SpamBtn.TextSize = 15
SpamBtn.Font = Enum.Font.GothamBold
SpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpamBtn.AutoButtonColor = false
SpamBtn.Parent = Main

local SpamCorner = Instance.new("UICorner")
SpamCorner.CornerRadius = UDim.new(0, 10)
SpamCorner.Parent = SpamBtn

local SpamGradient = Instance.new("UIGradient")
SpamGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 10))
})
SpamGradient.Rotation = 90
SpamGradient.Parent = SpamBtn

-- ============================
--   SÜRÜKLE DESTEĞİ
-- ============================

local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ============================
--   OYUNCU LİSTESİ MANTIĞI
-- ============================

local selectedPlayer = nil
local playerButtons = {}

local commands = {
    "rocket", "ragdoll", "balloon", "inverse",
    "jail", "control", "jumpscare", "tiny", "morph"
}

local function deselectAll()
    for _, data in pairs(playerButtons) do
        TweenService:Create(data.btn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        }):Play()
        data.dot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

local function updatePlayers()
    -- Temizle
    for _, data in pairs(playerButtons) do
        data.btn:Destroy()
    end
    playerButtons = {}
    selectedPlayer = nil
    StatusLabel.Text = "Bir oyuncu seç..."
    StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)

    local count = 0
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            count = count + 1

            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 38)
            Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            Btn.BorderSizePixel = 0
            Btn.Text = ""
            Btn.AutoButtonColor = false
            Btn.Parent = ScrollFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 7)
            BtnCorner.Parent = Btn

            -- Sol renkli nokta
            local Dot = Instance.new("Frame")
            Dot.Size = UDim2.new(0, 6, 0, 6)
            Dot.Position = UDim2.new(0, 10, 0.5, -3)
            Dot.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            Dot.BorderSizePixel = 0
            Dot.Parent = Btn

            local DotCorner = Instance.new("UICorner")
            DotCorner.CornerRadius = UDim.new(1, 0)
            DotCorner.Parent = Dot

            -- Avatar ikonu
            local Avatar = Instance.new("TextLabel")
            Avatar.Size = UDim2.new(0, 24, 0, 24)
            Avatar.Position = UDim2.new(0, 20, 0.5, -12)
            Avatar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            Avatar.Text = string.sub(player.Name, 1, 1):upper()
            Avatar.TextSize = 12
            Avatar.Font = Enum.Font.GothamBold
            Avatar.TextColor3 = Color3.fromRGB(200, 200, 200)
            Avatar.Parent = Btn

            local AvatarCorner = Instance.new("UICorner")
            AvatarCorner.CornerRadius = UDim.new(0, 5)
            AvatarCorner.Parent = Avatar

            -- İsim
            local NameLabel = Instance.new("TextLabel")
            NameLabel.Size = UDim2.new(1, -60, 1, 0)
            NameLabel.Position = UDim2.new(0, 52, 0, 0)
            NameLabel.BackgroundTransparency = 1
            NameLabel.Text = player.Name
            NameLabel.TextSize = 13
            NameLabel.Font = Enum.Font.GothamMedium
            NameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            NameLabel.TextXAlignment = Enum.TextXAlignment.Left
            NameLabel.Parent = Btn

            local data = { btn = Btn, dot = Dot, name = player.Name }
            table.insert(playerButtons, data)

            Btn.MouseButton1Click:Connect(function()
                deselectAll()
                selectedPlayer = player.Name
                TweenService:Create(Btn, TweenInfo.new(0.15), {
                    BackgroundColor3 = Color3.fromRGB(60, 25, 15)
                }):Play()
                Dot.BackgroundColor3 = Color3.fromRGB(255, 100, 30)
                StatusLabel.Text = "✅  Seçildi: " .. player.Name
                StatusLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
            end)
        end
    end

    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 42 + 8)

    if count == 0 then
        StatusLabel.Text = "⚠  Sunucuda başka oyuncu yok"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 180, 50)
    end
end

-- ============================
--   SPAM MANTIĞI
-- ============================

local spamming = false

SpamBtn.MouseButton1Click:Connect(function()
    if not selectedPlayer then
        local orig = SpamBtn.Text
        SpamBtn.Text = "❌  Önce oyuncu seç!"
        task.wait(1.5)
        SpamBtn.Text = orig
        return
    end

    if spamming then
        -- Durdur
        spamming = false
        SpamGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 20)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 10))
        })
        SpamBtn.Text = "⚡  SPAM BAŞLAT"
        StatusLabel.Text = "⛔  Spam durduruldu."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    else
        -- Başlat
        spamming = true
        SpamGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 200, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 140, 50))
        })
        SpamBtn.Text = "🛑  DURDUR"

        task.spawn(function()
            local round = 0
            while spamming do
                round = round + 1
                for _, cmd in ipairs(commands) do
                    if not spamming then break end
                    sendCommand(";" .. cmd .. " " .. selectedPlayer)
                    StatusLabel.Text = "⚡  [" .. round .. "] ;" .. cmd .. " → " .. selectedPlayer
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
                    task.wait(0.45)
                end
                task.wait(0.2)
            end
            SpamBtn.Text = "⚡  SPAM BAŞLAT"
            SpamGradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 20)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 30, 10))
            })
        end)
    end
end)

-- Kapat
CloseBtn.MouseButton1Click:Connect(function()
    spamming = false
    ScreenGui:Destroy()
end)

-- Yenile
RefreshBtn.MouseButton1Click:Connect(function()
    local orig = RefreshBtn.Text
    RefreshBtn.Text = "..."
    updatePlayers()
    task.wait(0.3)
    RefreshBtn.Text = orig
end)

-- Oyuncu giriş/çıkış olayları
Players.PlayerAdded:Connect(function()
    task.wait(0.1)
    updatePlayers()
end)

Players.PlayerRemoving:Connect(function(p)
    if selectedPlayer == p.Name then
        selectedPlayer = nil
        spamming = false
    end
    task.wait(0.1)
    updatePlayers()
end)

-- İlk yükleme
updatePlayers()
