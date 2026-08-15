local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CONFIG = {
    DEFAULT_TWEEN_SPEED = 19,
    COLLECT_RADIUS = 8,
    FLING_POWER = 500,
    TP_DURATION = 3,
    AFK_INTERVAL = 60,
    MAGNET_MODE = false,
    MAGNET_RADIUS = 15,
}

local State = {
    isFarming = false,
    isInvisible = false,
    isMinimized = false,
    isDead = false,
    farmSpeed = 50,
    flingActive = false,
    selectedTargets = {},
    currentTween = nil,
    farmingThread = nil,
    flingConnection = nil,
    afkThread = nil,
    magnetActive = false,
}

local function isPlayerAlive(plr)
    if not plr or not plr.Parent then return false end
    local alive = plr:GetAttribute("Alive")
    if alive == nil then
        local char = plr.Character
        if char then alive = char:GetAttribute("Alive") end
    end
    return alive == true
end

local function getAlivePlayers()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and isPlayerAlive(plr) then
            table.insert(list, plr)
        end
    end
    return list
end

local function debugLog(...) end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YunoHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 300)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
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
topBar.Size = UDim2.new(1, 0, 0, 44)
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

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 32, 0, 32)
icon.Position = UDim2.new(0, 10, 0.5, -16)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid:6031097223"
icon.Parent = topBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 1, 0)
title.Position = UDim2.new(0, 48, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔥 Yuno Hub"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextStrokeColor3 = Color3.fromRGB(80, 0, 0)
title.TextStrokeTransparency = 0.5
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -75, 0.5, -15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
minimizeBtn.Text = "−"
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.Parent = topBar
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 10)
minCorner.Parent = minimizeBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = topBar
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = closeBtn

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -44)
contentContainer.Position = UDim2.new(0, 0, 0, 44)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

local separator = Instance.new("Frame")
separator.Size = UDim2.new(0.9, 0, 0, 2)
separator.Position = UDim2.new(0.05, 0, 0.02, 0)
separator.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
separator.BackgroundTransparency = 0.3
separator.BorderSizePixel = 0
separator.Parent = contentContainer

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 28)
statusLabel.Position = UDim2.new(0.05, 0, 0.06, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Statut : Prêt"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = contentContainer

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.4, 0, 0, 28)
speedLabel.Position = UDim2.new(0.05, 0, 0.22, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Vitesse: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentContainer

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 30, 0, 30)
speedMinus.Position = UDim2.new(0.55, 0, 0.21, 0)
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
speedPlus.Position = UDim2.new(0.75, 0, 0.21, 0)
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
startButton.Size = UDim2.new(0.42, 0, 0, 40)
startButton.Position = UDim2.new(0.05, 0, 0.40, 0)
startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
startButton.Text = "▶ START"
startButton.TextColor3 = Color3.new(1, 1, 1)
startButton.TextScaled = true
startButton.Font = Enum.Font.GothamBold
startButton.Parent = contentContainer
local startCorner = Instance.new("UICorner")
startCorner.CornerRadius = UDim.new(0, 12)
startCorner.Parent = startButton

local flingButton = Instance.new("TextButton")
flingButton.Size = UDim2.new(0.42, 0, 0, 40)
flingButton.Position = UDim2.new(0.53, 0, 0.40, 0)
flingButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
flingButton.Text = "🔥 FLING"
flingButton.TextColor3 = Color3.new(1, 1, 1)
flingButton.TextScaled = true
flingButton.Font = Enum.Font.GothamBold
flingButton.Parent = contentContainer
local flingCorner = Instance.new("UICorner")
flingCorner.CornerRadius = UDim.new(0, 12)
flingCorner.Parent = flingButton

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.42, 0, 0, 32)
tpButton.Position = UDim2.new(0.05, 0, 0.60, 0)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
tpButton.Text = "👥 TP Tous (3s)"
tpButton.TextColor3 = Color3.new(1, 1, 1)
tpButton.TextScaled = true
tpButton.Font = Enum.Font.GothamBold
tpButton.Parent = contentContainer
local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 12)
tpCorner.Parent = tpButton

local invisibleBtn = Instance.new("TextButton")
invisibleBtn.Size = UDim2.new(0.42, 0, 0, 32)
invisibleBtn.Position = UDim2.new(0.53, 0, 0.60, 0)
invisibleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
invisibleBtn.Text = "👻 Invisible"
invisibleBtn.TextColor3 = Color3.new(1, 1, 1)
invisibleBtn.TextScaled = true
invisibleBtn.Font = Enum.Font.GothamBold
invisibleBtn.Parent = contentContainer
local invisibleCorner = Instance.new("UICorner")
invisibleCorner.CornerRadius = UDim.new(0, 12)
invisibleCorner.Parent = invisibleBtn

