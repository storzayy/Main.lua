-- ⛔ Защита от античита — кастомный телепорт через TweenService
-- ✅ Используется Rayfield UI
-- ✅ Полный список Brainrot'ов
-- ✅ Задержка регулируется

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local defaultDelay = 10
local selectedBrainrots = {}

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

-- UI
local Window = Rayfield:CreateWindow({
   Name = "Steal a Brainrot Autofarm",
   LoadingTitle = "Brainrot Assistant",
   ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "BrainrotSettings"
   },
   Discord = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 4483362458)

-- Time slider
MainTab:CreateSlider({
   Name = "Delay between collections (seconds)",
   Range = {1, 60},
   Increment = 1,
   CurrentValue = defaultDelay,
   Callback = function(Value)
       defaultDelay = Value
   end
})

-- Brainrot selector
MainTab:CreateDropdown({
   Name = "Select Brainrots to Farm",
   Options = brainrots,
   MultiSelection = true,
   Callback = function(Selected)
       selectedBrainrots = Selected
   end
})

-- Autofarm toggle
MainTab:CreateToggle({
   Name = "AutoFarm Enabled",
   CurrentValue = false,
   Callback = function(enabled)
       if not enabled then return end

       task.spawn(function()
           while enabled do
               local startPos = root.Position

               for _, name in pairs(selectedBrainrots) do
                   for _, obj in pairs(workspace:GetDescendants()) do
                       if obj:IsA("Model") and obj.Name == name then
                           local touchPart = obj:FindFirstChildWhichIsA("BasePart")
                           if touchPart then
                               -- Safe tween movement
                               local tween = TweenService:Create(root, TweenInfo.new(1), {CFrame = touchPart.CFrame + Vector3.new(0, 2, 0)})
                               tween:Play()
                               tween.Completed:Wait()

                               wait(0.5)

                               -- Return
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
