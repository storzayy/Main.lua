-- ✅ Steal a Brainrot Autofarm v1.0.5
-- ✅ Anti-Cheat Safe Teleport (TweenService)
-- ✅ Rayfield UI with Theme and Font Customization
-- ✅ Brainrots Grouped in One Dropdown
-- ✅ Auto Saving Enabled
-- ✅ Version Display & Changelog

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local defaultDelay = 10
local selectedBrainrots = {}
local version = "v1.0.5"
local changelog = {
   "- AutoFarm feature",
   "- Safe Teleport (TweenService)",
   "- Grouped Brainrots",
   "- Settings Tab with version, changelog, theme and font options"
}

-- All brainrots in one dropdown
local brainrots = {
   "Noobini Pizzanini", "Lirilì Larilà", "Tim Cheese", "Fluriflura", "Talpa Di Fero", "Svinina Bombardino",
   "Pipi Kiwi", "Trippi Troppi", "Tung Tung Tung Sahur", "Gangster Footera", "Bandito Bobritto", "Boneca Ambalabu",
   "Cacto Hipopotamo", "Ta Ta Ta Ta Sahur", "Tric Trac Baraboom", "Cappuccino Assassino", "Brr Brr Patapim",
   "Trulimero Trulicina", "Bambini Crostini", "Bananita Dolphinita", "Perochello Lemonchello", "Brri Brri Bicus Dicus Bombicus",
   "Burbaloni Loliloli", "Chimpanzini Bananini", "Ballerina Cappuccina", "Chef Crabracadabra", "Lionel Cactuseli",
   "Glorbo Fruttodrillo", "Blueberrinni Octopusini", "Pandaccini Bananini", "Frigo Camelo", "Orangutini Ananassini",
   "Rhino Toasterino", "Bombardiro Crocodilo", "Bombombini Gusini", "Cavallo Virtuoso", "Spioniro Golubiro",
   "Zibra Zubra Zibralini", "Tigrilini Watermelini", "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino",
   "Matteo", "Tralalero Tralala", "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
   "Tigroligre Frutonni", "Orcalero Orcala", "La Vacca Saturno Saturnita", "Chimpanzini Spiderini",
   "Los Tralaleritos", "Las Tralaleritas", "Graipus Medussi", "La Grande Combinasion", "Garama and Madundung",
   "Torrtuginni Dragonfrutini", "Pot Hotspot"
}

-- Window
local Window = Rayfield:CreateWindow({
   Name = "Steal a Brainrot Autofarm",
   LoadingTitle = "Loading AutoFarm...",
   ConfigurationSaving = {
       Enabled = true,
       FolderName = "BrainrotAutoFarm",
       FileName = "AutoFarmConfig"
   },
   Discord = { Enabled = false }
})

-- Tabs
local MainTab = Window:CreateTab("AutoFarm", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- Dropdown
MainTab:CreateDropdown({
   Name = "Select Brainrots",
   Options = brainrots,
   MultiSelection = true,
   Callback = function(selected)
       selectedBrainrots = selected
   end
})

-- Delay slider
MainTab:CreateSlider({
   Name = "Delay between collections (seconds)",
   Range = {1, 60},
   Increment = 1,
   CurrentValue = defaultDelay,
   Callback = function(Value)
       defaultDelay = Value
   end
})

-- Autofarm toggle
MainTab:CreateToggle({
   Name = "Enable AutoFarm",
   CurrentValue = false,
   Callback = function(enabled)
       if not enabled then return end
       task.spawn(function()
           while enabled do
               local startPos = root.Position
               for _, name in pairs(selectedBrainrots) do
                   for _, obj in pairs(workspace:GetDescendants()) do
                       if obj:IsA("Model") and obj.Name == name then
                           local btn = nil
                           for _, child in ipairs(obj:GetChildren()) do
                               if child:IsA("Model") then
                                   for _, p in ipairs(child:GetDescendants()) do
                                       if p:IsA("BasePart") and p.BrickColor == BrickColor.Green() then
                                           btn = p
                                           break
                                       end
                                   end
                               end
                           end
                           if btn then
                               local tween = TweenService:Create(root, TweenInfo.new(1), {CFrame = btn.CFrame + Vector3.new(0,2,0)})
                               tween:Play()
                               tween.Completed:Wait()
                               task.wait(0.5)
                               local backTween = TweenService:Create(root, TweenInfo.new(1), {CFrame = CFrame.new(startPos)})
                               backTween:Play()
                               backTween.Completed:Wait()
                           end
                       end
                   end
               end
               task.wait(defaultDelay)
           end
       end)
   end
})

-- Version + changelog
SettingsTab:CreateParagraph({Title = "Script Version", Content = version})
SettingsTab:CreateParagraph({Title = "Changelog", Content = table.concat(changelog, "\n")})

-- Theme settings
SettingsTab:CreateColorPicker({
   Name = "UI Theme Color",
   Color = Color3.fromRGB(64, 128, 255),
   Callback = function(color)
       Rayfield:SetTheme({Accent = color})
   end
})

SettingsTab:CreateDropdown({
   Name = "UI Font",
   Options = {"Gotham", "Code", "Legacy", "UI"},
   Callback = function(font)
       Rayfield:SetTheme({Font = font})
   end
})
