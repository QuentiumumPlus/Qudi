--[[
    ╔══════════════════════════════════════════════════════╗
    ║   STEAL A BRAINROT - SECRET → OG MUTATION v5         ║
    ║                                                      ║
    ║   Aynı BillboardGui içinde "Lucky Block" + "Secret"  ║
    ║   birlikte varsa → o "Secret"i OG yapar.             ║
    ║   Model ismine BAKMAZ, %100 doğru hedef alır.        ║
    ╚══════════════════════════════════════════════════════╝
    KURULUM: ServerScriptService → ServerScript
]]

local TweenService = game:GetService("TweenService")

-- ════════════════════════════════════════════
--  FALLBACK STİL
-- ════════════════════════════════════════════

local OG_STYLE = {
    TextColor3              = Color3.fromRGB(195, 255, 50),
    TextStrokeColor3        = Color3.fromRGB(0, 0, 0),
    TextStrokeTransparency  = 0,
    Font                    = Enum.Font.GothamBold,
    TextSize                = 16,
    TextTransparency        = 0,
}

-- ════════════════════════════════════════════
--  STRAWBERRY ELEPHANT STİLİNİ BUL
-- ════════════════════════════════════════════

local function findStrawberryOGStyle()
    for _, desc in ipairs(workspace:GetDescendants()) do
        if (desc:IsA("TextLabel") or desc:IsA("TextButton"))
            and string.upper(string.gsub(desc.Text, "%s", "")) == "OG"
        then
            local p = desc.Parent
            while p and p ~= workspace do
                if string.find(string.lower(p.Name), "strawberry") then
                    print("[OG v5] ✓ Strawberry Elephant stili bulundu!")
                    return {
                        TextColor3              = desc.TextColor3,
                        TextStrokeColor3        = desc.TextStrokeColor3,
                        TextStrokeTransparency  = desc.TextStrokeTransparency,
                        Font                    = desc.Font,
                        TextSize                = desc.TextSize,
                        TextScaled              = desc.TextScaled,
                        TextTransparency        = desc.TextTransparency,
                    }
                end
                p = p.Parent
            end
        end
    end
    warn("[OG v5] Strawberry Elephant bulunamadı, fallback kullanılıyor.")
    return nil
end

-- ════════════════════════════════════════════
--  OG UYGULA
-- ════════════════════════════════════════════

local function applyOG(secretLabel, style)
    if secretLabel:GetAttribute("OGv5Done") then return end
    secretLabel:SetAttribute("OGv5Done", true)

    local s = style or OG_STYLE

    secretLabel.Text                   = "OG"
    secretLabel.TextColor3             = s.TextColor3
    secretLabel.TextStrokeColor3       = s.TextStrokeColor3
    secretLabel.TextStrokeTransparency = s.TextStrokeTransparency
    secretLabel.Font                   = s.Font
    secretLabel.TextTransparency       = s.TextTransparency

    -- Uzaklaşınca büyümesin: TextScaled KAPALIYKEN sabit boyut kullan
    secretLabel.TextScaled = false
    secretLabel.TextSize   = (s.TextSize and s.TextSize > 10) and s.TextSize or 16

    -- ── UIStroke: Yazının etrafına siyah çizgi ──
    local existingStroke = secretLabel:FindFirstChildOfClass("UIStroke")
    if existingStroke then existingStroke:Destroy() end
    local stroke = Instance.new("UIStroke")
    stroke.Color           = Color3.fromRGB(0, 0, 0)
    stroke.Thickness       = 2.0
    stroke.Transparency    = 0
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    stroke.Parent          = secretLabel


    -- Pulse efekti
    local lighter = Color3.new(
        math.min(s.TextColor3.R + 0.15, 1),
        math.min(s.TextColor3.G + 0.15, 1),
        math.min(s.TextColor3.B + 0.15, 1)
    )
    TweenService:Create(
        secretLabel,
        TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        { TextColor3 = lighter }
    ):Play()

    print("[OG v5] ✓ Secret → OG yapıldı: " .. secretLabel:GetFullName())
end

-- ════════════════════════════════════════════
--  SATIŞ EKRANINDA "OG LUCKY BLOCK" YAZSIN
--  "Secret Lucky Block" yazan her yeri değiştir
-- ════════════════════════════════════════════

