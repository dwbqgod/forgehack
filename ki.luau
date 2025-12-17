local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local VirtualInputManager
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local parentGui = CoreGui
if gethui and type(gethui) == "function" then parentGui = gethui() end

local ASSET_FOLDER = "TheForgeAssets"
if makefolder and isfolder and not isfolder(ASSET_FOLDER) then
    pcall(function() makefolder(ASSET_FOLDER) end)
end

local LOADING_DURATION = 1.5

local THEME = {
    MainBG = Color3.fromHex("#0B0F19"),
    SidebarBG = Color3.fromHex("#050810"),
    Stroke = Color3.fromHex("#283246"),
    TextWhite = Color3.fromHex("#FFFFFF"),
    TextGray = Color3.fromHex("#96A0B4"),
    Accent = Color3.fromHex("#DC143C"),
    ItemBG = Color3.fromHex("#141923")
}

local COLOR_NAMES = {
    ["#DC143C"] = "Crimson",
    ["#00FF00"] = "Lime Green",
    ["#00FFFF"] = "Sky Blue",
    ["#FF00FF"] = "Pink",
    ["#FFFF00"] = "Yellow",
    ["#FFA500"] = "Orange",
    ["#8A2BE2"] = "Violet",
    ["#00FF7F"] = "Spring"
}

local function GetAsset(url, fileName)
    if not (isfile and writefile and getcustomasset and game.HttpGet) then return url end
    local filePath = ASSET_FOLDER .. "/" .. fileName
    if not isfile(filePath) then
        local success, content = pcall(function() return game:HttpGet(url) end)
        if success and content then
            pcall(function() writefile(filePath, content) end)
        else
            return url
        end
    end
    local success, asset = pcall(function() return getcustomasset(filePath) end)
    return success and asset or url
end

local AVATAR_URL = "https://lolikon.su/static/media/avatars/dwbq.png"
local avatarAsset = GetAsset(AVATAR_URL, "avatar.png")
local LOADING_BG_URL = "https://lolikon.su/static/media/rhack/frames/frame10.png"
local loadingBgAsset = GetAsset(LOADING_BG_URL, "loading_bg.png")

local function Rounded(obj, px)
    local c = Instance.new("UICorner", obj)
    c.CornerRadius = UDim.new(0, px)
    return c
end

local function Stroke(obj, color, thickness)
    local s = Instance.new("UIStroke", obj)
    s.Color = color or THEME.Stroke
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

-- Основной конфиг
local Config = {
    AutoFarm = false,
    MobType = "Zombie",
    FarmSpeed = 80,
    FlySpeed = 100,
    IsFlyingToMine = false,
    HideMobile = false,
    OreEspEnabled = false,
    SelectedOre = "Pebble"
}

-- Функция для получения реального имени без mesh ID
local function GetRealName(obj)
    local tags = CollectionService:GetTags(obj)
    if #tags > 0 then
        return table.concat(tags, ", ")
    end
    
    local nameAttr = obj:GetAttribute("Name") or obj:GetAttribute("ItemName")
    if nameAttr then
        return tostring(nameAttr)
    end

    return obj.Name
end

-- Логика Wallhack (ESP)
local function UpdateOreESP()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Highlight") and obj.Name == "OreESP" then
            obj:Destroy()
        end
    end

    if not Config.OreEspEnabled then return end

    local rocks = Workspace:FindFirstChild("Rocks")
    if not rocks then return end

    local modelsToHighlight = {}
    for _, obj in pairs(rocks:GetDescendants()) do
        if obj:IsA("BasePart") then
            local model = obj:FindFirstAncestorWhichIsA("Model")
            if model and GetRealName(model) == Config.SelectedOre then
                modelsToHighlight[model] = true
            end
        end
    end

    for model in pairs(modelsToHighlight) do
        local hl = Instance.new("Highlight")
        hl.Name = "OreESP"
        hl.FillColor = Color3.new(1, 0, 0)
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.FillTransparency = 0.4
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Adornee = model
        hl.Parent = model
    end
