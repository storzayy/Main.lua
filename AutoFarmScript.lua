# Saving the final version of the Lua AutoFarmScript with all brainrots included and working teleport logic

final_script = '''-- ⛔ Anti-Cheat Safe Teleport — TweenService
-- ✅ Rayfield UI
-- ✅ Grouped Brainrots Dropdown
-- ✅ Delay Slider
-- ✅ Auto Saving Enabled
-- ✅ Loadstring Ready
-- ✅ Version Display and Customization

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

-- Group brainrots by first letter
local brainrotGroups = {}
for _, name in ipairs(brainrots) do
    local firstLetter = name:sub(1, 1):upper()
    if not brainrotGroups[firstLetter] then
        brainrotGroups[firstLetter] = {}
    end
    table.insert(brainrotGroups[firstLetter], name)
end

-- UI
local Window = Rayfield:CreateWindow({
    Name = "Storzayy | Steal a Brainrot Autofarm",
    LoadingTitle = "Loading...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotAutoFarm",
        FileName = "AutoFarmConfig"
    },
    Discord = { Enabled = false }
})

local MainTab = Window:CreateTab("Autofarm", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

MainTab:CreateSlider({
    Name = "Delay between collections (seconds)",
    Range = {1, 60},
    Increment = 1,
    CurrentValue = defaultDelay,
    Callback = function(Value)
        defaultDelay = Value
    end
})

for letter, list in pairs(brainrotGroups) do
    MainTab:CreateDropdown({
        Name = "Brainrots: " .. letter,
        Options = list,
        MultiSelection = true,
        Callback = function(selected)
            for _, v in ipairs(selected) do
                if not table.find(selectedBrainrots, v) then
                    table.insert(selectedBrainrots, v)
                end
            end
        end
    })
end

MainTab:CreateToggle({
    Name = "AutoFarm Enabled",
    CurrentValue = false,
    Callback = function(enabled)
        if not enabled then return end
        task.spawn(function()
            while enabled do
                character = player.Character or player.CharacterAdded:Wait()
                root = character:WaitForChild("HumanoidRootPart")
                local startPos = root.CFrame

                for _, name in pairs(selectedBrainrots) do
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") and obj.Name == name then
                            for _, part in ipairs(obj:GetDescendants()) do
                                if part:IsA("BasePart") and tostring(part.BrickColor) == "Bright green" then
                                    local goalCFrame = part.CFrame + Vector3.new(0, 2.5, 0)

                                    local tween = TweenService:Create(root, TweenInfo.new(1), {CFrame = goalCFrame})
                                    tween:Play()
                                    tween.Completed:Wait()

                                    task.wait(0.5)

                                    local returnTween = TweenService:Create(root, TweenInfo.new(1), {CFrame = startPos})
                                    returnTween:Play()
                                    returnTween.Completed:Wait()
                                end
                            end
                        end
                    end
                end
                task.wait(defaultDelay)
            end
        end)
    end
})

-- Settings Info
SettingsTab:CreateParagraph({
    Title = "AutoFarmScript",
    Content = "Version: 1.0.5\\nCreated by: Storzayy\\nUI Framework: Rayfield UI\\nSafe Teleport: Enabled"
})

SettingsTab:CreateParagraph({
    Title = "Changelog",
    Content = "- ✅ Grouped Brainrots\\n- ✅ TweenService Safe Teleport\\n- ✅ Delay Slider\\n- ✅ Loadstring Ready\\n- ✅ Version & UI Info"
})
'''

with open("/mnt/data/AutoFarmScript_Final.lua", "w") as file:
    file.write(final_script)

"/mnt/data/AutoFarmScript_Final.lua"
