local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiDieUI"
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 120)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -60)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.15, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Kevin Anti Die"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainFrame

local statusSection = Instance.new("Frame")
statusSection.Size = UDim2.new(1, 0, 0.20, 0)
statusSection.Position = UDim2.new(0, 0, 0.17, 0)
statusSection.BackgroundTransparency = 1
statusSection.Parent = mainFrame

local statusCircle = Instance.new("Frame")
statusCircle.Size = UDim2.new(0, 8, 0, 8)
statusCircle.Position = UDim2.new(0.08, 0, 0.5, -4)
statusCircle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
statusCircle.BorderSizePixel = 0
statusCircle.Parent = statusSection

local statusCircleCorner = Instance.new("UICorner")
statusCircleCorner.CornerRadius = UDim.new(1, 0)
statusCircleCorner.Parent = statusCircle

local statusCircleGlow = Instance.new("Frame")
statusCircleGlow.Size = UDim2.new(0, 16, 0, 16)
statusCircleGlow.Position = UDim2.new(0.08, -4, 0.5, -8)
statusCircleGlow.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
statusCircleGlow.BackgroundTransparency = 0.7
statusCircleGlow.BorderSizePixel = 0
statusCircleGlow.Parent = statusSection

local statusCircleGlowCorner = Instance.new("UICorner")
statusCircleGlowCorner.CornerRadius = UDim.new(1, 0)
statusCircleGlowCorner.Parent = statusCircleGlow

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(0, 40, 0, 14)
statusText.Position = UDim2.new(0.14, 0, 0.5, -7)
statusText.BackgroundTransparency = 1
statusText.Text = "OFF"
statusText.TextColor3 = Color3.fromRGB(255, 80, 80)
statusText.TextSize = 13
statusText.Font = Enum.Font.GothamBold
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusSection

local statusSubText = Instance.new("TextLabel")
statusSubText.Size = UDim2.new(0, 90, 0, 11)
statusSubText.Position = UDim2.new(0.14, 0, 0.7, 0)
statusSubText.BackgroundTransparency = 1
statusSubText.Text = "Click to toggle"
statusSubText.TextColor3 = Color3.fromRGB(150, 100, 100)
statusSubText.TextSize = 9
statusSubText.Font = Enum.Font.Gotham
statusSubText.TextXAlignment = Enum.TextXAlignment.Left
statusSubText.Parent = statusSection

local separator = Instance.new("Frame")
separator.Size = UDim2.new(0.85, 0, 0, 1)
separator.Position = UDim2.new(0.075, 0, 0.40, 0)
separator.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
separator.BackgroundTransparency = 0.5
separator.BorderSizePixel = 0
separator.Parent = mainFrame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.7, 0, 0.17, 0)
toggleButton.Position = UDim2.new(0.15, 0, 0.45, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
toggleButton.BackgroundTransparency = 0.15
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "DISABLE"
toggleButton.TextSize = 11
toggleButton.Font = Enum.Font.GothamBold
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(200, 0, 0)
toggleButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 5)
buttonCorner.Parent = toggleButton

local buttonGlow = Instance.new("Frame")
buttonGlow.Size = UDim2.new(0.7, 6, 0.17, 6)
buttonGlow.Position = UDim2.new(0.15, -3, 0.45, -3)
buttonGlow.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
buttonGlow.BackgroundTransparency = 0.8
buttonGlow.BorderSizePixel = 0
buttonGlow.Parent = mainFrame

local buttonGlowCorner = Instance.new("UICorner")
buttonGlowCorner.CornerRadius = UDim.new(0, 7)
buttonGlowCorner.Parent = buttonGlow

local separator2 = Instance.new("Frame")
separator2.Size = UDim2.new(0.85, 0, 0, 1)
separator2.Position = UDim2.new(0.075, 0, 0.65, 0)
separator2.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
separator2.BackgroundTransparency = 0.5
separator2.BorderSizePixel = 0
separator2.Parent = mainFrame

