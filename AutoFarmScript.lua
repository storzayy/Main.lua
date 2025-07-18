-- AutoFarm Script | by storzayy | Made with ❤️

-- Anti AFK
pcall(function()
	local VirtualUser = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:Connect(function()
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		task.wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end)

-- Rayfield UI Setup
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

local Window = Rayfield:CreateWindow({
	Name = "Steal a Brainrot | by storzayy",
	LoadingTitle = "AutoFarm Loading...",
	LoadingSubtitle = "Made with ❤️",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BrainrotFarmConfig",
		FileName = "Config"
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

-- Variables
local TeleportService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Workspace = game:GetService("Workspace")
local Base = tostring(LocalPlayer.SpawnLocation.Parent.Name)
local Collected = false
local AutoBuyEnabled = false
local AutoCollectEnabled = false
local AutoTeleportEnabled = false
local SelectedBrainrot = nil

-- Brainrots
local Brainrots = {
	"Noobini Pizzanini", "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino", "Matteo",
	"Tralalero Tralala", "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
	"La Vacca Saturno Saturnita", "Chimpanzini Spiderini", "Los Tralaleritos", "Las Tralaleritas",
	"Graipus Medussi", "La Grande Combinasion", "Garama and Madundung",
	-- (Include all others here if needed)
}

-- Teleport Function
local function safeTeleport(position)
	local tween = TeleportService:Create(HRP, TweenInfo.new(1), {CFrame = CFrame.new(position)})
	tween:Play()
	tween.Completed:Wait()
end

-- Auto Buy Logic
task.spawn(function()
	while true do
		if AutoBuyEnabled then
			for _, obj in pairs(Workspace.Brainrots:GetChildren()) do
				if table.find(Brainrots, obj.Name) and obj:FindFirstChild("main") then
					safeTeleport(obj.main.Position + Vector3.new(0, 4, 0))
					fireproximityprompt(obj.main:FindFirstChildOfClass("ProximityPrompt"))
					task.wait(0.5)
				end
			end
		end
		task.wait(1)
	end
end)

-- Auto Collect Cash
task.spawn(function()
	while true do
		if AutoCollectEnabled then
			for _, hitbox in ipairs(Workspace:FindFirstChild("AnimalPodiums")[Base]:FindFirstChild("base"):FindFirstChild("claim"):GetDescendants()) do
				if hitbox.Name == "main" and hitbox:IsA("BasePart") then
					safeTeleport(hitbox.Position + Vector3.new(0, 4, 0))
					task.wait(0.5)
				end
			end
		end
		task.wait(5)
	end
end)

-- Auto Teleport to Selected Brainrot
task.spawn(function()
	while true do
		if AutoTeleportEnabled and SelectedBrainrot then
			for _, obj in pairs(Workspace.Brainrots:GetChildren()) do
				if obj.Name == SelectedBrainrot and obj:FindFirstChild("main") then
					safeTeleport(obj.main.Position + Vector3.new(0, 4, 0))
				end
			end
		end
		task.wait(2)
	end
end)

-- UI Tabs and Toggles
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateToggle({
	Name = "Auto Buy Rare Brainrots",
	CurrentValue = false,
	Callback = function(Value)
		AutoBuyEnabled = Value
	end,
})

MainTab:CreateToggle({
	Name = "Auto Collect Cash/Money",
	CurrentValue = false,
	Callback = function(Value)
		AutoCollectEnabled = Value
	end,
})

MainTab:CreateToggle({
	Name = "Auto Teleport to Brainrot",
	CurrentValue = false,
	Callback = function(Value)
		AutoTeleportEnabled = Value
	end,
})

MainTab:CreateDropdown({
	Name = "Select Brainrot to Teleport",
	Options = Brainrots,
	CurrentOption = "",
	Callback = function(Value)
		SelectedBrainrot = Value
	end,
})

-- Footer
Rayfield:Notify({
	Title = "Script Loaded",
	Content = "Interface by storzayy | Made with ❤️",
	Duration = 6,
	Image = 4483362458,
})
