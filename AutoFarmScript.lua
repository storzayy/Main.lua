--[[
AutoFarmScript.lua
Made by storzayy ❤️
]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Base index auto-detect
local function GetSpawnBase()
	for _, base in pairs(workspace:WaitForChild("SpawnLocations"):GetChildren()) do
		if base:FindFirstChild("Spawn") and (base.Spawn.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 100 then
			return base.Name
		end
	end
	return "1"
end

-- Tween Teleport
local function SmoothTeleport(targetPos)
	local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
	local info = TweenInfo.new((hrp.Position - targetPos).Magnitude / 100, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(targetPos)})
	tween:Play()
	tween.Completed:Wait()
end

-- Setup Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()
local Window = Rayfield:CreateWindow({
	Name = "Brainrot AutoFarm | Interface by storzayy",
	LoadingTitle = "Brainrot Autofarm",
	LoadingSubtitle = "Made by storzayy ❤️",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BrainrotAutoFarm",
		FileName = "AutoFarmSettings"
	},
	Discord = {
		Enabled = false
	},
	KeySystem = false
})

-- Brainrot List
local AllBrainrots = {
	"Noobini Pizzanini","Banana Bonana","Capibara Arara","Elefante Cacahuete","Cocofanto Elefanto","Girafa Celestre",
	"Gattatino Nyanino","Matteo","Tralalero Tralala","Odin Din Din Dun","Statutino Libertino","Trenostruzzo Turbo 3000",
	"La Vacca Saturno Saturnita","Chimpanzini Spiderini","Los Tralaleritos","Las Tralaleritas",
	"Graipus Medussi","La Grande Combinasion","Garama and Madundung"
}

local RareBrainrots = {
	["Cocofanto Elefanto"] = true, ["Girafa Celestre"] = true, ["Gattatino Nyanino"] = true,
	["Matteo"] = true, ["Tralalero Tralala"] = true, ["Odin Din Din Dun"] = true,
	["Statutino Libertino"] = true, ["Trenostruzzo Turbo 3000"] = true,
	["La Vacca Saturno Saturnita"] = true, ["Chimpanzini Spiderini"] = true,
	["Los Tralaleritos"] = true, ["Las Tralaleritas"] = true, ["Graipus Medussi"] = true,
	["La Grande Combinasion"] = true, ["Garama and Madundung"] = true,
	["Noobini Pizzanini"] = true -- for testing
}

-- Dropdown to teleport to Brainrots
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
TeleportTab:CreateDropdown({
	Name = "Teleport to Brainrot",
	Options = AllBrainrots,
	Callback = function(brainrot)
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("Model") and v.Name == brainrot then
				local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
				if root then SmoothTeleport(root.Position) break end
			end
		end
	end
})

-- Auto Collect Cash
local AutoFarmTab = Window:CreateTab("AutoFarm", 4483362458)
local collecting = false

AutoFarmTab:CreateToggle({
	Name = "Auto Collect Money",
	CurrentValue = false,
	Callback = function(state)
		collecting = state
		while collecting do
			local base = GetSpawnBase()
			local tile = workspace:FindFirstChild("AnimalPodiums"):FindFirstChild(base)
			if tile then
				local touch = tile:FindFirstChild("base"):FindFirstChild("claim"):FindFirstChild("hitbox"):FindFirstChild("main")
				if touch then SmoothTeleport(touch.Position + Vector3.new(0, 5, 0)) end
			end
			wait(2)
		end
	end
})

-- Auto Buy Rares
local autobuy = false
AutoFarmTab:CreateToggle({
	Name = "Auto Buy Rare Brainrots",
	CurrentValue = false,
	Callback = function(state)
		autobuy = state
		while autobuy do
			for _, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Model") and RareBrainrots[v.Name] then
					local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
					if root then
						SmoothTeleport(root.Position + Vector3.new(0, 5, 0))
						task.wait(1)
					end
				end
			end
			task.wait(3)
		end
	end
})

-- UI Style
local SettingsTab = Window:CreateTab("Settings", 4483362458)
SettingsTab:CreateParagraph({Title = "Made by storzayy ❤️", Content = "This script was created with love."})

-- Load configuration
Rayfield:LoadConfiguration()