local keybindSection = Instance.new("Frame")
keybindSection.Size = UDim2.new(1, 0, 0.13, 0)
keybindSection.Position = UDim2.new(0, 0, 0.68, 0)
keybindSection.BackgroundTransparency = 1
keybindSection.Parent = mainFrame

local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(0.2, 0, 1, 0)
keybindLabel.Position = UDim2.new(0.05, 0, 0, 0)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Text = "Keybind"
keybindLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
keybindLabel.TextSize = 10
keybindLabel.Font = Enum.Font.GothamBold
keybindLabel.TextXAlignment = Enum.TextXAlignment.Right
keybindLabel.Parent = keybindSection

local keybindDisplay = Instance.new("TextButton")
keybindDisplay.Size = UDim2.new(0.12, 0, 0.7, 0)
keybindDisplay.Position = UDim2.new(0.28, 0, 0.15, 0)
keybindDisplay.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
keybindDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
keybindDisplay.Text = "G"
keybindDisplay.TextSize = 11
keybindDisplay.Font = Enum.Font.GothamBold
keybindDisplay.BorderSizePixel = 1
keybindDisplay.BorderColor3 = Color3.fromRGB(200, 0, 0)
keybindDisplay.Parent = keybindSection

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 3)
keybindCorner.Parent = keybindDisplay

local changeKeybindBtn = Instance.new("TextButton")
changeKeybindBtn.Size = UDim2.new(0.15, 0, 0.7, 0)
changeKeybindBtn.Position = UDim2.new(0.43, 0, 0.15, 0)
changeKeybindBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
changeKeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
changeKeybindBtn.Text = "CHANGE"
changeKeybindBtn.TextSize = 9
changeKeybindBtn.Font = Enum.Font.GothamBold
changeKeybindBtn.BorderSizePixel = 0
changeKeybindBtn.Parent = keybindSection

local changeKeyCorner = Instance.new("UICorner")
changeKeyCorner.CornerRadius = UDim.new(0, 3)
changeKeyCorner.Parent = changeKeybindBtn

local creditLabel = Instance.new("TextLabel")
creditLabel.Size = UDim2.new(1, 0, 0.08, 0)
creditLabel.Position = UDim2.new(0, 0, 0.84, 0)
creditLabel.BackgroundTransparency = 1
creditLabel.Text = "discord.gg/K92JgMUnCG"
creditLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
creditLabel.TextSize = 12
creditLabel.Font = Enum.Font.GothamBold
creditLabel.TextXAlignment = Enum.TextXAlignment.Center
creditLabel.TextYAlignment = Enum.TextYAlignment.Center
creditLabel.Parent = mainFrame

local discordGlow = Instance.new("Frame")
discordGlow.Size = UDim2.new(0.6, 0, 0.08, 0)
discordGlow.Position = UDim2.new(0.2, 0, 0.84, 0)
discordGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
discordGlow.BackgroundTransparency = 0.9
discordGlow.BorderSizePixel = 0
discordGlow.Parent = mainFrame

local discordGlowCorner = Instance.new("UICorner")
discordGlowCorner.CornerRadius = UDim.new(0, 4)
discordGlowCorner.Parent = discordGlow

local dragging = false
local dragStartPos = Vector2.new()
local dragStartFramePos = UDim2.new()

local function startDrag(input)
    dragging = true
    dragStartPos = input.Position
    dragStartFramePos = mainFrame.Position
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStartPos
        mainFrame.Position = UDim2.new(
            dragStartFramePos.X.Scale,
            dragStartFramePos.X.Offset + delta.X,
            dragStartFramePos.Y.Scale,
            dragStartFramePos.Y.Offset + delta.Y
        )
    end
end

local function endDrag()
    dragging = false
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        startDrag(input)
    end
end)

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        startDrag(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        endDrag()
    end
end)

