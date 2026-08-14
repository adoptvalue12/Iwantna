local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local display = player.DisplayName
local name = player.Name
local VERIFIED = utf8.char(0xE000)

local verifiedEnabled = false
local starEnabled = false
local imageAsset = nil
local verifiedTracked = setmetatable({}, {__mode = "k"})
local starTracked = setmetatable({}, {__mode = "k"})
local verifiedConnections = {}
local starConnections = {}
local verifiedLoop = nil
local starLoop = nil

local old = playerGui:FindFirstChild("CompactToggleGui")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CompactToggleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 220, 0, 190)
main.Position = UDim2.new(0.5, -110, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(180, 40, 40)
mainStroke.Thickness = 1
mainStroke.Parent = main

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 8, 8)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleCoverFix = Instance.new("Frame")
titleCoverFix.Size = UDim2.new(1, 0, 0, 12)
titleCoverFix.Position = UDim2.new(0, 0, 1, -12)
titleCoverFix.BackgroundColor3 = titleBar.BackgroundColor3
titleCoverFix.BorderSizePixel = 0
titleCoverFix.ZIndex = 0
titleCoverFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, -70, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Kevin Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local contentContainer = Instance.new("Frame")
contentContainer.Name = "ContentContainer"
contentContainer.Size = UDim2.new(1, 0, 1, -32)
contentContainer.Position = UDim2.new(0, 0, 0, 32)
contentContainer.BackgroundTransparency = 1
contentContainer.BorderSizePixel = 0
contentContainer.Parent = main

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 24, 0, 24)
minimizeButton.Position = UDim2.new(1, -56, 0, 4)
minimizeButton.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
minimizeButton.Text = "−"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 18
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.AutoButtonColor = true
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeButton

local isMinimized = false
local isClosing = false

minimizeButton.MouseButton1Click:Connect(function()
	if isClosing then return end
	isMinimized = not isMinimized

	if isMinimized then
		minimizeButton.Text = "+"
		TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 220, 0, 32)
		}):Play()
		TweenService:Create(contentContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 0, 0)
		}):Play()
	else
		minimizeButton.Text = "−"
		TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 220, 0, 190)
		}):Play()
		TweenService:Create(contentContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1, 0, 1, -32)
		}):Play()
	end
end)

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -28, 0, 4)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.AutoButtonColor = true
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	if isClosing then return end
	isClosing = true

	local closeTween = TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0)
	})

	closeTween:Play()
	closeTween.Completed:Connect(function()
		screenGui:Destroy()
	end)
end)

local function stripVerified()
	pcall(function()
		for _, v in ipairs(CoreGui:GetDescendants()) do
			if v:IsA("TextLabel") or v:IsA("TextButton") then
				local t = v.Text
				if t and t:find(VERIFIED) then
					v.Text = t:gsub(VERIFIED, "")
				end
			end
		end
	end)
end

local function clearVerified()
	verifiedEnabled = false
	TextChatService.OnIncomingMessage = nil
	for _, conn in pairs(verifiedConnections) do
		pcall(function() conn:Disconnect() end)
	end
	table.clear(verifiedConnections)
	if verifiedLoop then
		task.cancel(verifiedLoop)
		verifiedLoop = nil
	end
	table.clear(verifiedTracked)
	stripVerified()
end

local function clearStar()
	starEnabled = false
	for _, conn in pairs(starConnections) do
		pcall(function() conn:Disconnect() end)
	end
	table.clear(starConnections)
	if starLoop then
		task.cancel(starLoop)
		starLoop = nil
	end
	for label in pairs(starTracked) do
		local parent = label.Parent
		if parent then
			local existing = parent:FindFirstChild("StarCreatorBadge")
			if existing then existing:Destroy() end
		end
	end
	table.clear(starTracked)
end

local function startVerified()
	clearVerified()
	verifiedEnabled = true

	TextChatService.OnIncomingMessage = function(message)
		local props = Instance.new("TextChatMessageProperties")
		if message.TextSource and message.TextSource.UserId == player.UserId then
			local prefix = message.PrefixText or (display .. ":")
			prefix = prefix:gsub(":%s*$", "")
			props.PrefixText = prefix .. VERIFIED .. ":"
		end
		return props
	end

	local function fix(label)
		if not verifiedEnabled then return end
		local text = label.Text
		if not text or text == "" then return end
		if text:find(VERIFIED) then return end
		local newText
		if text:find(display, 1, true) then
			newText = text:gsub(display, display .. VERIFIED, 1)
		elseif text:find("@" .. name, 1, true) then
			newText = text:gsub("@" .. name, "@" .. name .. VERIFIED, 1)
		elseif text:find(name, 1, true) then
			newText = text:gsub(name, name .. VERIFIED, 1)
		end
		if newText then
			label.Text = newText
		end
	end

	local function track(label)
		if verifiedTracked[label] then return end
		verifiedTracked[label] = true
		fix(label)
		local conn = label:GetPropertyChangedSignal("Text"):Connect(function()
			fix(label)
		end)
		table.insert(verifiedConnections, conn)
	end

	local function scan()
		if not verifiedEnabled then return end
		pcall(function()
			for _, v in ipairs(CoreGui:GetDescendants()) do
				if v:IsA("TextLabel") or v:IsA("TextButton") then
					local t = v.Text
					if t and (t:find(display, 1, true) or t:find(name, 1, true) or t:find("@" .. name, 1, true)) then
						track(v)
					end
				end
			end
		end)
	end

	verifiedLoop = task.spawn(function()
		while verifiedEnabled do
			scan()
			task.wait(0.8)
		end
	end)

	local descConn = CoreGui.DescendantAdded:Connect(function(obj)
		if not verifiedEnabled then return end
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			task.defer(function()
				local t = obj.Text
				if t and (t:find(display, 1, true) or t:find(name, 1, true) or t:find("@" .. name, 1, true)) then
					track(obj)
				end
			end)
		end
	end)
	table.insert(verifiedConnections, descConn)
