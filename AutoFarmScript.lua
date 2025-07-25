local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Anti-AFK
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Get PlayerGui safely
local function getPlayerGui()
    local player = game:GetService("Players").LocalPlayer
    return player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")
end

-- UI Config
local Window = Rayfield:CreateWindow({
	Name = "Steal a Brainrot - Autofarm | by storzayy",
	LoadingTitle = "Steal a Brainrot",
	LoadingSubtitle = "Made by storzayy",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BrainrotAutoFarm",
		FileName = "AutoFarmConfig"
	},
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Services and player setup
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local selectedBrainrot = nil

-- Brainrots list (update if needed)
local brainrots = {
	"Noobini Pizzanini", "Cocofanto Elefanto", "Girafa Celestre",
	"Tralalero Tralala", "Matteo", "Odin Din Din Dun",
	"Statutino Libertino", "Trenostruzzo Turbo 3000",
	"La Vacca Saturno Saturnita", "Graipus Medussi", "Garama and Madundung"
}

-- Safe teleport function
local function safeTeleport(position)
	local tween = TweenService:Create(humanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(position)})
	tween:Play()
	tween.Completed:Wait()
end

-- TABS
local farmingTab = Window:CreateTab("Autofarm", 4483362458)
local teleportTab = Window:CreateTab("Teleport", 4483362458)
local miscTab = Window:CreateTab("Misc", 4483362458)

-- Brainrot Dropdown + Teleport button
teleportTab:CreateDropdown({
	Name = "Select Brainrot",
	Options = brainrots,
	CurrentOption = "",
	Flag = "BrainrotDropdown",
	Callback = function(option)
		selectedBrainrot = option
	end,
})

teleportTab:CreateButton({
	Name = "Teleport to selected Brainrot",
	Callback = function()
		if selectedBrainrot then
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Model") and v.Name == selectedBrainrot and v:FindFirstChild("HumanoidRootPart") then
					safeTeleport(v.HumanoidRootPart.Position)
					break
				end
			end
		end
	end,
})

-- Coin collection logic
local function collectCoins()
	local base = player:FindFirstChild("SpawnLocation")
	if not base then return end

	local baseNumber = base.Name:match("%d+")
	local tilePath = workspace:FindFirstChild("AnimalPodiums")
	if not tilePath then return end

	local hitbox = tilePath:FindFirstChild(baseNumber)
	if hitbox then
		local main = hitbox:FindFirstChild("base") and hitbox.base:FindFirstChild("claim") and hitbox.base.claim:FindFirstChild("hitbox") and hitbox.base.claim.hitbox:FindFirstChild("main")
		if main then
			firetouchinterest(humanoidRootPart, main, 0)
			wait(0.1)
			firetouchinterest(humanoidRootPart, main, 1)
		end
	end
end

-- Auto collect toggle
farmingTab:CreateToggle({
	Name = "Auto Collect Coins",
	CurrentValue = false,
	Flag = "AutoCollect",
	Callback = function(state)
		getgenv().CollectingCoins = state
		while getgenv().CollectingCoins do
			collectCoins()
			wait(2)
		end
	end,
})

-- Anti-AFK toggle (visual)
miscTab:CreateParagraph({
	Title = "Anti-AFK",
	Content = "Anti-AFK is enabled automatically to keep you online."
})