for _, child in ipairs(mainFrame:GetChildren()) do
    if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("Frame") then
        child.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or
               input.UserInputType == Enum.UserInputType.Touch then
                startDrag(input)
            end
        end)
    end
end

local antiDieActive = false
local antiDieConnections = {}
local animationInProgress = false
local keybind = Enum.KeyCode.G
local waitingForKeybind = false
local pulseLoop = nil

local function startPulse()
    if pulseLoop then pulseLoop:Cancel() end

    pulseLoop = RunService.Heartbeat:Connect(function()
        local transparency = 0.5 + math.sin(os.clock() * 3) * 0.2
        statusCircleGlow.BackgroundTransparency = transparency
    end)
end

startPulse()

local function activateAntiDie(char)
    if not char then
        char = player.Character
    end
    if not char then return {} end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return {} end

    local connections = {}

    hum.BreakJointsOnDeath = false
    hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)

    local healthConnection = hum:GetPropertyChangedSignal("Health"):Connect(function()
        if hum and hum.Parent and hum.Health <= 0 and hum.MaxHealth > 0 then
            hum.Health = hum.MaxHealth
            if hum:GetState() == Enum.HumanoidStateType.Dead then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end)
    table.insert(connections, healthConnection)

    local diedConnection = hum.Died:Connect(function()
        task.wait(0.1)
        local newChar = player.Character
        if newChar and newChar ~= char then
            if antiDieActive then
                task.wait(0.2)
                cleanupAntiDie()
                antiDieConnections = activateAntiDie(newChar)
            end
        end
    end)
    table.insert(connections, diedConnection)

    return connections
end

local function cleanupAntiDie()
    for _, connection in ipairs(antiDieConnections) do
        if connection and connection.Disconnect then
            connection:Disconnect()
        end
    end
    antiDieConnections = {}
end

local function animateToggle(on)
    animationInProgress = true

    if on then

        local buttonColor = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 180, 50)}
        )
        buttonColor:Play()

        local buttonBorder = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BorderColor3 = Color3.fromRGB(0, 255, 50)}
        )
        buttonBorder:Play()

        local buttonGlowColor = TweenService:Create(
            buttonGlow,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 255, 50)}
        )
        buttonGlowColor:Play()

        local circleColor = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 255, 50)}
        )
        circleColor:Play()

        local circleGlowColor = TweenService:Create(
            statusCircleGlow,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 255, 50)}
        )
        circleGlowColor:Play()

        local textColor = TweenService:Create(
            statusText,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(0, 255, 50)}
        )
        textColor:Play()

        local subTextColor = TweenService:Create(
            statusSubText,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(100, 255, 150)}
        )
        subTextColor:Play()

        local borderColor = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BorderColor3 = Color3.fromRGB(0, 255, 50)}
        )
        borderColor:Play()

        local sepColor1 = TweenService:Create(
            separator,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 255, 50)}
        )
        sepColor1:Play()

        local sepColor2 = TweenService:Create(
            separator2,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 255, 50)}
        )
        sepColor2:Play()

        local scaleUp = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0.72, 0, 0.19, 0)}
        )
        scaleUp:Play()

        task.wait(0.15)

        local scaleDown = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0.7, 0, 0.17, 0)}
        )
        scaleDown:Play()

        toggleButton.Text = "ENABLE"
        statusText.Text = "ON"
        statusSubText.Text = "Protection active"

        local pulse1 = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 12, 0, 12)}
        )
        pulse1:Play()

        task.wait(0.1)

        local pulse2 = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 8, 0, 8)}
        )
        pulse2:Play()

        task.wait(0.25)

    else

        local buttonColor = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(180, 0, 0)}
        )
        buttonColor:Play()

        local buttonBorder = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BorderColor3 = Color3.fromRGB(200, 0, 0)}
        )
        buttonBorder:Play()

        local buttonGlowColor = TweenService:Create(
            buttonGlow,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}
        )
        buttonGlowColor:Play()

        local circleColor = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}
        )
        circleColor:Play()

        local circleGlowColor = TweenService:Create(
            statusCircleGlow,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}
        )
        circleGlowColor:Play()

        local textColor = TweenService:Create(
            statusText,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(255, 80, 80)}
        )
        textColor:Play()

        local subTextColor = TweenService:Create(
            statusSubText,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(150, 100, 100)}
        )
        subTextColor:Play()

        local borderColor = TweenService:Create(
            mainFrame,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BorderColor3 = Color3.fromRGB(200, 0, 0)}
        )
        borderColor:Play()

        local sepColor1 = TweenService:Create(
            separator,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}
        )
        sepColor1:Play()

        local sepColor2 = TweenService:Create(
            separator2,
            TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 0, 0)}
        )
        sepColor2:Play()

        local scaleDown = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0.68, 0, 0.15, 0)}
        )
        scaleDown:Play()

        task.wait(0.15)

        local scaleUp = TweenService:Create(
            toggleButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0.7, 0, 0.17, 0)}
        )
        scaleUp:Play()

        toggleButton.Text = "DISABLE"
        statusText.Text = "OFF"
        statusSubText.Text = "Click to toggle"

        local pulse1 = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 12, 0, 12)}
        )
        pulse1:Play()

        task.wait(0.1)

        local pulse2 = TweenService:Create(
            statusCircle,
            TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 8, 0, 8)}
        )
        pulse2:Play()

        task.wait(0.25)
    end

    animationInProgress = false