end

local function isInPlayerList(obj)
	local current = obj
	while current and current ~= CoreGui do
		local n = current.Name:lower()
		if n:find("playerlist") or n:find("player_list") or n:find("people") then
			return true
		end
		current = current.Parent
	end
	return false
end

local function startStar()
	clearStar()
	starEnabled = true

	if not imageAsset then
		pcall(function()
			local url = "https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/e/4/0/e40401a6461ea6998787a77c84b8ce47a4d6dca5.png"
			local data = game:HttpGet(url)
			writefile("starcreator.png", data)
			imageAsset = getcustomasset("starcreator.png")
		end)
	end

	local function addImage(label)
		if not starEnabled or not imageAsset then return end
		if starTracked[label] then return end
		if not isInPlayerList(label) then return end
		starTracked[label] = true

		local parent = label.Parent
		if not parent then return end

		local existing = parent:FindFirstChild("StarCreatorBadge")
		if existing then existing:Destroy() end

		local img = Instance.new("ImageLabel")
		img.Name = "StarCreatorBadge"
		img.BackgroundTransparency = 1
		img.Image = imageAsset
		img.Size = UDim2.new(0, 14, 0, 14)
		img.AnchorPoint = Vector2.new(1, 0.5)
		img.Position = UDim2.new(0, -3, 0.5, 1)
		img.ZIndex = label.ZIndex + 1
		img.Parent = parent

		local function updatePos()
			if img and img.Parent and label and label.Parent then
				img.Position = UDim2.new(0, -3, 0.5, 1)
			end
		end

		local c1 = label:GetPropertyChangedSignal("Text"):Connect(updatePos)
		local c2 = label:GetPropertyChangedSignal("TextBounds"):Connect(updatePos)
		local c3 = label:GetPropertyChangedSignal("AbsoluteSize"):Connect(updatePos)
		table.insert(starConnections, c1)
		table.insert(starConnections, c2)
		table.insert(starConnections, c3)
	end

	local function scan()
		if not starEnabled then return end
		pcall(function()
			for _, v in ipairs(CoreGui:GetDescendants()) do
				if (v:IsA("TextLabel") or v:IsA("TextButton")) and isInPlayerList(v) then
					local t = v.Text
					if t and (t:find(display, 1, true) or t:find(name, 1, true) or t:find("@" .. name, 1, true)) then
						addImage(v)
					end
				end
			end
		end)
	end

	starLoop = task.spawn(function()
		while starEnabled do
			scan()
			task.wait(1)
		end
	end)

	local descConn = CoreGui.DescendantAdded:Connect(function(obj)
		if not starEnabled then return end
		if (obj:IsA("TextLabel") or obj:IsA("TextButton")) and isInPlayerList(obj) then
			task.defer(function()
				local t = obj.Text
				if t and (t:find(display, 1, true) or t:find(name, 1, true) or t:find("@" .. name, 1, true)) then
					addImage(obj)
				end
			end)
		end
	end)
	table.insert(starConnections, descConn)
end

local function createToggleButton(name, labelText, yPos, onEnable, onDisable)
	local state = false

	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, -20, 0, 40)
	button.Position = UDim2.new(0, 10, 0, yPos)
	button.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
	button.AutoButtonColor = false
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.TextColor3 = Color3.fromRGB(255, 200, 200)
	button.Text = labelText .. ":  Off"
	button.Parent = contentContainer

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = button

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(180, 40, 40)
	stroke.Thickness = 1
	stroke.Parent = button

	local function updateVisual()
		local targetColor = state and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(60, 20, 20)
		TweenService:Create(button, TweenInfo.new(0.15), {
			BackgroundColor3 = targetColor
		}):Play()
		button.Text = labelText .. (state and ":  On" or ":  Off")
	end

	button.MouseButton1Click:Connect(function()
		state = not state
		updateVisual()
		if state then
			onEnable()
		else
			onDisable()
		end
	end)

	return button
end

createToggleButton("VerifiedButton", "Verified", 10, startVerified, clearVerified)
createToggleButton("StarcodeButton", "Starcode Creator", 58, startStar, clearStar)

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart
	main.Position = UDim2.new(
		startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y
	)
end

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

titleBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
