local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KevinTradeScript"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 8, 8)
MainFrame.BorderColor3 = Color3.fromRGB(180, 40, 40)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
MainFrame.Size = UDim2.new(0, 320, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Selectable = true
MainFrame.ClipsDescendants = true

local Shadow = Instance.new("ImageLabel")
Shadow.Parent = MainFrame
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(-0.08, 0, -0.08, 0)
Shadow.Size = UDim2.new(1.16, 0, 1.16, 0)
Shadow.Image = "rbxassetid://5028857086"
Shadow.ImageColor3 = Color3.fromRGB(200, 30, 30)
Shadow.ImageTransparency = 0.5
Shadow.ZIndex = 0

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local InnerBorder = Instance.new("Frame")
InnerBorder.Parent = MainFrame
InnerBorder.BackgroundTransparency = 1
InnerBorder.BorderColor3 = Color3.fromRGB(200, 50, 50)
InnerBorder.BorderSizePixel = 1
InnerBorder.Position = UDim2.new(0.005, 0, 0.005, 0)
InnerBorder.Size = UDim2.new(0.99, 0, 0.99, 0)
local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 10)
InnerCorner.Parent = InnerBorder

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 12, 12)
TitleBar.BackgroundTransparency = 0
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleLine = Instance.new("Frame")
TitleLine.Parent = TitleBar
TitleLine.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
TitleLine.BorderSizePixel = 0
TitleLine.Position = UDim2.new(0, 0, 1, -2)
TitleLine.Size = UDim2.new(1, 0, 0, 2)
local LineGlow = Instance.new("ImageLabel")
LineGlow.Parent = TitleLine
LineGlow.BackgroundTransparency = 1
LineGlow.Position = UDim2.new(0, 0, -2, 0)
LineGlow.Size = UDim2.new(1, 0, 0, 6)
LineGlow.Image = "rbxassetid://5028857086"
LineGlow.ImageColor3 = Color3.fromRGB(200, 40, 40)
LineGlow.ImageTransparency = 0.6

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Kevin Trade Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextStrokeColor3 = Color3.fromRGB(100, 0, 0)
TitleLabel.TextStrokeTransparency = 0.3

local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Parent = TitleBar
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
MinBtn.BorderColor3 = Color3.fromRGB(180, 40, 40)
MinBtn.BorderSizePixel = 1
MinBtn.Position = UDim2.new(1, -55, 0.5, -12)
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
MinBtn.TextSize = 20
local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 4)
MinCorner.Parent = MinBtn
MinBtn.ZIndex = 2

local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
CloseBtn.BorderColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.BorderSizePixel = 1
CloseBtn.Position = UDim2.new(1, -28, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
CloseBtn.TextSize = 16
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn
CloseBtn.ZIndex = 2

MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 25, 25)}):Play()
end)
MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 15, 15)}):Play()
end)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(160, 20, 20)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 15, 15)}):Play()
end)

local minimized = false
local freezeEnabled = false
local forceEnabled = false

local contentFrames = {}

local function CreateSlidingToggle(parent, labelText, initialValue, callback)

    local container = Instance.new("Frame")
    container.Parent = parent
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(1, 0, 1, 0)
    table.insert(contentFrames, container)

    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0.5, -10)
    label.Size = UDim2.new(0.6, 0, 0, 20)
    label.Font = Enum.Font.GothamBold
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 220, 220)
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    table.insert(contentFrames, label)

    local toggleBg = Instance.new("Frame")
    toggleBg.Name = "ToggleBg"
    toggleBg.Parent = container
    toggleBg.BackgroundColor3 = Color3.fromRGB(50, 15, 15)
    toggleBg.BorderColor3 = Color3.fromRGB(180, 40, 40)
    toggleBg.BorderSizePixel = 1
    toggleBg.Position = UDim2.new(0.7, 0, 0.5, -14)
    toggleBg.Size = UDim2.new(0, 50, 0, 28)
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0)
    bgCorner.Parent = toggleBg
    table.insert(contentFrames, toggleBg)

    local glow = Instance.new("ImageLabel")
    glow.Parent = toggleBg
    glow.BackgroundTransparency = 1
    glow.Position = UDim2.new(-0.3, 0, -0.3, 0)
    glow.Size = UDim2.new(1.6, 0, 1.6, 0)
    glow.Image = "rbxassetid://5028857086"
    glow.ImageTransparency = 1
    glow.ZIndex = 0
    table.insert(contentFrames, glow)

    local knob = Instance.new("Frame")
    knob.Name = "Knob"
    knob.Parent = toggleBg
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.BorderSizePixel = 0
    knob.Position = UDim2.new(0, 3, 0, 3)
    knob.Size = UDim2.new(0, 22, 0, 22)
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob
    table.insert(contentFrames, knob)

    local knobGlow = Instance.new("ImageLabel")
    knobGlow.Parent = knob
    knobGlow.BackgroundTransparency = 1
    knobGlow.Position = UDim2.new(-0.5, 0, -0.5, 0)
    knobGlow.Size = UDim2.new(2, 0, 2, 0)
    knobGlow.Image = "rbxassetid://5028857086"
    knobGlow.ImageTransparency = 0.8
    knobGlow.ZIndex = 0
    table.insert(contentFrames, knobGlow)

    local clickBtn = Instance.new("TextButton")
    clickBtn.Parent = toggleBg
    clickBtn.BackgroundTransparency = 1
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.ZIndex = 2
    clickBtn.Text = ""
    table.insert(contentFrames, clickBtn)

    local isOn = initialValue or false

    local function UpdateToggle(newState)
        isOn = newState
        if isOn then

            TweenService:Create(toggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(40, 180, 40)
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                BorderColor3 = Color3.fromRGB(100, 255, 100)
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                Position = UDim2.new(1, -25, 0, 3),
                BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            }):Play()
            TweenService:Create(glow, TweenInfo.new(0.4), {
                ImageTransparency = 0.4,
                ImageColor3 = Color3.fromRGB(100, 255, 100)
            }):Play()
        else

            TweenService:Create(toggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                BackgroundColor3 = Color3.fromRGB(50, 15, 15)
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                BorderColor3 = Color3.fromRGB(180, 40, 40)
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0, 3, 0, 3),
                BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
            TweenService:Create(glow, TweenInfo.new(0.4), {
                ImageTransparency = 1
            }):Play()
        end
        if callback then
            callback(isOn)
        end
    end

    clickBtn.MouseButton1Click:Connect(function()
        UpdateToggle(not isOn)
    end)

    clickBtn.MouseEnter:Connect(function()
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {
            BorderColor3 = isOn and Color3.fromRGB(150, 255, 150) or Color3.fromRGB(200, 80, 80)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            BackgroundColor3 = isOn and Color3.fromRGB(150, 255, 150) or Color3.fromRGB(220, 220, 220)
        }):Play()
    end)
    clickBtn.MouseLeave:Connect(function()
        TweenService:Create(toggleBg, TweenInfo.new(0.2), {
            BorderColor3 = isOn and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(180, 40, 40)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            BackgroundColor3 = isOn and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(200, 200, 200)
        }):Play()
    end)

    UpdateToggle(initialValue or false)

    return container, function()
        return isOn
    end, UpdateToggle
