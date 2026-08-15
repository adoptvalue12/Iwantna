local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables d'état
local isFarming = false
local farmingThread = nil
local isMinimized = false
local dragging = false
local dragStart, startPos
local farmSpeed = 50  -- Valeur par défaut (10 à 100)
local selectedWeapon = nil

-- Références au personnage
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2FarmGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 280)  -- Plus grand pour les nouveaux contrôles
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Coins arrondis
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 16)
uiCorner.Parent = mainFrame

-- Effet de lueur
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

-- Barre du haut (titre, minimiser, fermer)
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

-- Conteneur du contenu
local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -42)
contentContainer.Position = UDim2.new(0, 0, 0, 42)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- Séparateur
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0.02, 0)
line.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
line.BackgroundTransparency = 0.3
line.BorderSizePixel = 0
line.Parent = contentContainer

-- Statut
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 28)
statusLabel.Position = UDim2.new(0.05, 0, 0.07, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Status: Ready!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = contentContainer

-- Contrôle de vitesse
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.4, 0, 0, 28)
speedLabel.Position = UDim2.new(0.05, 0, 0.26, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Speed: 50"
speedLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
speedLabel.TextScaled = true
speedLabel.Font = Enum.Font.GothamSemibold
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentContainer

local speedMinus = Instance.new("TextButton")
speedMinus.Size = UDim2.new(0, 30, 0, 30)
speedMinus.Position = UDim2.new(0.55, 0, 0.255, 0)
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
speedPlus.Position = UDim2.new(0.75, 0, 0.255, 0)
speedPlus.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
speedPlus.Text = "+"
speedPlus.TextColor3 = Color3.new(1,1,1)
speedPlus.TextScaled = true
speedPlus.Font = Enum.Font.GothamBold
speedPlus.Parent = contentContainer
local speedPlusCorner = Instance.new("UICorner")
speedPlusCorner.CornerRadius = UDim.new(0, 8)
speedPlusCorner.Parent = speedPlus

-- Affichage des pièces (leaderstats)
local coinsLabel = Instance.new("TextLabel")
coinsLabel.Size = UDim2.new(0.9, 0, 0, 28)
coinsLabel.Position = UDim2.new(0.05, 0, 0.44, 0)
coinsLabel.BackgroundTransparency = 1
coinsLabel.Text = "🪙 Coins: 0"
coinsLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
coinsLabel.TextScaled = true
coinsLabel.Font = Enum.Font.GothamSemibold
coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
coinsLabel.Parent = contentContainer

-- Bouton START/STOP
local startButton = Instance.new("TextButton")
startButton.Size = UDim2.new(0.42, 0, 0, 44)
startButton.Position = UDim2.new(0.05, 0, 0.62, 0)
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

-- Bouton Spawn Weapon
local spawnWeaponBtn = Instance.new("TextButton")
spawnWeaponBtn.Size = UDim2.new(0.42, 0, 0, 44)
spawnWeaponBtn.Position = UDim2.new(0.53, 0, 0.62, 0)
spawnWeaponBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
spawnWeaponBtn.Text = "🔫 Spawn"
spawnWeaponBtn.TextColor3 = Color3.new(1,1,1)
spawnWeaponBtn.TextScaled = true
spawnWeaponBtn.Font = Enum.Font.GothamBold
spawnWeaponBtn.Parent = contentContainer
local spawnCorner = Instance.new("UICorner")
spawnCorner.CornerRadius = UDim.new(0, 12)
spawnCorner.Parent = spawnWeaponBtn

-- Crédit
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

-- Mise à jour de l'affichage des pièces (leaderstats)
local function updateCoins()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local coins = leaderstats:FindFirstChild("Coins") or leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money")
        if coins then
            coinsLabel.Text = "🪙 Coins: " .. tostring(coins.Value)
        end
    end
end
updateCoins()
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    updateCoins()
end)
-- Mise à jour périodique
game:GetService("RunService").Heartbeat:Connect(function()
    if not isFarming then return end
    updateCoins(
            --[[
  MM2 Farm Amélioré
  Partie 2 : Fonctions de farming, contrôle de vitesse, spawn d'arme, interactions
]]

-- Références mises à jour lors du respawn
player.CharacterAdded:Connect(function(char)
    char = char
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
    updateCoins()
end)

-- Récupération de la carte (mise en cache)
local mapCache = nil
local function GetMap()
    if mapCache and mapCache.Parent then return mapCache end
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:GetAttribute("MapID") and obj:FindFirstChild("CoinContainer") then
            mapCache = obj
            return obj
        end
    end
    return nil
end

-- Trouve la pièce la plus proche
local function getNearest()
    local map = GetMap()
    if not map then return nil end
    local closest, dist = nil, math.huge
    local coinContainer = map:FindFirstChild("CoinContainer")
    if not coinContainer then return nil end
    for _, coin in ipairs(coinContainer:GetChildren()) do
        local visual = coin:FindFirstChild("CoinVisual")
        if visual and not visual:GetAttribute("Collected") then
            local d = (hrp.Position - coin.Position).Magnitude
            if d < dist then
                closest = coin
                dist = d
            end
        end
    end
    return closest
end

-- Téléportation avec vitesse réglable
local function tp(goal)
    if not goal or not hrp or not humanoid then return end
    humanoid:ChangeState(11) -- En attente
    local distance = (hrp.Position - goal.Position).Magnitude
    -- La vitesse est inversement proportionnelle à la valeur : plus la valeur est élevée, plus on va vite
    local speedFactor = farmSpeed / 50  -- 50 = vitesse normale (distance / 25)
    local tweenTime = distance / (25 * speedFactor)
    tweenTime = math.max(tweenTime, 0.1) -- éviter division par zéro
    local tween = TweenService:Create(hrp, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = goal.CFrame})
    tween:Play()
    tween.Completed:Wait()
end

-- Boucle de farm
local function farmingLoop()
    while isFarming do
        local target = getNearest()
        if target and humanoid and humanoid.Health > 0 then
            tp(target)
            local visual = target:FindFirstChild("CoinVisual")
            -- Attendre que la pièce soit ramassée ou qu'une autre devienne plus proche
            local timeout = 0
            while visual and not visual:GetAttribute("Collected") and visual.Parent and isFarming do
                if humanoid.Health <= 0 then break end
                local nextTarget = getNearest()
                if nextTarget and nextTarget ~= target then
                    break -- changer de cible si une plus proche apparaît
                end
                task.wait(0.1)
                timeout = timeout + 1
                if timeout > 50 then break end -- éviter boucle infinie
            end
        else
            task.wait(0.3)
        end
    end
end

-- Démarrer / Arrêter le farm
local function toggleFarming()
    isFarming = not isFarming
    if isFarming then
        startButton.Text = "⏹ STOP"
        startButton.BackgroundColor3 = Color3.fromRGB(180, 20, 20)
        statusLabel.Text = "● Status: Farming..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        -- Lancer le thread
        if farmingThread then
            task.cancel(farmingThread)
            farmingThread = nil
        end
        farmingThread = task.spawn(farmingLoop)
        print("MM2 Farm Started!")
    else
        startButton.Text = "▶ START"
        startButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
        statusLabel.Text = "● Status: Stopped"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        if farmingThread then
            task.cancel(farmingThread)
            farmingThread = nil
        end
        print("MM2 Farm Stopped!")
    end
end

-- Gestion de la vitesse
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

-- Spawn d'arme depuis ReplicatedStorage
local function spawnWeapon()
    local storage = ReplicatedStorage
    if not storage then
        statusLabel.Text = "● Error: ReplicatedStorage not found"
        return
    end
    -- Récupère tous les outils dans ReplicatedStorage
    local weapons = {}
    for _, child in ipairs(storage:GetChildren()) do
        if child:IsA("Tool") then
            table.insert(weapons, child)
        end
    end
    if #weapons == 0 then
        statusLabel.Text = "● No weapons found in ReplicatedStorage"
        return
    end
    -- Choisit une arme aléatoire
    local weapon = weapons[math.random(1, #weapons)]
    -- Clone et donne au joueur
    local clone = weapon:Clone()
    clone.Parent = player.Backpack
    statusLabel.Text = "● Spawned: " .. weapon.Name
    print("Spawned weapon: " .. weapon.Name)
end

spawnWeaponBtn.MouseButton1Click:Connect(spawnWeapon)

-- Événements de survol pour les boutons
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

spawnWeaponBtn.MouseEnter:Connect(function()
    spawnWeaponBtn.BackgroundColor3 = Color3.fromRGB(70, 200, 70)
end)
spawnWeaponBtn.MouseLeave:Connect(function()
    spawnWeaponBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
end)

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

closeBtn.MouseEnter:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)
closeBtn.MouseLeave:Connect(function()
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
end)

-- Drag de la GUI
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

-- Minimiser / Agrandir
local function toggleMinimize()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame:TweenSize(UDim2.new(0, 200, 0, 42), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "+"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        contentContainer.Visible = false
        umbrella.Visible = false
        glow.Size = UDim2.new(1.08, 0, 1.12, 0)
        glow.Position = UDim2.new(-0.04, 0, -0.06, 0)
        title.Text = "Yuno farm"
        title.Position = UDim2.new(0, 12, 0, 0)
        title.Size = UDim2.new(0.8, 0, 1, 0)
        topCorner.CornerRadius = UDim.new(0, 20)
    else
        mainFrame:TweenSize(UDim2.new(0, 280, 0, 280), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        minimizeBtn.Text = "−"
        minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        contentContainer.Visible = true
        umbrella.Visible = true
        glow.Size = UDim2.new(1.04, 0, 1.04, 0)
        glow.Position = UDim2.new(-0.02, 0, -0.02, 0)
        title.Text = "MM2 Farm"
        title.Position = UDim2.new(0, 52, 0, 0)
        title.Size = UDim2.new(0.5, 0, 1, 0)
        topCorner.CornerRadius = UDim.new(0, 16)
    end
end

minimizeBtn.MouseButton1Click:Connect(toggleMinimize)

-- Fermeture complète
closeBtn.MouseButton1Click:Connect(function()
    mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    isFarming = false
    if farmingThread then
        task.cancel(farmingThread)
        farmingThread = nil
    end
    screenGui:Destroy()
end)

startButton.MouseButton1Click:Connect(toggleFarming)

-- Mise à jour de l'affichage des pièces quand le joueur change
player:GetPropertyChangedSignal("Character"):Connect(function()
    task.wait(0.5)
    updateCoins()
end)

print("MM2 Farm Enhanced loaded successfully!")