local magnetBtn = Instance.new("TextButton")
magnetBtn.Size = UDim2.new(0.42, 0, 0, 28)
magnetBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
magnetBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
magnetBtn.Text = "🧲 Magnet OFF"
magnetBtn.TextColor3 = Color3.new(1, 1, 1)
magnetBtn.TextScaled = true
magnetBtn.Font = Enum.Font.GothamBold
magnetBtn.Parent = contentContainer
local magnetCorner = Instance.new("UICorner")
magnetCorner.CornerRadius = UDim.new(0, 12)
magnetCorner.Parent = magnetBtn

local afkBtn = Instance.new("TextButton")
afkBtn.Size = UDim2.new(0.42, 0, 0, 28)
afkBtn.Position = UDim2.new(0.53, 0, 0.78, 0)
afkBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
afkBtn.Text = "⏳ Anti-AFK ON"
afkBtn.TextColor3 = Color3.new(1, 1, 1)
afkBtn.TextScaled = true
afkBtn.Font = Enum.Font.GothamBold
afkBtn.Parent = contentContainer
local afkCorner = Instance.new("UICorner")
afkCorner.CornerRadius = UDim.new(0, 12)
afkCorner.Parent = afkBtn

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0, 16)
creditLabel.Position = UDim2.new(0, 0, 1, -18)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "Yuno Hub - by Yuno & Kilasik"
creditLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
creditLabel.TextScaled = true
creditLabel.Font = Enum.Font.GothamSemibold
creditLabel.TextTransparency = 0.3
creditLabel.Parent = contentContainer

local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        local connection
        connection = UserInputService.InputChanged:Connect(function(input2)
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
            end
        end)
    end
end)

local function setupHover(btn, normalColor, hoverColor, specialCondition)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = hoverColor
    end)
    btn.MouseLeave:Connect(function()
        if specialCondition and specialCondition() then
        else
            btn.BackgroundColor3 = normalColor
        end
    end)
end

setupHover(startButton, Color3.fromRGB(200, 30, 30), Color3.fromRGB(230, 50, 50), function() return State.isFarming end)
setupHover(flingButton, Color3.fromRGB(200, 100, 0), Color3.fromRGB(230, 130, 0), function() return State.flingActive end)
setupHover(tpButton, Color3.fromRGB(0, 100, 200), Color3.fromRGB(0, 130, 230))
setupHover(invisibleBtn, Color3.fromRGB(70, 70, 180), Color3.fromRGB(100, 100, 220), function() return State.isInvisible end)
setupHover(magnetBtn, Color3.fromRGB(50, 150, 50), Color3.fromRGB(80, 200, 80), function() return State.magnetActive end)
setupHover(afkBtn, Color3.fromRGB(100, 100, 200), Color3.fromRGB(130, 130, 230))
setupHover(minimizeBtn, Color3.fromRGB(200, 150, 0), Color3.fromRGB(230, 180, 0))
setupHover(closeBtn, Color3.fromRGB(220, 40, 40), Color3.fromRGB(255, 50, 50))

local function toggleMinimize()
    State.isMinimized = not State.isMinimized
    if State.isMinimized then
        mainFrame:TweenSize(UDim2.new(0, 200, 0, 44), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "+"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        contentContainer.Visible = false
        glow.Size = UDim2.new(1.08, 0, 1.12, 0)
        glow.Position = UDim2.new(-0.04, 0, -0.06, 0)
        title.Text = "🔥 Yuno Hub"
        title.Position = UDim2.new(0, 12, 0, 0)
        title.Size = UDim2.new(0.8, 0, 1, 0)
        topCorner.CornerRadius = UDim.new(0, 20)
    else
        mainFrame:TweenSize(UDim2.new(0, 320, 0, 300), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "−"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        contentContainer.Visible = true
        glow.Size = UDim2.new(1.04, 0, 1.04, 0)
        glow.Position = UDim2.new(-0.02, 0, -0.02, 0)
        title.Text = "🔥 Yuno Hub"
        title.Position = UDim2.new(0, 48, 0, 0)
        title.Size = UDim2.new(0.6, 0, 1, 0)
        topCorner.CornerRadius = UDim.new(0, 16)
    end
end

minimizeBtn.MouseButton1Click:Connect(toggleMinimize)

closeBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if stopFarming then stopFarming() end
        if stopFling then stopFling() end
        if stopAntiAFK then stopAntiAFK() end
    end)
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    screenGui:Destroy()
end)

local function updateSpeedDisplay()
    speedLabel.Text = "⚡ Vitesse: " .. tostring(State.farmSpeed)
end