end

local function toggleAntiDie()
    if animationInProgress then return end

    antiDieActive = not antiDieActive

    if antiDieActive then
        animateToggle(true)
        cleanupAntiDie()
        local char = player.Character
        if char then
            antiDieConnections = activateAntiDie(char)
        else
            player.CharacterAdded:Wait()
            antiDieConnections = activateAntiDie(player.Character)
        end
    else
        animateToggle(false)
        cleanupAntiDie()
    end
end

local function onKeyPress(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == keybind then
        toggleAntiDie()
    end
end

UserInputService.InputBegan:Connect(onKeyPress)

local function changeKeybind()
    if waitingForKeybind then return end

    waitingForKeybind = true
    keybindDisplay.Text = "..."
    keybindDisplay.TextColor3 = Color3.fromRGB(255, 255, 0)

    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            keybind = input.KeyCode
            keybindDisplay.Text = tostring(keybind):gsub("Enum.KeyCode.", "")
            keybindDisplay.TextColor3 = Color3.fromRGB(255, 255, 255)
            waitingForKeybind = false
            connection:Disconnect()
        end
    end)
end

toggleButton.MouseButton1Click:Connect(toggleAntiDie)
changeKeybindBtn.MouseButton1Click:Connect(changeKeybind)

toggleButton.TouchTap:Connect(toggleAntiDie)
changeKeybindBtn.TouchTap:Connect(changeKeybind)

toggleButton.MouseEnter:Connect(function()
    if antiDieActive then
        toggleButton.BackgroundTransparency = 0.05
    else
        toggleButton.BackgroundTransparency = 0.05
    end
end)

toggleButton.MouseLeave:Connect(function()
    if antiDieActive then
        toggleButton.BackgroundTransparency = 0.15
    else
        toggleButton.BackgroundTransparency = 0.15
    end
end)

changeKeybindBtn.MouseEnter:Connect(function()
    changeKeybindBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
end)

changeKeybindBtn.MouseLeave:Connect(function()
    changeKeybindBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
end)

keybindDisplay.MouseEnter:Connect(function()
    keybindDisplay.BackgroundColor3 = Color3.fromRGB(50, 10, 10)
end)

keybindDisplay.MouseLeave:Connect(function()
    keybindDisplay.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
end)

local function onCharacterAdded(char)
    task.wait(0.3)
    if antiDieActive then
        cleanupAntiDie()
        antiDieConnections = activateAntiDie(char)
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

print("leaked by @bu8f on discord")
