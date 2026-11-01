--[[
FLASH HUB | STEAL AN EGG
MOBILE EDITION | v1.1.0
UI-first, read-only dashboard.

SETUP:
1. Upload FLASH_HUB_LOGO.png to Roblox as an image/decal.
2. Replace LOGO_IMAGE with your actual rbxassetid:// value.
3. Best supported test environment: LocalScript in StarterPlayerScripts
   inside your own Roblox Studio experience.

This script does not exploit, automate gameplay, teleport, modify movement,
bypass anti-cheat, or manipulate other players/servers.
Game-specific stats are read only when exposed to this client.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then return end

local LOGO_IMAGE = "rbxassetid://0" -- REPLACE WITH YOUR UPLOADED ROBLOX IMAGE ID

local C = {
    bg = Color3.fromRGB(9, 7, 15),
    panel = Color3.fromRGB(17, 13, 27),
    panel2 = Color3.fromRGB(26, 19, 41),
    purple = Color3.fromRGB(160, 82, 255),
    purpleDark = Color3.fromRGB(91, 42, 157),
    white = Color3.fromRGB(246, 241, 255),
    muted = Color3.fromRGB(163, 151, 181),
    green = Color3.fromRGB(75, 220, 145),
    line = Color3.fromRGB(76, 48, 105),
}

local function new(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end
local function round(obj, n)
    new("UICorner", {CornerRadius = UDim.new(0, n or 10)}, obj)
end
local function outline(obj, color, thickness)
    new("UIStroke", {Color = color or C.line, Thickness = thickness or 1, Transparency = 0.2}, obj)
end
local function text(parent, value, pos, size, fontSize, color, font, align)
    return new("TextLabel", {
        BackgroundTransparency = 1, Text = value, Position = pos, Size = size,
        Font = font or Enum.Font.Gotham, TextSize = fontSize or 12,
        TextColor3 = color or C.white, TextXAlignment = align or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center, TextWrapped = true,
    }, parent)
end
local function button(parent, value, pos, size, color, fontSize)
    local b = new("TextButton", {
        Text = value, Position = pos, Size = size, BackgroundColor3 = color or C.panel2,
        TextColor3 = C.white, Font = Enum.Font.GothamSemibold, TextSize = fontSize or 11,
        BorderSizePixel = 0, AutoButtonColor = true,
    }, parent)
    round(b, 8)
    return b
end
local function card(parent, height)
    local f = new("Frame", {
        Size = UDim2.new(1, -8, 0, height), BackgroundColor3 = C.panel,
        BorderSizePixel = 0,
    }, parent)
    round(f, 12)
    outline(f, C.line, 1)
    return f
end
local function tween(obj, duration, props, style)
    local t = TweenService:Create(obj, TweenInfo.new(duration, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local guiParent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function() if gethui then guiParent = gethui() end end)
local previous = guiParent:FindFirstChild("FLASH_HUB_GUI")
if previous then previous:Destroy() end

local gui = new("ScreenGui", {
    Name = "FLASH_HUB_GUI", ResetOnSpawn = false, IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, guiParent)

local scale = new("UIScale", {Scale = 1}, gui)
local function resize()
    local camera = workspace.CurrentCamera
    if camera then
        local v = camera.ViewportSize
        scale.Scale = math.clamp(math.min(v.X / 390, v.Y / 760), 0.72, 1)
    end
end
resize()
if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
end

local main = new("Frame", {
    Name = "MainWindow", AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(390, 760),
    BackgroundColor3 = C.bg, BorderSizePixel = 0,
}, gui)
round(main, 16)
outline(main, C.purple, 2)
new("UIGradient", {
    Color = ColorSequence.new(C.panel, C.bg), Rotation = 25,
}, main)

local header = new("Frame", {
    Size = UDim2.new(1, 0, 0, 58), BackgroundColor3 = Color3.fromRGB(14, 10, 23),
    BorderSizePixel = 0,
}, main)
round(header, 16)
new("Frame", {
    Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(1, 0, 0, 10),
    BackgroundColor3 = Color3.fromRGB(14, 10, 23), BorderSizePixel = 0,
}, header)

local logo = new("ImageLabel", {
    Position = UDim2.fromOffset(9, 7), Size = UDim2.fromOffset(44, 44),
    BackgroundColor3 = C.panel2, Image = LOGO_IMAGE, ScaleType = Enum.ScaleType.Crop,
}, header)
round(logo, 10)
outline(logo, C.purple, 1)

text(header, "FLASH HUB", UDim2.fromOffset(60, 5), UDim2.fromOffset(180, 25),
    22, C.white, Enum.Font.GothamBlack)
text(header, "STEAL AN EGG  /  PERSONAL GAME DASHBOARD",
    UDim2.fromOffset(61, 30), UDim2.fromOffset(230, 15), 9, C.muted, Enum.Font.GothamMedium)

local ready = new("TextLabel", {
    AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -82, 0.5, 0),
    Size = UDim2.fromOffset(72, 22), BackgroundColor3 = Color3.fromRGB(18, 55, 40),
    Text = "● READY", TextColor3 = C.green, Font = Enum.Font.GothamBold,
    TextSize = 9,
}, header)
round(ready, 8)

local minimize = button(header, "—", UDim2.new(1, -72, 0.5, -13), UDim2.fromOffset(26, 26), C.panel2, 18)
local close = button(header, "×", UDim2.new(1, -39, 0.5, -13), UDim2.fromOffset(26, 26), Color3.fromRGB(76, 27, 48), 19)

local nav = new("ScrollingFrame", {
    Name = "MobileNavigation",
    Position = UDim2.fromOffset(8, 66), Size = UDim2.new(1, -16, 0, 48),
    BackgroundColor3 = Color3.fromRGB(13, 10, 21), BorderSizePixel = 0,
    ScrollBarThickness = 2, ScrollBarImageColor3 = C.purple,
    ScrollingDirection = Enum.ScrollingDirection.X,
    AutomaticCanvasSize = Enum.AutomaticSize.X, CanvasSize = UDim2.new(),
}, main)
round(nav, 10)
outline(nav, C.line, 1)
new("UIPadding", {PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7),
    PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 7)}, nav)
new("UIListLayout", {Padding = UDim.new(0, 6), FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center}, nav)

local workspaceFrame = new("Frame", {
    Position = UDim2.fromOffset(10, 122), Size = UDim2.new(1, -20, 1, -132),
    BackgroundTransparency = 1,
}, main)
local pageTitle = text(workspaceFrame, "Dashboard", UDim2.fromOffset(2, 0),
    UDim2.new(1, -4, 0, 28), 18, C.white, Enum.Font.GothamBold)
local pageDescription = text(workspaceFrame, "ข้อมูลบัญชีและสถานะที่ Client อ่านได้",
    UDim2.fromOffset(3, 27), UDim2.new(1, -6, 0, 17), 9, C.muted)
local body = new("ScrollingFrame", {
    Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 1, -48),
    BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.purple, AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, workspaceFrame)
new("UIListLayout", {Padding = UDim.new(0, 9), SortOrder = Enum.SortOrder.LayoutOrder}, body)

local function clearBody()
    for _, child in ipairs(body:GetChildren()) do
        if not child:IsA("UIListLayout") then child:Destroy() end
    end
end
local function heading(value)
    text(body, value, UDim2.new(), UDim2.new(1, -8, 0, 21), 11, C.white, Enum.Font.GothamBold)
end
local function readStat(candidates)
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    for _, name in ipairs(candidates) do
        local obj = stats and stats:FindFirstChild(name)
        if not obj then obj = LocalPlayer:FindFirstChild(name) end
        if obj and (obj:IsA("StringValue") or obj:IsA("NumberValue") or obj:IsA("IntValue")) then
            return tostring(obj.Value)
        end
        local attr = LocalPlayer:GetAttribute(name)
        if attr ~= nil then return tostring(attr) end
    end
    return "N/A"
end
local function statTile(parent, x, y, icon, caption, value)
    local f = new("Frame", {
        Position = UDim2.new(x, 6, y, 6), Size = UDim2.new(0.5, -12, 0, 68),
        BackgroundColor3 = C.panel2, BorderSizePixel = 0,
    }, parent)
    round(f, 10)
    text(f, icon, UDim2.fromOffset(10, 8), UDim2.fromOffset(30, 30), 20, C.purple, Enum.Font.GothamBold)
    text(f, caption, UDim2.fromOffset(43, 7), UDim2.new(1, -50, 0, 19), 9, C.muted, Enum.Font.GothamBold)
    text(f, value, UDim2.fromOffset(43, 28), UDim2.new(1, -50, 0, 32), 17, C.white, Enum.Font.GothamBold)
end

local function renderDashboard()
    clearBody()
    local profile = card(body, 126)
    local avatar = new("ImageLabel", {
        Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(82, 82),
        BackgroundColor3 = C.panel2, ScaleType = Enum.ScaleType.Crop,
    }, profile)
    round(avatar, 12)
    outline(avatar, C.purple, 1)
    task.spawn(function()
        local ok, image = pcall(function()
            return Players:GetUserThumbnailAsync(LocalPlayer.UserId,
                Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
        end)
        if ok and avatar.Parent then avatar.Image = image end
    end)
    text(profile, LocalPlayer.DisplayName, UDim2.fromOffset(106, 10),
        UDim2.new(1, -116, 0, 24), 18, C.white, Enum.Font.GothamBold)
    text(profile, "@" .. LocalPlayer.Name, UDim2.fromOffset(107, 35),
        UDim2.new(1, -118, 0, 18), 11, C.muted)
    text(profile, "USER ID  •  " .. tostring(LocalPlayer.UserId), UDim2.fromOffset(107, 56),
        UDim2.new(1, -118, 0, 18), 10, C.muted)
    text(profile, "●  LOCAL PLAYER", UDim2.fromOffset(107, 77),
        UDim2.new(1, -118, 0, 18), 10, C.green, Enum.Font.GothamBold)

    heading("PLAYER STATS  /  LIVE READ")
    local stats = card(body, 158)
    statTile(stats, 0, 0, "⚡", "SPEED", readStat({"Speed"}))
    statTile(stats, 0.5, 0, "＄", "MONEY", readStat({"Money", "Cash", "Coins"}))
    statTile(stats, 0, 0.5, "🐾", "PET COUNT", readStat({"PetCount", "PetsCount"}))
    statTile(stats, 0.5, 0.5, "🥚", "EGG COUNT", readStat({"EggCount", "EggsCount"}))

    heading("DATA INTEGRITY")
    local notice = card(body, 76)
    text(notice, "ข้อมูลที่เกมไม่เปิดให้ Client อ่านจะแสดง N/A",
        UDim2.fromOffset(14, 9), UDim2.new(1, -28, 0, 23), 12, C.white, Enum.Font.GothamBold)
    text(notice, "ไม่มีตัวเลขสมมติ และไม่ดึงข้อมูลบัญชีของผู้เล่นอื่น",
        UDim2.fromOffset(14, 36), UDim2.new(1, -28, 0, 22), 10, C.muted)
end

local menuItems = {
    {"⌂", "Dashboard", "ภาพรวมบัญชีและข้อมูลที่อ่านได้"},
    {"🥚", "Egg Finder", "หน้าค้นหาไข่"},
    {"⌕", "Egg Hunter", "เครื่องมือดูข้อมูลไข่"},
    {"▤", "Server Finder", "ค้นหาเซิร์ฟเวอร์สาธารณะ"},
    {"♧", "Low Player", "ตัวกรองจำนวนผู้เล่น"},
    {"↗", "Value Hunter", "ค้นหาตามมูลค่า"},
    {"⌂", "Farm", "ข้อมูลฟาร์ม"},
    {"✚", "Auto Collect", "ระบบอัตโนมัติ"},
    {"✦", "Event Center", "อีเวนต์ที่ตรวจสอบได้"},
    {"▣", "Inventory", "ข้อมูลกระเป๋า"},
    {"▦", "Value Calculator", "เครื่องคำนวณมูลค่า"},
    {"➤", "Teleport & Route", "เส้นทางและตำแหน่ง"},
    {"⚡", "Movement", "ข้อมูลการเคลื่อนที่"},
    {"☷", "Quest Center", "ข้อมูลเควสต์"},
    {"♧", "Notifications", "การแจ้งเตือน"},
    {"◷", "Activity Log", "บันทึกกิจกรรม"},
    {"⚙", "Settings", "ตั้งค่า HUB"},
}
local selected
local function showPage(name, desc)
    pageTitle.Text = name
    pageDescription.Text = desc
    if name == "Dashboard" then renderDashboard() return end
    clearBody()
    local info = card(body, 112)
    text(info, "หน้านี้เตรียม UI ไว้แล้ว", UDim2.fromOffset(15, 13),
        UDim2.new(1, -30, 0, 24), 14, C.white, Enum.Font.GothamBold)
    text(info, "ยังไม่มีแหล่งข้อมูลที่ยืนยันได้สำหรับฟังก์ชันนี้ จึงไม่แสดงข้อมูลปลอมหรืออ้างว่าทำงานแล้ว",
        UDim2.fromOffset(15, 42), UDim2.new(1, -30, 0, 52), 11, C.muted)
    local statusCard = card(body, 62)
    text(statusCard, "STATUS: N/A  •  WAITING FOR VERIFIED GAME DATA",
        UDim2.fromOffset(14, 10), UDim2.new(1, -28, 0, 25), 10, C.purple, Enum.Font.GothamBold)
end

for i, item in ipairs(menuItems) do
    local b = button(nav, item[1] .. "  " .. item[2],
        UDim2.new(), UDim2.fromOffset(112, 32), i == 1 and C.purpleDark or C.panel, 9)
    b.LayoutOrder = i
    b.TextXAlignment = Enum.TextXAlignment.Center
    b.MouseButton1Click:Connect(function()
        if selected then tween(selected, 0.12, {BackgroundColor3 = C.panel}) end
        selected = b
        tween(b, 0.12, {BackgroundColor3 = C.purpleDark})
        showPage(item[2], item[3])
    end)
    if i == 1 then selected = b end
end
renderDashboard()

-- Minimized floating logo.
local float = new("ImageButton", {
    Name = "FLASH_HUB_Floating", AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 18, 0.5, 0), Size = UDim2.fromOffset(54, 54),
    BackgroundColor3 = C.panel, Image = LOGO_IMAGE, ScaleType = Enum.ScaleType.Crop,
    Visible = false,
}, gui)
round(float, 16)
outline(float, C.purple, 2)

local function minimizeWindow()
    tween(main, 0.18, {Size = UDim2.fromOffset(0, 0)}).Completed:Connect(function()
        main.Visible = false
        float.Visible = true
    end)
end
local function restoreWindow()
    float.Visible = false
    main.Visible = true
    main.Size = UDim2.fromOffset(0, 0)
    tween(main, 0.22, {Size = UDim2.fromOffset(390, 760)}, Enum.EasingStyle.Back)
end
minimize.MouseButton1Click:Connect(minimizeWindow)
float.MouseButton1Click:Connect(restoreWindow)
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Drag main window from the header; drag floating logo when minimized.
local function makeDraggable(handle, target)
    local active, startInput, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            active, startInput, startPos = true, input.Position, target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then active = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if active and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startInput
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
makeDraggable(header, main)
makeDraggable(float, float)

task.spawn(function()
    while gui.Parent do
        task.wait(3)
        if main.Visible and pageTitle.Text == "Dashboard" then renderDashboard() end
    end
end)

print("[FLASH HUB MOBILE] Loaded. Set LOGO_IMAGE to your uploaded Roblox image asset.")
