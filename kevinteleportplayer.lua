local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TeleportGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 380)
frame.Position = UDim2.new(0.5, -140, 0.5, -190)
frame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
frame.BackgroundTransparency = 0.15
frame.Visible = true
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0.05, 0)

local borderGlow = Instance.new("Frame", frame)
borderGlow.Size = UDim2.new(1, 10, 1, 10)
borderGlow.Position = UDim2.new(0, -5, 0, -5)
borderGlow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
borderGlow.BackgroundTransparency = 0.8
borderGlow.BorderSizePixel = 0
Instance.new("UICorner", borderGlow).CornerRadius = UDim.new(0.05, 0)

local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0.05, 0)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "KEVIN TELEPORTER"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Text = "-"
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -68, 0, 4)
minBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextScaled = true
minBtn.BorderSizePixel = 0
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0.2, 0)

minBtn.MouseEnter:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    }):Play()
end)
minBtn.MouseLeave:Connect(function()
    TweenService:Create(minBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    }):Play()
end)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -35, 0, 4)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0.2, 0)

closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    }):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    }):Play()
end)

local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(1, -20, 1, -50)
scroll.Position = UDim2.new(0, 10, 0, 45)
scroll.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
scroll.BackgroundTransparency = 0.5
scroll.ScrollBarThickness = 5
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ClipsDescendants = true
Instance.new("UICorner", scroll).CornerRadius = UDim.new(0.03, 0)

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local playerButtons = {}
local minimized = false

local function createPlayerButton(player)
    if player == LocalPlayer then return end
    if playerButtons[player] then return end

    local card = Instance.new("Frame", scroll)
    card.Size = UDim2.new(1, 0, 0, 35)
    card.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0.05, 0)

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(50, 0, 0)
        }):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 0, 0)
        }):Play()
    end)

    local avatar = Instance.new("Frame", card)
    avatar.Size = UDim2.new(0, 22, 0, 22)
    avatar.Position = UDim2.new(0, 5, 0.5, -11)
    avatar.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
    avatar.BorderSizePixel = 0
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(0.5, 0)

    local nameLabel = Instance.new("TextLabel", card)
    nameLabel.Size = UDim2.new(0.6, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 32, 0, 0)
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextScaled = true
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local tpButton = Instance.new("TextButton", card)
    tpButton.Size = UDim2.new(0, 48, 0, 24)
    tpButton.Position = UDim2.new(1, -54, 0.5, -12)
    tpButton.Text = "TP"
    tpButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.Font = Enum.Font.SourceSansBold
    tpButton.TextScaled = true
    tpButton.BorderSizePixel = 0
    Instance.new("UICorner", tpButton).CornerRadius = UDim.new(0.1, 0)

    tpButton.MouseEnter:Connect(function()
        TweenService:Create(tpButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        }):Play()
    end)
    tpButton.MouseLeave:Connect(function()
        TweenService:Create(tpButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        }):Play()
    end)

    tpButton.MouseButton1Click:Connect(function()
        local target = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if target then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.CFrame + Vector3.new(0, 3, 0)

                local feedback = Instance.new("TextLabel", frame)
                feedback.Size = UDim2.new(1, -40, 0, 22)
                feedback.Position = UDim2.new(0, 20, 0, 45)
                feedback.Text = "âœ… Teleported to " .. player.Name
                feedback.TextColor3 = Color3.fromRGB(0, 255, 0)
                feedback.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
                feedback.BackgroundTransparency = 0.5
                feedback.Font = Enum.Font.SourceSans
                feedback.TextScaled = true
                Instance.new("UICorner", feedback).CornerRadius = UDim.new(0.05, 0)
                task.wait(2)
                feedback:Destroy()
            end
        end
    end)

    playerButtons[player] = card
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
end

local function removePlayerButton(player)
    if playerButtons[player] then
        playerButtons[player]:Destroy()
        playerButtons[player] = nil
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    createPlayerButton(player)
end

Players.PlayerAdded:Connect(createPlayerButton)
Players.PlayerRemoving:Connect(removePlayerButton)

TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.15,
    Size = UDim2.new(0, 280, 0, 380)
}):Play()

local function minimizeGUI()
    if minimized then

        frame.Visible = true
        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 280, 0, 380),
            BackgroundTransparency = 0.15
        }):Play()
        minBtn.Text = "-"
        minimized = false
    else

        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 280, 0, 35),
            BackgroundTransparency = 0.5
        }):Play()
        task.wait(0.3)
        minBtn.Text = "+"
        minimized = true
    end
end

local function closeGUI()
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.4)
    frame:Destroy()
end

minBtn.MouseButton1Click:Connect(minimizeGUI)

closeBtn.MouseButton1Click:Connect(closeGUI)
