local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2FarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 210)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -105)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 16)
uiCorner.Parent = mainFrame

local glow = Instance.new("Frame")
glow.Size = UDim2.new(1.04, 0, 1.04, 0)
glow.Position = UDim2.new(-0.02, 0, -0.02, 0)
glow.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
glow.BackgroundTransparency = 0.6
glow.BorderSizePixel = 0
glow.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 18)
glowCorner.Parent = glow

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 42)
topBar.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 16)
topCorner.Parent = topBar

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 30, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 10, 10))
})
gradient.Parent = topBar

local umbrella = Instance.new("ImageLabel")
umbrella.Size = UDim2.new(0, 32, 0, 32)
umbrella.Position = UDim2.new(0, 12, 0.5, -16)
umbrella.BackgroundTransparency = 1
umbrella.Image = "rbxassetid:6031097223"
umbrella.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.5, 0, 1, 0)
title.Position = UDim2.new(0, 52, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MM2 Farm"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextStrokeColor3 = Color3.fromRGB(80, 0, 0)
title.TextStrokeTransparency = 0.5
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -73, 0.5, -15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = topBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 10)
minimizeCorner.Parent = minimizeBtn

minimizeBtn.MouseEnter:Connect(function()
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(230, 180, 0)
end)
minimizeBtn.MouseLeave:Connect(function()
    if not isMinimized then
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    else
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
end)

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -42)
contentContainer.Position = UDim2.new(0, 0, 0, 42)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0.03, 0)
line.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
line.BackgroundTransparency = 0.3
line.BorderSizePixel = 0
line.Parent = contentContainer

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 28)
statusLabel.Position = UDim2.new(0.05, 0, 0.08, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Status: Ready!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = contentContainer

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.4, 0, 0, 28)
speedLabel.Position = UDim2.new(0.05, 0, 0.28, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Speed: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentContainer

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 30, 0, 30)
speedMinus.Position = UDim2.new(0.55, 0, 0.27, 0)
speedMinus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedMinus.Text = "−"
speedMinus.TextColor3 = Color3.new(1,1,1)
speedMinus.TextScaled = true
speedMinus.Font = Enum.Font.GothamBold
speedMinus.Parent = contentContainer
local speedMinusCorner = Instance.new("UICorner")
speedMinusCorner.CornerRadius = UDim.new(0, 8)
speedMinusCorner.Parent = speedMinus

local speedPlus = Instance.new("TextButton")
speedPlus.Size = UDim2.new(0, 30, 0, 30)
speedPlus.Position = UDim2.new(0.75, 0, 0.27, 0)
speedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.new(1,1,1)
speedPlus.TextScaled = true
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Parent = contentContainer
local speedPlusCorner = Instance.new("UICorner")
speedPlusCorner.CornerRadius = UDim.new(0, 8)
speedPlusCorner.Parent = speedPlus

local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.42, 0, 0, 44)
startButton.Position = UDim2.new(0.05, 0, 0.55, 0)
startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
startButton.Text = "▶ START"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextScaled = true
startButton.Font = Enum.Font.GothamBold
startButton.Parent = contentContainer

local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 12)
startCorner.Parent = startButton

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 20, 20))
})
btnGradient.Parent = startButton

startButton.MouseEnter:Connect(function()
    startButton.BackgroundColor3 = Color3.fromRGB(230, 50, 50)
end)
startButton.MouseLeave:Connect(function()
    if isFarming then
        startButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    else
        startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    end
end)

local invisibleBtn = Instance.new("TextButton")
invisibleBtn.Size = UDim2.new(0.42, 0, 0, 44)
invisibleBtn.Position = UDim2.new(0.53, 0, 0.55, 0)
invisibleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
invisibleBtn.Text = "👻 Invisible"
invisibleBtn.TextColor3 = Color3.new(1,1,1)
invisibleBtn.TextScaled = true
invisibleBtn.Font = Enum.Font.GothamBold
invisibleBtn.Parent = contentContainer
local invisibleCorner = Instance.new("UICorner")
invisibleCorner.CornerRadius = UDim.new(0, 12)
invisibleCorner.Parent = invisibleBtn

invisibleBtn.MouseEnter:Connect(function()
    invisibleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 220)
end)
invisibleBtn.MouseLeave:Connect(function()
    invisibleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
end)

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0, 14)
creditLabel.Position = UDim2.new(0, 0, 1, -18)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "yuno le boss"
creditLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
creditLabel.TextScaled = true
creditLabel.Font = Enum.Font.GothamSemibold
creditLabel.TextTransparency = 0.3
creditLabel.Parent = contentContainer