end

local FreezeBtn = Instance.new("Frame")
FreezeBtn.Name = "FreezeBtn"
FreezeBtn.Parent = MainFrame
FreezeBtn.BackgroundTransparency = 1
FreezeBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
FreezeBtn.Size = UDim2.new(0.9, 0, 0, 50)
table.insert(contentFrames, FreezeBtn)

local freezeToggle, getFreezeState, setFreezeState = CreateSlidingToggle(
    FreezeBtn,
    "Freeze Trade",
    false,
    function(state)
        freezeEnabled = state
        print("Freeze Trade: " .. (state and "ON" or "OFF"))
    end
)

local ForceBtn = Instance.new("Frame")
ForceBtn.Name = "ForceBtn"
ForceBtn.Parent = MainFrame
ForceBtn.BackgroundTransparency = 1
ForceBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
ForceBtn.Size = UDim2.new(0.9, 0, 0, 50)
table.insert(contentFrames, ForceBtn)

local forceToggle, getForceState, setForceState = CreateSlidingToggle(
    ForceBtn,
    "Force Accept",
    false,
    function(state)
        forceEnabled = state
        print("Force Accept: " .. (state and "ON" or "OFF"))
    end
)

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Name = "DiscordLabel"
DiscordLabel.Parent = MainFrame
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Position = UDim2.new(0, 0, 0.80, 0)
DiscordLabel.Size = UDim2.new(1, 0, 0, 25)
DiscordLabel.Font = Enum.Font.Gotham
DiscordLabel.Text = "discord.gg/K92JgMUnCG"
DiscordLabel.TextColor3 = Color3.fromRGB(200, 120, 120)
DiscordLabel.TextSize = 14
DiscordLabel.TextStrokeColor3 = Color3.fromRGB(50, 0, 0)
DiscordLabel.TextStrokeTransparency = 0.3
table.insert(contentFrames, DiscordLabel)

DiscordLabel.MouseEnter:Connect(function()
    TweenService:Create(DiscordLabel, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(255, 180, 180),
        TextSize = 16
    }):Play()
end)
DiscordLabel.MouseLeave:Connect(function()
    TweenService:Create(DiscordLabel, TweenInfo.new(0.2), {
        TextColor3 = Color3.fromRGB(200, 120, 120),
        TextSize = 14
    }):Play()
end)

MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then

        for _, obj in ipairs(contentFrames) do
            obj.Visible = false
        end

        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 320, 0, 40)
        }):Play()
        MinBtn.Text = "+"
    else

        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 320, 0, 280)
        }):Play()

        wait(0.1)
        for _, obj in ipairs(contentFrames) do
            obj.Visible = true
        end
        MinBtn.Text = "−"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()

    local shrinkTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    shrinkTween:Play()
    shrinkTween.Completed:Connect(function()
        ScreenGui.Enabled = false

        MainFrame.Size = UDim2.new(0, 320, 0, 280)
        MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
    end)
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        if ScreenGui.Enabled then

            local shrinkTween = TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            shrinkTween:Play()
            shrinkTween.Completed:Connect(function()
                ScreenGui.Enabled = false
                MainFrame.Size = UDim2.new(0, 320, 0, 280)
                MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
            end)
        else

            ScreenGui.Enabled = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 320, 0, 280),
                Position = UDim2.new(0.5, -160, 0.5, -140)
            }):Play()
        end
    end
end)
