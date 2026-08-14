local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local CONFIG = {
	Colors = {
		MainBackground = Color3.fromRGB(180, 20, 20),
		Text = Color3.fromRGB(255, 255, 255),
		GradientStart = Color3.fromRGB(220, 0, 0),
		GradientMid = Color3.fromRGB(255, 60, 60),
		GradientEnd = Color3.fromRGB(255, 120, 120),
	},
}

local isHarvesting = false
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "kevinHubHarvest"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 100)
MainFrame.BackgroundColor3 = CONFIG.Colors.MainBackground
MainFrame.BackgroundTransparency = 0.3
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local FrameStroke = Instance.new("UIStroke")
FrameStroke.Thickness = 2
FrameStroke.Color = Color3.new(1, 1, 1)
FrameStroke.Parent = MainFrame

local StrokeGradient = Instance.new("UIGradient")
StrokeGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, CONFIG.Colors.GradientStart),
	ColorSequenceKeypoint.new(0.5, CONFIG.Colors.GradientMid),
	ColorSequenceKeypoint.new(1, CONFIG.Colors.GradientEnd)
})
StrokeGradient.Parent = FrameStroke

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Text = "kevin Hub - Instant Harvest"
TitleLabel.TextSize = 14
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Parent = MainFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = StrokeGradient.Color
TitleGradient.Parent = TitleLabel

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.BackgroundColor3 = CONFIG.Colors.MainBackground
ToggleBtn.BackgroundTransparency = 0.5
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Text = "HARVEST: OFF"
ToggleBtn.TextSize = 13
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0, 45)
ToggleBtn.Parent = MainFrame
ToggleBtn.AutoButtonColor = false

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 2
ButtonStroke.Color = Color3.new(1, 1, 1)
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ButtonStroke.Parent = ToggleBtn

local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = StrokeGradient.Color
ButtonGradient.Parent = ButtonStroke

local ButtonTextGradient = Instance.new("UIGradient")
ButtonTextGradient.Color = StrokeGradient.Color
ButtonTextGradient.Parent = ToggleBtn

local function startHarvesting()
	while isHarvesting do
		local found = false
		for _, obj in pairs(Workspace:GetDescendants()) do
			if not isHarvesting then break end

			local isHarvestPrompt = false
			if obj:IsA("ProximityPrompt") then
				if string.find(string.lower(obj.ActionText), "harvest") or string.find(string.lower(obj.ObjectText), "harvest") then
					isHarvestPrompt = true
				end
			elseif obj:IsA("BillboardGui") then
				if string.find(string.lower(obj.Name), "harvest") then
					isHarvestPrompt = true
				end
			end

			if isHarvestPrompt then
				local parent = obj:FindFirstAncestorOfClass("Model") or obj.Parent
				if parent and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local pos = (parent:IsA("Model") and parent:GetPivot().Position) or (parent:IsA("BasePart") and parent.Position)
					if pos then
						LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
						if obj:IsA("ProximityPrompt") then
							fireproximityprompt(obj)
						end
						found = true
						RunService.RenderStepped:Wait()
					end
				end
			end
		end

		if not found then
			task.wait(0.5)
		end
	end
end

ToggleBtn.MouseButton1Click:Connect(function()
	isHarvesting = not isHarvesting
	ToggleBtn.Text = isHarvesting and "HARVEST: ON" or "HARVEST: OFF"
	if isHarvesting then
		task.spawn(startHarvesting)
	end
end)

task.spawn(function()
	while task.wait() do
		StrokeGradient.Rotation = (StrokeGradient.Rotation + 1) % 360
		ButtonGradient.Rotation = (ButtonGradient.Rotation + 1) % 360
		TitleGradient.Rotation = (TitleGradient.Rotation + 1) % 360
		ButtonTextGradient.Rotation = (ButtonTextGradient.Rotation + 1) % 360
	end
end)