end

-- Loading Screen
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "TheForgeLoading"
LoadingGui.Parent = parentGui
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
LoadingGui.IgnoreGuiInset = true

local LoadingBG = Instance.new("Frame", LoadingGui)
LoadingBG.Size = UDim2.new(1, 0, 1, 0)
LoadingBG.BackgroundColor3 = Color3.new(0, 0, 0)

local LoadingImage = Instance.new("ImageLabel", LoadingBG)
LoadingImage.Size = UDim2.new(1, 0, 1, 0)
LoadingImage.BackgroundTransparency = 1
LoadingImage.Image = loadingBgAsset
LoadingImage.ScaleType = Enum.ScaleType.Crop

local ProgressFrame = Instance.new("Frame", LoadingBG)
ProgressFrame.Size = UDim2.new(0.6, 0, 0.04, 0)
ProgressFrame.Position = UDim2.new(0.2, 0, 0.9, 0)
ProgressFrame.BackgroundColor3 = THEME.ItemBG
Rounded(ProgressFrame, 10)

local ProgressFill = Instance.new("Frame", ProgressFrame)
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = THEME.Accent
Rounded(ProgressFill, 10)

local ProgressText = Instance.new("TextLabel", LoadingBG)
ProgressText.Size = UDim2.new(0.6, 0, 0.05, 0)
ProgressText.Position = UDim2.new(0.2, 0, 0.82, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = "Loading... 0%"
ProgressText.TextColor3 = Color3.new(1, 1, 1)
ProgressText.Font = Enum.Font.GothamBold
ProgressText.TextSize = 28

task.spawn(function()
    local startTime = tick()
    while tick() - startTime < LOADING_DURATION do
        local progress = (tick() - startTime) / LOADING_DURATION
        ProgressFill.Size = UDim2.new(progress, 0, 1, 0)
        ProgressText.Text = "Loading... " .. math.floor(progress * 100) .. "%"
        task.wait()
    end
    ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    ProgressText.Text = "Loaded!"
    task.wait(0.3)
    LoadingGui:Destroy()

    if parentGui:FindFirstChild("TheForgeNAHUI") then
        parentGui.TheForgeNAHUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TheForgeNAHUI"
    ScreenGui.Parent = parentGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true

    local function MakeDraggable(frame, handle)
        handle = handle or frame
        local dragging, dragInput, dragStart, startPos
        handle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        handle.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                TweenService:Create(frame, TweenInfo.new(0.05), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
            end
        end)
    end

    local FloatBtn = Instance.new("ImageButton", ScreenGui)
    FloatBtn.Name = "FloatToggle"
    FloatBtn.Size = UDim2.new(0, 60, 0, 60)
    FloatBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
    FloatBtn.BackgroundColor3 = THEME.SidebarBG
    FloatBtn.Image = avatarAsset
    FloatBtn.AutoButtonColor = false
    Rounded(FloatBtn, 60)
    Stroke(FloatBtn, THEME.Accent, 2)
    MakeDraggable(FloatBtn)

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 550, 0, 340)
    Main.Position = UDim2.new(0.5, -275, 0.5, -170)
    Main.BackgroundColor3 = THEME.MainBG
    Main.Visible = false
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.ClipsDescendants = true 
    Rounded(Main, 12)
    Stroke(Main, THEME.Stroke, 2)
    MakeDraggable(Main)

    local Overlay = Instance.new("Frame", Main)
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 0.3
    Overlay.ZIndex = 1
    Rounded(Overlay, 12)

    local MainBGImage = Instance.new("ImageLabel", Main)
    MainBGImage.Size = UDim2.new(1, 0, 1, 0)
    MainBGImage.Image = avatarAsset
    MainBGImage.ScaleType = Enum.ScaleType.Crop
    MainBGImage.ImageTransparency = 0.6
    MainBGImage.BackgroundTransparency = 1
    Rounded(MainBGImage, 12)

    local CloseBtn = Instance.new("TextButton", Main)
    CloseBtn.Size = UDim2.new(0, 40, 0, 40)
    CloseBtn.Position = UDim2.new(1, -45, 0, 5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 28
    CloseBtn.TextColor3 = THEME.TextGray
    CloseBtn.ZIndex = 50

    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BackgroundColor3 = THEME.SidebarBG
    Sidebar.BackgroundTransparency = 0.15
    Sidebar.BorderSizePixel = 0
    Sidebar.ZIndex = 10

    local Header = Instance.new("Frame", Sidebar)
    Header.Size = UDim2.new(1, 0, 0, 85)
    Header.BackgroundTransparency = 1
    Header.ZIndex = 13

    local Avatar = Instance.new("ImageLabel", Header)
    Avatar.Size = UDim2.new(0, 40, 0, 40)
    Avatar.Position = UDim2.new(0, 15, 0, 15)
    Avatar.Image = avatarAsset
    Avatar.BackgroundColor3 = THEME.SidebarBG
    Avatar.ZIndex = 14
    Rounded(Avatar, 40)
    Stroke(Avatar, THEME.Stroke, 1)

    local Title = Instance.new("TextLabel", Header)
    Title.Text = "ПОТУЖНИЙ ЧІТ"
    Title.Position = UDim2.new(0, 65, 0, 18)
    Title.Size = UDim2.new(0, 90, 0, 16)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 13
    Title.TextColor3 = THEME.TextWhite
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 14

    local SubTitle = Instance.new("TextLabel", Header)
    SubTitle.Text = "NAHUI"
    SubTitle.Position = UDim2.new(0, 65, 0, 36)
    SubTitle.Size = UDim2.new(0, 90, 0, 10)
    SubTitle.Font = Enum.Font.GothamBlack
    SubTitle.TextSize = 10
    SubTitle.TextColor3 = THEME.Accent
    SubTitle.BackgroundTransparency = 1
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.ZIndex = 14

    local Credits = Instance.new("TextLabel", Header)
    Credits.Text = "by dwbq"
    Credits.Position = UDim2.new(0, 15, 0, 65)
    Credits.Size = UDim2.new(1, -30, 0, 12)
    Credits.Font = Enum.Font.GothamBold
    Credits.TextSize = 10
    Credits.TextColor3 = Color3.fromRGB(255, 255, 255)
    Credits.BackgroundTransparency = 1
    Credits.TextXAlignment = Enum.TextXAlignment.Left
    Credits.ZIndex = 15

    task.spawn(function()
        while Credits and Credits.Parent do
            local t = tick() * 2
            Credits.TextColor3 = Color3.fromHSV((t % 5)/5, 0.8, 1)
            task.wait(0.05)
        end
    end)

    local TabHolder = Instance.new("ScrollingFrame", Sidebar)
    TabHolder.Size = UDim2.new(1, -20, 1, -85)
    TabHolder.Position = UDim2.new(0, 10, 0, 85)
    TabHolder.BackgroundTransparency = 1
    TabHolder.ScrollBarThickness = 0
    TabHolder.ZIndex = 13
    TabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolder.ScrollingDirection = Enum.ScrollingDirection.Y
    TabHolder.ElasticBehavior = Enum.ElasticBehavior.Never

    local TabList = Instance.new("UIListLayout", TabHolder)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 4)

    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -160, 1, 0)
    Content.Position = UDim2.new(0, 160, 0, 0)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = true
    Content.ZIndex = 10

    local PageTitle = Instance.new("TextLabel", Content)
    PageTitle.Size = UDim2.new(1, -40, 0, 40)
    PageTitle.Position = UDim2.new(0, 20, 0, 10)
    PageTitle.BackgroundTransparency = 1
    PageTitle.Font = Enum.Font.GothamBold
    PageTitle.TextSize = 18
    PageTitle.TextColor3 = THEME.TextWhite
    PageTitle.TextXAlignment = Enum.TextXAlignment.Left
    PageTitle.ZIndex = 15

    local pages = {}
    local currentTab = nil

    local function SwitchTab(name)
        if currentTab == name then return end
        if currentTab and pages[currentTab] then
            pages[currentTab].Page.Visible = false
            TweenService:Create(pages[currentTab].Btn.ActiveBG, TweenInfo.new(0.2), {Size = UDim2.new(0, 4, 0, 16), BackgroundTransparency = 1}):Play()
            pages[currentTab].Btn.Title.TextColor3 = THEME.TextGray
        end
        if pages[name] then
            pages[name].Page.Visible = true
            TweenService:Create(pages[name].Btn.ActiveBG, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(1, -16, 1, 0), BackgroundTransparency = 0.1}):Play()
            pages[name].Btn.Title.TextColor3 = THEME.TextWhite
            PageTitle.Text = name .. " Menu"
            currentTab = name
        end
    end

    local function CreateTab(name)
        local btn = Instance.new("TextButton", TabHolder)
        btn.Name = name
        btn.Size = UDim2.new(1, 0, 0, 38)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 20

        local activeBG = Instance.new("Frame", btn)
        activeBG.Name = "ActiveBG"
        activeBG.Size = UDim2.new(0, 4, 0, 16)
        activeBG.Position = UDim2.new(0, 8, 0, 0)
        activeBG.BackgroundColor3 = THEME.Accent
        activeBG.BackgroundTransparency = 1
        activeBG.ZIndex = 19
        Rounded(activeBG, 6)

        local lbl = Instance.new("TextLabel", btn)
        lbl.Name = "Title"
        lbl.Size = UDim2.new(1, -30, 1, 0)
        lbl.Position = UDim2.new(0, 20, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextColor3 = THEME.TextGray
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 21

        local page = Instance.new("ScrollingFrame", Content)
        page.Name = name .. "Page"
        page.Size = UDim2.new(1, -20, 1, -60)
        page.Position = UDim2.new(0, 10, 0, 50)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = THEME.Stroke
        page.Visible = false
        page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.ScrollingDirection = Enum.ScrollingDirection.Y
        page.ElasticBehavior = Enum.ElasticBehavior.Never
        page.ZIndex = 20

        local layout = Instance.new("UIListLayout", page)
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local pad = Instance.new("UIPadding", page)
        pad.PaddingBottom = UDim.new(0, 10)
        pad.PaddingLeft = UDim.new(0, 5)
        pad.PaddingRight = UDim.new(0, 15)

        pages[name] = {Btn = btn, Page = page}

        btn.MouseButton1Click:Connect(function()
            SwitchTab(name)
        end)

        return page
    end

    local function CreateSlider(parent, text, min, max, default, callback)
        local f = Instance.new("Frame", parent)
        f.Size = UDim2.new(1, 0, 0, 42)
        f.BackgroundTransparency = 1
        f.ZIndex = 22

        local lbl = Instance.new("TextLabel", f)
        lbl.Text = text
        lbl.Size = UDim2.new(0, 100, 1, 0)
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextColor3 = THEME.TextGray
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
        lbl.ZIndex = 23

        local track = Instance.new("Frame", f)
        track.Size = UDim2.new(1, -150, 0, 4)
        track.Position = UDim2.new(0, 100, 0.5, -2)
        track.BackgroundColor3 = THEME.ItemBG
        track.ZIndex = 23
        Rounded(track, 2)

        local fill = Instance.new("Frame", track)
        fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
        fill.BackgroundColor3 = THEME.Accent
        fill.ZIndex = 24
        Rounded(fill, 2)

        local grad = Instance.new("UIGradient", fill)
        grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 90)), ColorSequenceKeypoint.new(1, THEME.Accent)}

        local knob = Instance.new("Frame", fill)
        knob.Size = UDim2.new(0, 12, 0, 12)
        knob.AnchorPoint = Vector2.new(0.5, 0.5)
        knob.Position = UDim2.new(1, 0, 0.5, 0)
        knob.BackgroundColor3 = THEME.TextWhite
        knob.ZIndex = 25
        Rounded(knob, 12)

        local knobStroke = Instance.new("UIStroke", knob)
        knobStroke.Color = THEME.Accent
        knobStroke.Thickness = 2
        knobStroke.Transparency = 0.5

        local val = Instance.new("TextLabel", f)
        val.Text = tostring(default)
        val.Size = UDim2.new(0, 40, 1, 0)
        val.Position = UDim2.new(1, -40, 0, 0)
        val.Font = Enum.Font.GothamBold
        val.TextColor3 = THEME.TextWhite
        val.TextSize = 12
        val.BackgroundTransparency = 1
        val.ZIndex = 23

        local dragging = false
        local function update(input)
            local p = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local v = math.floor(min + (max-min)*p)
            TweenService:Create(fill, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Size = UDim2.new(p, 0, 1, 0)}):Play()
            val.Text = tostring(v)
            if callback then callback(v) end
        end

        track.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 16, 0, 16)}):Play()
                TweenService:Create(knobStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
                update(i)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                dragging = false
                TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 12, 0, 12)}):Play()
                TweenService:Create(knobStroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                update(i)
            end
        end)
    end

    local function CreateToggle(parent, text, default, callback)
        local f = Instance.new("Frame", parent)
        f.Size = UDim2.new(1, 0, 0, 36)
        f.BackgroundTransparency = 1
        f.ZIndex = 22

        local lbl = Instance.new("TextLabel", f)
        lbl.Text = text
        lbl.Size = UDim2.new(1, -60, 1, 0)
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextColor3 = THEME.TextGray
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
        lbl.ZIndex = 23

        local btn = Instance.new("TextButton", f)
        btn.Size = UDim2.new(0, 42, 0, 22)
        btn.Position = UDim2.new(1, -45, 0.5, -11)
        btn.BackgroundColor3 = default and THEME.Accent or THEME.ItemBG
        btn.Text = ""
        btn.AutoButtonColor = false
        btn.ZIndex = 23
        Rounded(btn, 12)
        Stroke(btn, THEME.Stroke, 1)

        local knob = Instance.new("Frame", btn)
        knob.Size = UDim2.new(0, 16, 0, 16)
        knob.Position = default and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        knob.BackgroundColor3 = THEME.TextWhite
        knob.ZIndex = 24
        Rounded(knob, 8)

        local on = default
        btn.MouseButton1Click:Connect(function()
            on = not on
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = on and THEME.Accent or THEME.ItemBG}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = on and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)}):Play()
            if callback then callback(on) end
        end)
    end

    local function CreateDropdown(parent, text, options, default, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(1, 0, 0, 40)
        container.BackgroundTransparency = 1
        container.ClipsDescendants = true
        container.ZIndex = 25

        local lbl = Instance.new("TextLabel", container)
        lbl.Text = text
        lbl.Size = UDim2.new(0, 100, 0, 40)
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextColor3 = THEME.TextGray
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundTransparency = 1
        lbl.ZIndex = 26

        local main = Instance.new("TextButton", container)
        main.Size = UDim2.new(1, -100, 0, 30)
        main.Position = UDim2.new(0, 100, 0, 5)
        main.BackgroundColor3 = THEME.ItemBG
        main.Text = "  " .. (COLOR_NAMES[default] or tostring(default))
        main.TextColor3 = THEME.TextWhite
        main.Font = Enum.Font.GothamBold
        main.TextSize = 12
        main.TextXAlignment = Enum.TextXAlignment.Left
        main.AutoButtonColor = false
        main.ZIndex = 26
        Rounded(main, 6)
        Stroke(main, THEME.Stroke, 1)

        local arrow = Instance.new("TextLabel", main)
        arrow.Text = "v"
        arrow.Size = UDim2.new(0, 20, 1, 0)
        arrow.Position = UDim2.new(1, -25, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.TextColor3 = THEME.TextGray
        arrow.Font = Enum.Font.GothamBold
        arrow.ZIndex = 27

        local list = Instance.new("Frame", container)
        list.Size = UDim2.new(1, -100, 0, 0)
        list.Position = UDim2.new(0, 100, 0, 40)
        list.BackgroundColor3 = THEME.ItemBG
        list.ZIndex = 30
        list.ClipsDescendants = true
        Rounded(list, 6)
        Stroke(list, THEME.Stroke, 1)

        local ll = Instance.new("UIListLayout", list)
        ll.SortOrder = Enum.SortOrder.LayoutOrder

        local open = false
        main.MouseButton1Click:Connect(function()
            open = not open
            local h = open and (#options * 30) or 0
            TweenService:Create(container, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, open and (40 + h) or 40)}):Play()
            TweenService:Create(list, TweenInfo.new(0.3), {Size = UDim2.new(1, -100, 0, h)}):Play()
            TweenService:Create(arrow, TweenInfo.new(0.3), {Rotation = open and 180 or 0}):Play()
        end)

        for _, opt in ipairs(options) do
            local b = Instance.new("TextButton", list)
            b.Size = UDim2.new(1, 0, 0, 30)
            b.BackgroundTransparency = 1
            b.Text = "  " .. (COLOR_NAMES[opt] or tostring(opt))
            
            if type(opt) == "string" and string.sub(opt, 1, 1) == "#" then
                b.TextColor3 = Color3.fromHex(opt)
            else
                b.TextColor3 = THEME.TextGray
            end
            
            b.Font = Enum.Font.GothamBold
            b.TextSize = 12
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.ZIndex = 31
            b.MouseButton1Click:Connect(function()
                main.Text = "  " .. (COLOR_NAMES[opt] or tostring(opt))
                open = false
                TweenService:Create(container, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                TweenService:Create(list, TweenInfo.new(0.3), {Size = UDim2.new(1, -100, 0, 0)}):Play()
                TweenService:Create(arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                if callback then callback(opt) end
            end)
        end
    end

    local function CreateButton(parent, text, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.BackgroundColor3 = THEME.Accent
        btn.Text = text
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = THEME.TextWhite
        btn.TextSize = 14
        btn.AutoButtonColor = false
        btn.ZIndex = 22
        Rounded(btn, 6)
        btn.MouseButton1Click:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.05), {Size = UDim2.new(0.98, 0, 0, 38)}):Play()
            task.wait(0.05)
            TweenService:Create(btn, TweenInfo.new(0.05), {Size = UDim2.new(1, 0, 0, 40)}):Play()
            if callback then callback() end
        end)
    end

    local function UpdateTheme(newAccent)
        THEME.Accent = newAccent
        for _, obj in pairs(ScreenGui:GetDescendants()) do
            if obj:IsA("Frame") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
                if obj.BackgroundColor3 == Color3.fromHex("#DC143C") or obj.Name == "ActiveBG" then
                    obj.BackgroundColor3 = newAccent
                end
            elseif obj:IsA("UIStroke") then
                if obj.Color == Color3.fromHex("#DC143C") then
                    obj.Color = newAccent
                end
            elseif obj:IsA("UIGradient") then
                local kp = obj.Color.Keypoints
                if #kp >= 2 and kp[2].Value == Color3.fromHex("#DC143C") then
                    obj.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,60,90)),
                        ColorSequenceKeypoint.new(1, newAccent)
                    }
                end
            end
        end
        SubTitle.TextColor3 = newAccent
        TabHolder.ScrollBarImageColor3 = newAccent
    end

    -- Создание вкладок
    local tabs = {"Farm", "Wallhack", "Teleport", "LocalPlayer", "Misc", "Settings"}
    for _, n in ipairs(tabs) do CreateTab(n) end

    -- Вкладка Farm
    local FarmPage = pages["Farm"].Page
    CreateDropdown(FarmPage, "Mob Type", {"Zombie", "Brute Zombie", "Delver Zombie", "EliteZombie"}, "Zombie", function(v) Config.MobType = v end)
    CreateSlider(FarmPage, "Farm Speed", 30, 200, 80, function(v) Config.FarmSpeed = v end)
    CreateToggle(FarmPage, "Auto Farm Mobs", false, function(v) Config.AutoFarm = v end)

    -- Вкладка Wallhack
    local WhPage = pages["Wallhack"].Page
    local ores = {"Pebble", "Rock", "Boulder", "BasaltRock", "BasaltCore", "BasaltVein", "VolcanicRock", "CrystalNode", "CrimsonCrystal", "CyanCrystal", "EarthCrystal", "LightCrystal", "VioletCrystal", "LuckyBlock"}
    CreateToggle(WhPage, "Enable Ore ESP", false, function(v) 
        Config.OreEspEnabled = v 
        UpdateOreESP() 
    end)
    CreateDropdown(WhPage, "Select Ore", ores, "Pebble", function(v) 
        Config.SelectedOre = v 
        if Config.OreEspEnabled then UpdateOreESP() end 
    end)

    -- Вкладка Teleport
    local TpPage = pages["Teleport"].Page
    CreateSlider(TpPage, "Fly Speed", 50, 300, 100, function(v) Config.FlySpeed = v end)
    CreateButton(TpPage, "Fly to Mine (Noclip)", function()
        if Config.IsFlyingToMine then Config.IsFlyingToMine = false return end
        local minePos = Vector3.new(79.5, -14.3, -361.8)
        Config.IsFlyingToMine = true
        task.spawn(function()
            while Config.IsFlyingToMine and LocalPlayer.Character do
                local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if not HRP then break end
                local dist = (HRP.Position - minePos).Magnitude
                if dist < 10 then
                    Config.IsFlyingToMine = false
                    if HRP:FindFirstChild("MineVelocity") then HRP.MineVelocity:Destroy() end
                    if HRP:FindFirstChild("MineGyro") then HRP.MineGyro:Destroy() end
                    break
                end
                local bv = HRP:FindFirstChild("MineVelocity") or Instance.new("BodyVelocity", HRP)
                bv.Name = "MineVelocity"
                bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bv.Velocity = (minePos - HRP.Position).Unit * Config.FlySpeed
                local bg = HRP:FindFirstChild("MineGyro") or Instance.new("BodyGyro", HRP)
                bg.Name = "MineGyro"
                bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                bg.CFrame = CFrame.new(HRP.Position, minePos)
                task.wait()
            end
        end)
    end)

    -- Вкладка Misc
    local MiscPage = pages["Misc"].Page
    CreateToggle(MiscPage, "Hide Mobile Controls", false, function(v) Config.HideMobile = v end)

    -- Вкладка Settings
    local SettingsPage = pages["Settings"].Page
    local themeColors = {"#DC143C", "#00FF00", "#00FFFF", "#FF00FF", "#FFFF00", "#FFA500", "#8A2BE2", "#00FF7F"}
    CreateDropdown(SettingsPage, "Theme Accent", themeColors, "#DC143C", function(hex)
        UpdateTheme(Color3.fromHex(hex))
    end)

    -- Вспомогательные циклы
    task.spawn(function()
        while true do
            if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("TouchGui") then
                LocalPlayer.PlayerGui.TouchGui.Enabled = not Config.HideMobile
            end
            task.wait(0.5)
        end
    end)

    -- Обновление ESP при появлении новых руд
    Workspace.DescendantAdded:Connect(function(d)
        if Config.OreEspEnabled then
            task.wait(0.5)
            UpdateOreESP()
        end
    end)

    RunService.Stepped:Connect(function()
        if (Config.AutoFarm or Config.IsFlyingToMine) and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum and Config.AutoFarm then
                hum.PlatformStand = true
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and Config.AutoFarm then
                hrp.RotVelocity = Vector3.zero
            end
        end
    end)

    -- Главный цикл Farm
    task.spawn(function()
        while true do
            if Config.AutoFarm and LocalPlayer.Character then
                local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
                if HRP and Hum and Hum.Health > 0 then
                    Hum.AutoRotate = false
                    local target = nil
                    local dist = math.huge
                    local Living = Workspace:FindFirstChild("Living")
                    if Living then
                        for _, mob in pairs(Living:GetChildren()) do
                            if string.find(mob.Name, Config.MobType) and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                                local mag = (HRP.Position - mob.HumanoidRootPart.Position).Magnitude
                                if mag < dist then
                                    dist = mag
                                    target = mob
                                end
                            end
                        end
                    end
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        local mobRoot = target.HumanoidRootPart
                        local targetPos = mobRoot.Position - Vector3.new(0, 2, 0)
                        local bv = HRP:FindFirstChild("FarmVelocity") or Instance.new("BodyVelocity", HRP)
                        bv.Name = "FarmVelocity"
                        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                        bv.Velocity = (targetPos - HRP.Position).Unit * Config.FarmSpeed
                        local bg = HRP:FindFirstChild("FarmGyro") or Instance.new("BodyGyro", HRP)
                        bg.Name = "FarmGyro"
                        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                        bg.CFrame = CFrame.new(HRP.Position, mobRoot.Position)
                        if Camera then
                            Camera.CFrame = CFrame.new(Camera.CFrame.Position, mobRoot.Position)
                        end
                        if (HRP.Position - mobRoot.Position).Magnitude < 10 then
                            local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                            if not tool then
                                local backpackTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if backpackTool then
                                    Hum:EquipTool(backpackTool)
                                    task.wait(0.2)
                                end
                            else
                                tool:Activate()
                                if VirtualInputManager then
                                    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                                    VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 1)
                                    task.wait()
                                    VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 1)
                                end
                            end
                        end
                    else
                        if HRP:FindFirstChild("FarmVelocity") then HRP.FarmVelocity:Destroy() end
                        if HRP:FindFirstChild("FarmGyro") then HRP.FarmGyro:Destroy() end
                        Hum.AutoRotate = true
                        Hum.PlatformStand = false
                    end
                end
            end
            task.wait()
        end
    end)

    local function OpenMenu()
        Main.Visible = true
        Main.AnchorPoint = Vector2.new(0.5, 0.5)
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
        Main.Size = UDim2.new(0.3, 0, 0.3, 0)
        Main.BackgroundTransparency = 0.4
        TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 550, 0, 340), BackgroundTransparency = 0 }):Play()
        TweenService:Create(FloatBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0,0,0,0)}):Play()
        task.delay(0.3, function() FloatBtn.Visible = false end)
    end

    local function CloseMenu()
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Size = UDim2.new(0.2, 0, 0.2, 0), BackgroundTransparency = 0.6 }):Play()
        task.delay(0.3, function()
            Main.Visible = false
            Main.Size = UDim2.new(0, 550, 0, 340)
            Main.BackgroundTransparency = 0
            FloatBtn.Visible = true
            FloatBtn.Size = UDim2.new(0,0,0,0)
            TweenService:Create(FloatBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, 60, 0, 60) }):Play()
        end)
    end

    FloatBtn.MouseButton1Click:Connect(OpenMenu)
    CloseBtn.MouseButton1Click:Connect(CloseMenu)
    SwitchTab("Farm")

    print("ПОТУЖНИЙ ЧІТ Loaded")
end)