speedMinus.MouseButton1Click:Connect(function()
    State.farmSpeed = math.max(10, State.farmSpeed - 5)
    updateSpeedDisplay()
end)

speedPlus.MouseButton1Click:Connect(function()
    State.farmSpeed = math.min(100, State.farmSpeed + 5)
    updateSpeedDisplay()
end)
local cachedMap = nil
local coinContainer = nil

local function findMap()
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:GetAttribute("MapID") and obj:FindFirstChild("CoinContainer") then
            return obj
        end
    end
    return nil
end

local function updateMapCache()
    local map = findMap()
    if map then
        cachedMap = map
        coinContainer = map:FindFirstChild("CoinContainer")
        debugLog("Map trouvée :", map.Name)
    else
        cachedMap = nil
        coinContainer = nil
        debugLog("Aucune map trouvée.")
    end
end
updateMapCache()

workspace.ChildAdded:Connect(updateMapCache)
workspace.ChildRemoved:Connect(updateMapCache)

local function getNearestCoin()
    if not coinContainer then
        debugLog("CoinContainer introuvable.")
        return nil
    end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        debugLog("HumanoidRootPart introuvable.")
        return nil
    end

    local closest, closestDist = nil, math.huge
    for _, coin in ipairs(coinContainer:GetChildren()) do
        local vis = coin:FindFirstChild("CoinVisual")
        if vis and not vis:GetAttribute("Collected") then
            local dist = (hrp.Position - coin.Position).Magnitude
            if dist < closestDist then
                closest = coin
                closestDist = dist
            end
        end
    end
    return closest
end

local function tweenToCoin(coin)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp or not coin then return end

    if State.currentTween then
        State.currentTween:Cancel()
        State.currentTween = nil
    end

    local distance = (hrp.Position - coin.Position).Magnitude
    local speedFactor = State.farmSpeed / 50
    local tweenTime = math.max(distance / (CONFIG.DEFAULT_TWEEN_SPEED * speedFactor), 0.05)

    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Falling)
    end

    local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
    State.currentTween = tween
    tween:Play()
    tween.Completed:Wait()
    if State.currentTween == tween then
        State.currentTween = nil
    end
end

local function stopFarming()
    State.isFarming = false
    if State.farmingThread then
        task.cancel(State.farmingThread)
        State.farmingThread = nil
    end
    if State.currentTween then
        State.currentTween:Cancel()
        State.currentTween = nil
    end
    startButton.Text = "▶ START"
    startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    statusLabel.Text = "● Statut : Arrêté"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
end

local function startFarming()
    if State.farmingThread then return end

    State.isFarming = true
    startButton.Text = "⏹ STOP"
    startButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    statusLabel.Text = "● Statut : Farm en cours..."
    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)

    State.farmingThread = task.spawn(function()
        while State.isFarming do
            if State.isDead or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
                statusLabel.Text = "● Statut : Attente respawn..."
                statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
                repeat task.wait(0.5) until not State.isDead and player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                statusLabel.Text = "● Statut : Farm en cours..."
                statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                continue
            end

            if State.magnetActive and coinContainer then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, coin in ipairs(coinContainer:GetChildren()) do
                        local vis = coin:FindFirstChild("CoinVisual")
                        if vis and not vis:GetAttribute("Collected") then
                            local dist = (hrp.Position - coin.Position).Magnitude
                            if dist < CONFIG.MAGNET_RADIUS then
                                if dist < CONFIG.COLLECT_RADIUS then
                                    tweenToCoin(coin)
                                end
                            end
                        end
                    end
                end
            end

            local target = getNearestCoin()
            if target then
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (hrp.Position - target.Position).Magnitude
                    if dist < CONFIG.COLLECT_RADIUS then
                        task.wait(0.1)
                    else
                        pcall(function()
                            tweenToCoin(target)
                        end)
                    end
                end

                local vis = target:FindFirstChild("CoinVisual")
                local attempts = 0
                while vis and not vis:GetAttribute("Collected") and vis.Parent and attempts < 10 do
                    task.wait(0.1)
                    attempts = attempts + 1
                    local newTarget = getNearestCoin()
                    if newTarget and newTarget ~= target then
                        break
                    end
                end
            else
                task.wait(0.5)
            end
        end
        stopFarming()
    end)
end

local function toggleFarming()
    if State.isFarming then
        stopFarming()
    else
        startFarming()
    end
end

startButton.MouseButton1Click:Connect(toggleFarming)

local function toggleMagnet()
    State.magnetActive = not State.magnetActive
    if State.magnetActive then
        magnetBtn.Text = "🧲 Magnet ON"
        magnetBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
        statusLabel.Text = "● Statut : Magnet activé"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 200)
    else
        magnetBtn.Text = "🧲 Magnet OFF"
        magnetBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        statusLabel.Text = "● Statut : Magnet désactivé"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

