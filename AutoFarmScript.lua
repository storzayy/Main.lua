local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua"))()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- UI Load
Rayfield:LoadConfiguration()

local Window = Rayfield:CreateWindow({
   Name = "Brainrot Autofarm",
   LoadingTitle = "Loading by storzayy...",
   LoadingSubtitle = "Steal a Brainrot",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrainrotFarm",
      FileName = "AutoFarmScript"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})

-- AutoFarm Variables
local SelectedBrainrot = nil
local AutoBuyEnabled = false
local AutoClaimEnabled = false

local GodAndSecretBrainrots = {
   "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino", "Matteo", "Tralalero Tralala",
   "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
   "La Vacca Saturno Saturnita", "Chimpanzini Spiderini", "Los Tralaleritos", "Las Tralaleritas",
   "Graipus Medussi", "La Grande Combinasion", "Garama and Madundung",
   "Noobini Pizzanini" -- for testing
}

-- Filter Brainrots
local AllBrainrots = {
   "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino", "Matteo", "Tralalero Tralala",
   "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
   "La Vacca Saturno Saturnita", "Chimpanzini Spiderini", "Los Tralaleritos", "Las Tralaleritas",
   "Graipus Medussi", "La Grande Combinasion", "Garama and Madundung",
   "Noobini Pizzanini", "Espresso Signora", "Orcalero Orcala", "Tigroligre Frutonni",
   "Pot Hotspot", "Torrtuginni Dragonfrutini"
}

-- UI Elements
local MainTab = Window:CreateTab("Auto Farm", 4483362458)
MainTab:CreateDropdown({
   Name = "Teleport to Brainrot",
   Options = AllBrainrots,
   CurrentOption = "",
   Callback = function(option)
       SelectedBrainrot = option
   end
})

MainTab:CreateToggle({
   Name = "Auto Buy God/Secret Brainrots",
   CurrentValue = false,
   Callback = function(value)
       AutoBuyEnabled = value
   end
})

MainTab:CreateToggle({
   Name = "Auto Claim Coins",
   CurrentValue = false,
   Callback = function(value)
       AutoClaimEnabled = value
   end
})

MainTab:CreateParagraph({
   Title = "Interface by storzayy",
   Content = "Only tested on PC - Rayfield UI"
})

-- Helper functions
local function TweenTo(targetPart)
   if not Character:FindFirstChild("HumanoidRootPart") then return end
   local hrp = Character.HumanoidRootPart
   local goal = {CFrame = targetPart.CFrame + Vector3.new(0, 2, 0)}
   TweenService:Create(hrp, TweenInfo.new(1, Enum.EasingStyle.Linear), goal):Play()
end

local function TeleportToBrainrot(name)
   for _, brainrot in pairs(Workspace:GetChildren()) do
       if brainrot.Name == name then
           local root = brainrot:FindFirstChild("HumanoidRootPart") or brainrot:FindFirstChildWhichIsA("BasePart")
           if root then
               TweenTo(root)
               break
           end
       end
   end
end

local function GetBaseNumber()
   local spawnLocation = Workspace:FindFirstChild("SpawnLocation")
   if spawnLocation then
       local base = spawnLocation:FindFirstAncestorWhichIsA("Model")
       if base and base:IsA("Model") then
           return base.Name
       end
   end
   return nil
end

local function AutoClaim()
   local baseNumber = GetBaseNumber()
   if not baseNumber then return end

   local path = Workspace:FindFirstChild("AnimalPodiums")
   if not path then return end

   local claimTile = path:FindFirstChild(baseNumber)
   if claimTile and claimTile:FindFirstChild("base") then
       local main = claimTile.base:FindFirstChild("claim") and claimTile.base.claim:FindFirstChild("hitbox") and claimTile.base.claim.hitbox:FindFirstChild("main")
       if main then
           TweenTo(main)
       end
   end
end

-- Main Loop
task.spawn(function()
   while true do
       task.wait(1)
       
       -- Auto Teleport to Selected Brainrot
       if SelectedBrainrot then
           TeleportToBrainrot(SelectedBrainrot)
       end

       -- Auto Buy God/Secret
       if AutoBuyEnabled then
           for _, brainrot in pairs(Workspace:GetChildren()) do
               if table.find(GodAndSecretBrainrots, brainrot.Name) then
                   local root = brainrot:FindFirstChild("HumanoidRootPart") or brainrot:FindFirstChildWhichIsA("BasePart")
                   if root then
                       TweenTo(root)
                       break
                   end
               end
           end
       end

       -- Auto Claim Money
       if AutoClaimEnabled then
           AutoClaim()
       end
   end
end)