local farmSpeed = 50
local isInvisible = false
local isFarming = false
local farmingConnection = nil
local isMinimized = false
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        if not isMinimized then
            mainFrame:TweenSize(UDim2.new(0, 255, 0, 205), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end

        local connection
        connection = game:GetService("UserInputService").InputChanged:Connect(function(input2)
            if dragging and (input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch) then
                local delta = input2.Position - dragStart
                mainFrame.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                connection:Disconnect()
                if not isMinimized then
                    mainFrame:TweenSize(UDim2.new(0, 260, 0, 210), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                end
            end
        end)
    end
end)

local TweenService = game:GetService("TweenService")
local LP = game.Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")
local Humanoid = Char:WaitForChild("Humanoid")

local function GetMap()
    while true do
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:GetAttribute("MapID") and obj:FindFirstChild("CoinContainer") then
                return obj
            end
        end
        task.wait()
    end
end

local function getNearest()
    local map = GetMap()
    local closest, dist = nil, math.huge
    for _, coin in ipairs(map.CoinContainer:GetChildren()) do
        local v = coin:FindFirstChild("CoinVisual")
        if v and not v:GetAttribute("Collected") then
            local d = (HRP.Position - coin.Position).Magnitude
            if d < dist then
                closest = coin
                dist = d
            end
        end
    end
    return closest
end

local function tp(hp)
    Humanoid:ChangeState(11)
    local d = (HRP.Position - hp.Position).Magnitude
    local speedFactor = farmSpeed / 50
    local tweenTime = d / (25 * speedFactor)
    tweenTime = math.max(tweenTime, 0.05)
    local t = TweenService:Create(HRP, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = hp.CFrame})
    t:Play()
    t.Completed:Wait()
end

local function startFarming()
    if farmingConnection then return end

    farmingConnection = task.spawn(function()
        while isFarming do
            local target = getNearest()
            if target and LP:GetAttribute("Alive") then
                tp(target)
                local v = target:FindFirstChild("CoinVisual")
                while v and not v:GetAttribute("Collected") and v.Parent and isFarming do
                    if not LP:GetAttribute("Alive") then break end
                    local n = getNearest()
                    if n and n ~= target then break end
                    task.wait()
                end
            else
                task.wait(0.5)
            end
        end
    end)
end

local function stopFarming()
    isFarming = false
    if farmingConnection then
        farmingConnection = nil
    end
end

local function toggleFarming()
    isFarming = not isFarming

    if isFarming then
        startButton.Text = "⏹ STOP"
        startButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
        statusLabel.Text = "● Status: Farming..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        game:GetService("TweenService"):Create(statusLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(100, 255, 100)}):Play()
        startFarming()
    else
        startButton.Text = "▶ START"
        startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        statusLabel.Text = "● Status: Stopped"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        game:GetService("TweenService"):Create(statusLabel, TweenInfo.new(0.3), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        stopFarming()
    end
end

local function toggleMinimize()
    isMinimized = not isMinimized

    if isMinimized then

        mainFrame:TweenSize(UDim2.new(0, 200, 0, 42), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "+"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        minimizeBtn.TextSize = 24

        contentContainer.Visible = false

        umbrella.Visible = false

        glow.Size = UDim2.new(1.08, 0, 1.12, 0)
        glow.Position = UDim2.new(-0.04, 0, -0.06, 0)

        title.Text = "Yuno farm"
        title.Position = UDim2.new(0, 12, 0, 0)
        title.Size = UDim2.new(0.8, 0, 1, 0)
        title.TextScaled = true

        topCorner.CornerRadius = UDim.new(0, 20)

    else

        mainFrame:TweenSize(UDim2.new(0, 260, 0, 210), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "−"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        minimizeBtn.TextSize = 18

        contentContainer.Visible = true

        umbrella.Visible = true

        glow.Size = UDim2.new(1.04, 0, 1.04, 0)
        glow.Position = UDim2.new(-0.02, 0, -0.02, 0)

        title.Text = "MM2 Farm"
        title.Position = UDim2.new(0, 52, 0, 0)
        title.Size = UDim2.new(0.5, 0, 1, 0)
        title.TextScaled = true

        topCorner.CornerRadius = UDim.new(0, 16)
    end
end

minimizeBtn.MouseButton1Click:Connect(toggleMinimize)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    stopFarming()
    screenGui:Destroy()
end)

startButton.MouseButton1Click:Connect(toggleFarming)

LP.CharacterAdded:Connect(function(char)
    Char = char
    HRP = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
end)

local function updateSpeedDisplay()
    speedLabel.Text = "⚡ Speed: " .. tostring(farmSpeed)
end

speedMinus.MouseButton1Click:Connect(function()
    farmSpeed = math.max(10, farmSpeed - 5)
    updateSpeedDisplay()
end)

speedPlus.MouseButton1Click:Connect(function()
    farmSpeed = math.min(100, farmSpeed + 5)
    updateSpeedDisplay()
end)

local function toggleInvisibility()
    isInvisible = not isInvisible
    local char = LP.Character
    if not char then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = isInvisible and 1 or 0
        elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
            part.Handle.Transparency = isInvisible and 1 or 0
        end
    end
    if isInvisible then
        char:SetAttribute("Invisible", true)
        invisibleBtn.Text = "👁️ Visible"
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        char:SetAttribute("Invisible", false)
        invisibleBtn.Text = "👻 Invisible"
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
    end
end

invisibleBtn.MouseButton1Click:Connect(toggleInvisibility)

LP.CharacterAdded:Connect(function(char)
    task.wait(0.2)
    if isInvisible then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            elseif part:IsA("Accessory") and part:FindFirstChild("Handle") then
                part.Handle.Transparency = 1
            end
        end
        char:SetAttribute("Invisible", true)
        invisibleBtn.Text = "👁️ Visible"
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    end
end)