magnetBtn.MouseButton1Click:Connect(toggleMagnet)
local function startFling()
    if State.flingActive then return end
    State.flingActive = true
    flingButton.Text = "⏹ STOP FLING"
    flingButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
    statusLabel.Text = "● Statut : Fling actif"
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)

    State.flingConnection = RunService.Heartbeat:Connect(function()
        if not State.flingActive then return end
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local players = getAlivePlayers()
        for _, target in ipairs(players) do
            local char = target.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local direction = (root.Position - hrp.Position).Unit
                local velocity = direction * CONFIG.FLING_POWER
                root.Velocity = velocity

                local bv = Instance.new("BodyVelocity")
                bv.Velocity = velocity
                bv.MaxForce = Vector3.new(1, 1, 1) * 1e6
                bv.Parent = root
                task.delay(0.1, function()
                    bv:Destroy()
                end)
            end
        end
    end)
end

local function stopFling()
    State.flingActive = false
    if State.flingConnection then
        State.flingConnection:Disconnect()
        State.flingConnection = nil
    end
    flingButton.Text = "🔥 FLING"
    flingButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    statusLabel.Text = "● Statut : Prêt"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
end

local function toggleFling()
    if State.flingActive then
        stopFling()
    else
        startFling()
    end
end

flingButton.MouseButton1Click:Connect(toggleFling)

local function tpEveryone()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then
        statusLabel.Text = "● Erreur : Pas de personnage"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end

    local savedPositions = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and isPlayerAlive(plr) then
            local c = plr.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r then
                savedPositions[plr] = r.CFrame
                r.CFrame = root.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end

    statusLabel.Text = "● Statut : TP tout le monde !"
    statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    task.wait(CONFIG.TP_DURATION)

    for plr, oldCFrame in pairs(savedPositions) do
        local c = plr.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        if r then
            r.CFrame = oldCFrame
        end
    end
    statusLabel.Text = "● Statut : Prêt"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
end

tpButton.MouseButton1Click:Connect(tpEveryone)

local function applyInvisibility(char, invisible)
    if not char then return end
    for _, child in ipairs(char:GetDescendants()) do
        if child:IsA("BasePart") then
            child.Transparency = invisible and 1 or 0
        elseif child:IsA("Accessory") and child:FindFirstChild("Handle") then
            child.Handle.Transparency = invisible and 1 or 0
        end
    end
end

local function toggleInvisibility()
    State.isInvisible = not State.isInvisible
    local char = player.Character
    if char then
        applyInvisibility(char, State.isInvisible)
    end

    if State.isInvisible then
        invisibleBtn.Text = "👁️ Visible"
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        invisibleBtn.Text = "👻 Invisible"
        invisibleBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 180)
    end
end

invisibleBtn.MouseButton1Click:Connect(toggleInvisibility)

local antiAfkActive = false
local afkThread = nil

local function startAntiAFK()
    if antiAfkActive then return end
    antiAfkActive = true
    afkBtn.Text = "⏳ Anti-AFK OFF"
    afkBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)

    afkThread = task.spawn(function()
        while antiAfkActive do
            task.wait(CONFIG.AFK_INTERVAL)
            local char = player.Character
            local humanoid = char and char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
end

local function stopAntiAFK()
    antiAfkActive = false
    if afkThread then
        task.cancel(afkThread)
        afkThread = nil
    end
    afkBtn.Text = "⏳ Anti-AFK ON"
    afkBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 200)
end

local function toggleAntiAFK()
    if antiAfkActive then
        stopAntiAFK()
    else
        startAntiAFK()
    end
end

afkBtn.MouseButton1Click:Connect(toggleAntiAFK)

local function onCharacterAdded(char)
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Humanoid")
    State.isDead = false

    if State.isInvisible then
        applyInvisibility(char, true)
    end

    if State.isFarming then
        statusLabel.Text = "● Statut : Farm en cours..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end

local function onCharacterDied()
    State.isDead = true
    if State.isFarming then
        statusLabel.Text = "● Statut : Mort - attente respawn..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
    if State.currentTween then
        State.currentTween:Cancel()
        State.currentTween = nil
    end
end

local function setupDeathHandler(char)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Died:Connect(onCharacterDied)
    end
end

player.CharacterAdded:Connect(function(char)
    onCharacterAdded(char)
    setupDeathHandler(char)
end)

if player.Character then
    onCharacterAdded(player.Character)
    setupDeathHandler(player.Character)
end

local function updateSpeedDisplay()
    speedLabel.Text = "⚡ Vitesse: " .. tostring(State.farmSpeed)
end
updateSpeedDisplay()