local function fixSellLabels()
    for _, desc in ipairs(game:GetDescendants()) do
        if (desc:IsA("TextLabel") or desc:IsA("TextButton")) then
            -- "Secret Lucky Block" → "OG Lucky Block"
            if string.find(desc.Text, "Secret Lucky Block") then
                desc.Text = string.gsub(desc.Text, "Secret Lucky Block", "OG Lucky Block")
                print("[OG v5] Satış yazısı düzeltildi: " .. desc:GetFullName())
            end
            -- "Mythic Lucky Block" → "OG Lucky Block"
            if string.find(desc.Text, "Mythic Lucky Block") then
                desc.Text = string.gsub(desc.Text, "Mythic Lucky Block", "OG Lucky Block")
                print("[OG v5] Satış yazısı düzeltildi: " .. desc:GetFullName())
            end
        end
    end
end

-- Satış ekranı değişikliklerini sürekli izle
game.DescendantAdded:Connect(function(obj)
    task.wait(0.1)
    if (obj:IsA("TextLabel") or obj:IsA("TextButton")) then
        local t = tostring(obj.Text)
        if string.find(t, "Secret Lucky Block") then
            obj.Text = string.gsub(obj.Text, "Secret Lucky Block", "OG Lucky Block")
        end
        if string.find(t, "Mythic Lucky Block") then
            obj.Text = string.gsub(obj.Text, "Mythic Lucky Block", "OG Lucky Block")
        end
    end
end)

-- ════════════════════════════════════════════
--  ASIL MANTIK: BİR GUI İÇİNDE HEM "LUCKY BLOCK"
--  HEM "SECRET" VARSA → O SECRET'İ OG YAP
-- ════════════════════════════════════════════

local function processGui(gui, style)
    local allLabels = {}
    for _, d in ipairs(gui:GetDescendants()) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            table.insert(allLabels, d)
        end
    end

    -- İçinde "Lucky Block" geçen bir label var mı?
    local hasLuckyBlock = false
    for _, lbl in ipairs(allLabels) do
        if string.find(string.lower(lbl.Text), "lucky block") then
            hasLuckyBlock = true
            break
        end
    end

    if not hasLuckyBlock then return end

    -- "Secret" VEYA "Mythic" yazan label'ı bul ve OG yap
    for _, lbl in ipairs(allLabels) do
        local txt = string.lower(string.gsub(lbl.Text, "%s", ""))
        -- Tam eşleşme: "secret" veya "mythic"
        -- Kısmi eşleşme: "mythicluckyblock" gibi tek label olabilir
        if txt == "secret" or txt == "mythic"
            or (string.find(txt, "mythic") and string.find(txt, "lucky"))
        then
            applyOG(lbl, style)
        end
    end
end

local function scanAll(style)
    print("[OG v5] Taranıyor...")
    local count = 0
    for _, desc in ipairs(workspace:GetDescendants()) do
        if desc:IsA("BillboardGui") or desc:IsA("SurfaceGui") or desc:IsA("ScreenGui") then
            processGui(desc, style)
            count = count + 1
        end
    end
    print("[OG v5] " .. count .. " GUI tarandı.")
end

-- ════════════════════════════════════════════
--  YENİ SPAWNI İZLE
-- ════════════════════════════════════════════

local cachedStyle = nil

workspace.DescendantAdded:Connect(function(obj)
    task.wait(0.2)
    if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
        processGui(obj, cachedStyle)
    end
    if (obj:IsA("TextLabel") or obj:IsA("TextButton")) then
        local txt = string.lower(string.gsub(obj.Text, "%s", ""))
        if txt == "secret" or txt == "mythic"
            or (string.find(txt, "mythic") and string.find(txt, "lucky"))
        then
            local parentGui = obj.Parent
            while parentGui and not (parentGui:IsA("BillboardGui") or parentGui:IsA("SurfaceGui")) do
                parentGui = parentGui.Parent
            end
            if parentGui then
                processGui(parentGui, cachedStyle)
            end
        end
    end
end)

-- ════════════════════════════════════════════
--  BAŞLAT
-- ════════════════════════════════════════════

task.wait(1)
cachedStyle = findStrawberryOGStyle()
scanAll(cachedStyle)
fixSellLabels()  -- Satış ekranı yazılarını düzelt

print("[OG v5] ══ Aktif: Beyaz blok + OG Lucky Block satış yazısı ══")
