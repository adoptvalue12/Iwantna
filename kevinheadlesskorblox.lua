spawn(function()

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")

    local originalTransparencies = {}

    local oldGui = playerGui:FindFirstChild("KevinSelectorGui")
    if oldGui then oldGui:Destroy() end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KevinSelectorGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 1, -60)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    toggleButton.Text = "K"
    toggleButton.TextColor3 = Color3.fromRGB(255, 50, 50)
    toggleButton.TextSize = 24
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.BorderSizePixel = 0
    toggleButton.Visible = true
    toggleButton.Parent = screenGui

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleButton

    local toggleGlow = Instance.new("ImageLabel")
    toggleGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    toggleGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    toggleGlow.BackgroundTransparency = 1
    toggleGlow.Image = "rbxassetid://1316042996"
    toggleGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    toggleGlow.ImageTransparency = 0.7
    toggleGlow.Parent = toggleButton

    local pulse = TweenService:Create(toggleButton, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    })
    pulse:Play()

    local toggleDragging = false
    local toggleDragInput, toggleDragStart, toggleStartPos

    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleDragging = true
            toggleDragStart = input.Position
            toggleStartPos = toggleButton.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    toggleDragging = false
                end
            end)
        end
    end)

    toggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            toggleDragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == toggleDragInput and toggleDragging then
            local delta = input.Position - toggleDragStart
            toggleButton.Position = UDim2.new(
                toggleStartPos.X.Scale,
                toggleStartPos.X.Offset + delta.X,
                toggleStartPos.Y.Scale,
                toggleStartPos.Y.Offset + delta.Y
            )
        end
    end)

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 350, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame

    local glowBorder = Instance.new("Frame")
    glowBorder.Name = "GlowBorder"
    glowBorder.Size = UDim2.new(1, 6, 1, 6)
    glowBorder.Position = UDim2.new(0, -3, 0, -3)
    glowBorder.BackgroundTransparency = 1
    glowBorder.BorderSizePixel = 3
    glowBorder.BorderColor3 = Color3.fromRGB(255, 0, 0)
    glowBorder.Parent = mainFrame

    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 18)
    glowCorner.Parent = glowBorder

    local dragging = false
    local dragInput, dragStart, startPos

    local function updateDraggable(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDraggable(input)
        end
    end)

    toggleButton.MouseButton1Click:Connect(function()
        if mainFrame.Visible then
            TweenService:Create(mainFrame, TweenInfo.new(0.3), {
                Size = UDim2.new(0, 0, 0, 0)
            }):Play()
            task.wait(0.3)
            mainFrame.Visible = false
            toggleButton.Visible = true
        else
            mainFrame.Visible = true
            mainFrame.Size = UDim2.new(0, 0, 0, 0)
            TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                Size = UDim2.new(0, 350, 0, 450)
            }):Play()
            toggleButton.Visible = true
        end
    end)

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = titleBar

    local titleIcon = Instance.new("TextLabel")
    titleIcon.Name = "TitleIcon"
    titleIcon.Size = UDim2.new(0, 30, 1, 0)
    titleIcon.Position = UDim2.new(0, 8, 0, 0)
    titleIcon.BackgroundTransparency = 1
    titleIcon.Text = "👑"
    titleIcon.TextColor3 = Color3.fromRGB(255, 50, 50)
    titleIcon.TextSize = 22
    titleIcon.Font = Enum.Font.GothamBold
    titleIcon.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -90, 1, 0)
    titleLabel.Position = UDim2.new(0, 45, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "KORBLOX & HEADLESS"
    titleLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseBtn"
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -38, 0, 7)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(mainFrame, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        task.wait(0.3)
        mainFrame.Visible = false
        toggleButton.Visible = true
    end)

    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 45)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Parent = mainFrame

    local function createTabButton(text, position)
        local btn = Instance.new("TextButton")
        btn.Name = text .. "Tab"
        btn.Size = UDim2.new(0.5, -4, 1, -6)
        btn.Position = UDim2.new(position, 0, 0, 3)
        btn.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 150, 150)
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.BorderSizePixel = 0
        btn.Parent = tabFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        return btn
    end

    local korbloxTab = createTabButton("🦵 KORBLOX", 0)
    local headlessTab = createTabButton("💀 HEADLESS", 0.5)

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -85)
    contentFrame.Position = UDim2.new(0, 0, 0, 85)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local korbloxContent = Instance.new("Frame")
    korbloxContent.Name = "KorbloxContent"
    korbloxContent.Size = UDim2.new(1, 0, 1, 0)
    korbloxContent.Position = UDim2.new(0, 0, 0, 0)
    korbloxContent.BackgroundTransparency = 1
    korbloxContent.Visible = true
    korbloxContent.Parent = contentFrame

    local headlessContent = Instance.new("Frame")
    headlessContent.Name = "HeadlessContent"
    headlessContent.Size = UDim2.new(1, 0, 1, 0)
    headlessContent.Position = UDim2.new(0, 0, 0, 0)
    headlessContent.BackgroundTransparency = 1
    headlessContent.Visible = false
    headlessContent.Parent = contentFrame

    korbloxTab.MouseButton1Click:Connect(function()
        korbloxContent.Visible = true
        headlessContent.Visible = false
        korbloxTab.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        headlessTab.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
    end)

    headlessTab.MouseButton1Click:Connect(function()
        korbloxContent.Visible = false
        headlessContent.Visible = true
        headlessTab.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        korbloxTab.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
    end)

    korbloxTab.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

    local function createKorbloxLeg(isLeft)
        local character = player.Character
        if not character then return false, "No character" end

        local targetName = isLeft and "LeftUpperLeg" or "RightUpperLeg"
        local targetPart = character:FindFirstChild(targetName)
        if not targetPart then return false, "Target part not found" end

        local oldName = isLeft and "Korblox_LeftLeg" or "Korblox_RightLeg"
        local oldLeg = character:FindFirstChild(oldName)
        if oldLeg then oldLeg:Destroy() end

        local leg = Instance.new("Part")
        leg.Name = oldName
        leg.Size = Vector3.new(1.5, 1.8, 1.5)
        leg.Shape = Enum.PartType.Block
        leg.Material = Enum.Material.SmoothPlastic
        leg.Color = Color3.fromRGB(20, 25, 35)
        leg.Reflectance = 0.3
        leg.CanCollide = false
        leg.Anchored = false
        leg.Transparency = 0
        leg.CFrame = targetPart.CFrame

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://1879474997"
        mesh.Scale = Vector3.new(0.8, 0.8, 0.8)
        mesh.Parent = leg

        local bootMesh = Instance.new("SpecialMesh")
        bootMesh.MeshType = Enum.MeshType.FileMesh
        bootMesh.MeshId = "rbxassetid://1879475003"
        bootMesh.Scale = Vector3.new(0.9, 0.7, 0.9)
        bootMesh.Offset = Vector3.new(0, -0.5, 0)
        bootMesh.Parent = leg

        local weld = Instance.new("Weld")
        weld.Part0 = targetPart
        weld.Part1 = leg
        weld.C0 = targetPart.CFrame:Inverse() * leg.CFrame
        weld.Parent = leg

        local glow = Instance.new("PointLight")
        glow.Color = Color3.fromRGB(40, 50, 100)
        glow.Range = 2.5
        glow.Brightness = 0.2
        glow.Parent = leg

        local highlight = Instance.new("Highlight")
        highlight.Parent = leg
        highlight.FillColor = Color3.fromRGB(30, 40, 70)
        highlight.FillTransparency = 0.6
        highlight.OutlineColor = Color3.fromRGB(60, 80, 150)
        highlight.OutlineTransparency = 0.4

        leg.Parent = character

        local partsToHide = isLeft and {"LeftUpperLeg", "LeftLowerLeg", "LeftFoot"} or {"RightUpperLeg", "RightLowerLeg", "RightFoot"}
        for _, partName in ipairs(partsToHide) do
            local part = character:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                if not originalTransparencies[part] then
                    originalTransparencies[part] = part.Transparency
                end
                part.Transparency = 1
            end
        end

        return true, leg
    end

    local function createBothLegs()
        local character = player.Character
        if not character then return false, "No character" end

        local oldBoth = character:FindFirstChild("Korblox_BothLegs")
        if oldBoth then oldBoth:Destroy() end

        local success1, leftLeg = createKorbloxLeg(true)
        local success2, rightLeg = createKorbloxLeg(false)

        if success1 and success2 then
            local group = Instance.new("Model")
            group.Name = "Korblox_BothLegs"
            group.Parent = character

            local left = character:FindFirstChild("Korblox_LeftLeg")
            local right = character:FindFirstChild("Korblox_RightLeg")
            if left then left.Parent = group end
            if right then right.Parent = group end

            return true, group
        end

        return false, "Failed to create legs"
    end

    local function createHeadless()
        local character = player.Character
        if not character then return false, "No character" end

        local targetPart = character:FindFirstChild("Head")
        if not targetPart then return false, "Head not found" end

        local oldAsset = character:FindFirstChild("Headless_Head")
        if oldAsset then oldAsset:Destroy() end

        if not originalTransparencies[targetPart] then
            originalTransparencies[targetPart] = targetPart.Transparency
        end
        targetPart.Transparency = 1

        local head = Instance.new("Part")
        head.Name = "Headless_Head"
        head.Size = Vector3.new(1.5, 1.5, 1.5)
        head.Shape = Enum.PartType.Ball
        head.Material = Enum.Material.SmoothPlastic
        head.Color = Color3.fromRGB(20, 20, 20)
        head.Reflectance = 0.1
        head.CanCollide = false
        head.Anchored = false
        head.Transparency = 0.5
        head.CFrame = targetPart.CFrame

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://1879475003"
        mesh.Scale = Vector3.new(0.8, 0.8, 0.8)
        mesh.Parent = head

        local weld = Instance.new("Weld")
        weld.Part0 = targetPart
        weld.Part1 = head
        weld.C0 = targetPart.CFrame:Inverse() * head.CFrame
        weld.Parent = head

        head.Parent = character

        return true, head
    end

    local function resetAll()
        local character = player.Character
        if not character then return end

        local toRemove = {}
        for _, child in pairs(character:GetChildren()) do
            if child.Name:match("^Korblox_") or child.Name:match("^Headless_") then
                table.insert(toRemove, child)
            end
        end
        for _, child in pairs(toRemove) do
            child:Destroy()
        end

        for part, transparency in pairs(originalTransparencies) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        originalTransparencies = {}

        local defaultParts = {"Head", "Torso", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                             "RightUpperLeg", "RightLowerLeg", "RightFoot",
                             "LeftArm", "LeftLowerArm", "LeftHand",
                             "RightArm", "RightLowerArm", "RightHand"}
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                for _, defaultPart in pairs(defaultParts) do
                    if part.Name == defaultPart then
                        part.Transparency = 0
                        break
                    end
                end
            end
        end

        for _, btn in pairs(contentFrame:GetDescendants()) do
            if btn.Name == "StatusLabel" and btn:IsA("TextLabel") then
                btn.Text = "🔴 Click to equip"
                btn.TextColor3 = Color3.fromRGB(255, 150, 150)
            end
            if btn:IsA("UIStroke") then
                btn.Color = Color3.fromRGB(200, 0, 0)
            end
        end
    end

    local function createAssetButtons(container, assets, isHeadless)
        local startY = 10
        local buttonHeight = 60
        local gap = 8
        local index = 0

        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollFrame.Position = UDim2.new(0, 0, 0, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 4
        scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
        scrollFrame.Parent = container

        local canvas = Instance.new("Frame")
        canvas.Name = "Canvas"
        canvas.Size = UDim2.new(1, 0, 0, #assets * (buttonHeight + gap) + 20)
        canvas.BackgroundTransparency = 1
        canvas.Parent = scrollFrame

        for itemName, config in pairs(assets) do
            index = index + 1

            local btn = Instance.new("TextButton")
            btn.Name = itemName:gsub("%s+", "") .. "Btn"
            btn.Size = UDim2.new(1, -16, 0, buttonHeight)
            btn.Position = UDim2.new(0, 8, 0, startY + (index - 1) * (buttonHeight + gap))
            btn.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
            btn.BorderSizePixel = 0
            btn.Text = ""
            btn.Parent = canvas

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 10)
            btnCorner.Parent = btn

            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = Color3.fromRGB(200, 0, 0)
            btnStroke.Thickness = 2
            btnStroke.Parent = btn

            local iconLabel = Instance.new("TextLabel")
            iconLabel.Name = "Icon"
            iconLabel.Size = UDim2.new(0, 40, 1, 0)
            iconLabel.Position = UDim2.new(0, 10, 0, 0)
            iconLabel.BackgroundTransparency = 1
            iconLabel.Text = config.icon
            iconLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            iconLabel.TextSize = 28
            iconLabel.Font = Enum.Font.GothamBold
            iconLabel.Parent = btn

            local nameLabel = Instance.new("TextLabel")
            nameLabel.Name = "NameLabel"
            nameLabel.Size = UDim2.new(1, -60, 0, 25)
            nameLabel.Position = UDim2.new(0, 55, 0, 5)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = itemName
            nameLabel.TextColor3 = Color3.fromRGB(255, 220, 220)
            nameLabel.TextSize = 15
            nameLabel.Font = Enum.Font.GothamBold
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = btn

            local statusLabel = Instance.new("TextLabel")
            statusLabel.Name = "StatusLabel"
            statusLabel.Size = UDim2.new(1, -60, 0, 20)
            statusLabel.Position = UDim2.new(0, 55, 0, 32)
            statusLabel.BackgroundTransparency = 1
            statusLabel.Text = "🔴 Click to equip"
            statusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
            statusLabel.TextSize = 11
            statusLabel.Font = Enum.Font.GothamMedium
            statusLabel.TextXAlignment = Enum.TextXAlignment.Left
            statusLabel.Parent = btn

            local defaultText = "🔴 Click to equip"

            btn.MouseButton1Click:Connect(function()
                statusLabel.Text = "⏳ Equipping..."
                statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)

                local ok, result
                if isHeadless then
                    ok, result = createHeadless()
                elseif config.isBoth then
                    ok, result = createBothLegs()
                else
                    local isLeft = itemName == "Left Leg"
                    ok, result = createKorbloxLeg(isLeft)
                end

                if ok then
                    statusLabel.Text = "✅ Equipped!"
                    statusLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
                    btnStroke.Color = Color3.fromRGB(100, 255, 150)

                    TweenService:Create(btn, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(30, 60, 30)
                    }):Play()
                    task.wait(0.2)
                    TweenService:Create(btn, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(40, 5, 5)
                    }):Play()

                    task.delay(2, function()
                        btnStroke.Color = Color3.fromRGB(200, 0, 0)
                        statusLabel.Text = defaultText
                        statusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
                    end)
                else
                    statusLabel.Text = "❌ " .. result
                    statusLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                    btnStroke.Color = Color3.fromRGB(255, 0, 0)

                    task.delay(2, function()
                        btnStroke.Color = Color3.fromRGB(200, 0, 0)
                        statusLabel.Text = defaultText
                        statusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
                    end)
                end
            end)
        end

        canvas.Size = UDim2.new(1, 0, 0, #assets * (buttonHeight + gap) + 20)
    end

    local KORBLOX_ASSETS = {
        ["Left Leg"] = {
            icon = "🦵",
            isBoth = false,
        },
        ["Right Leg"] = {
            icon = "🦵",
            isBoth = false,
        },
        ["Both Legs"] = {
            icon = "🦵🦵",
            isBoth = true,
        }
    }

    local HEADLESS_ASSETS = {
        ["Headless"] = {
            icon = "💀",
        }
    }

    createAssetButtons(korbloxContent, KORBLOX_ASSETS, false)
    createAssetButtons(headlessContent, HEADLESS_ASSETS, true)

    local bottomFrame = Instance.new("Frame")
    bottomFrame.Name = "BottomFrame"
    bottomFrame.Size = UDim2.new(1, 0, 0, 40)
    bottomFrame.Position = UDim2.new(0, 0, 1, -40)
    bottomFrame.BackgroundTransparency = 1
    bottomFrame.Parent = mainFrame

    local function createBottomButton(text, position, color)
        local btn = Instance.new("TextButton")
        btn.Name = text:gsub("%s+", "") .. "Btn"
        btn.Size = UDim2.new(0.3, -5, 0.8, 0)
        btn.Position = UDim2.new(position, 0, 0.1, 0)
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 5, 5)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 200, 200)
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamBold
        btn.Parent = bottomFrame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        return btn
    end

    local resetBtn = createBottomButton("🔄 RESET", 0.35, Color3.fromRGB(60, 0, 0))
    local hideBtn = createBottomButton("⌨️ HIDE", 0.67, Color3.fromRGB(60, 0, 0))

    resetBtn.MouseButton1Click:Connect(function()
        resetAll()
    end)

    hideBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = false
        toggleButton.Visible = true
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.K and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            if mainFrame.Visible then
                mainFrame.Visible = false
                toggleButton.Visible = true
            else
                mainFrame.Visible = true
                mainFrame.Size = UDim2.new(0, 0, 0, 0)
                TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                    Size = UDim2.new(0, 350, 0, 450)
                }):Play()
                toggleButton.Visible = true
            end
        end
    end)

    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Visible = true
    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 350, 0, 450)
    }):Play()

    print("✅ Kevin Hub Korblox & Headless Selector loaded!")
    print("🔥 KORBLOX LEGS NOW WORK WITHOUT ASSET LOADING!")
    print("🦵 Click 'Both Legs' for full Korblox look!")
    print("📱 Draggable toggle button - drag it anywhere!")
    print("⌨️ Press Ctrl + K to toggle the GUI")
end)
