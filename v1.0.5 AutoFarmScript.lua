--[[ 
    Interface by storzayy
    Version: v1.0
    Changelog: Initial release with full autofarm + UI + teleport support
]]

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local selectedBrainrot = nil
local autoFarmEnabled = false
local brainrots = {
    "Noobini Pizzanini",
    "Lirilì Larilà",
    "Tim Cheese",
    "Fluriflura",
    "Talpa Di Fero",
    "Svinina Bombardino",
    "Pipi Kiwi",
    "Trippi Troppi",
    "Tung Tung Tung Sahur",
    "Gangster Footera",
    "Bandito Bobritto",
    "Boneca Ambalabu",
    "Cacto Hipopotamo",
    "Ta Ta Ta Ta Sahur",
    "Tric Trac Baraboom",
    "Cappuccino Assassino",
    "Brr Brr Patapim",
    "Trulimero Trulicina",
    "Bambini Crostini",
    "Bananita Dolphinita",
    "Perochello Lemonchello",
    "Brri Brri Bicus Dicus Bombicus",
    "Burbaloni Loliloli",
    "Chimpanzini Bananini",
    "Ballerina Cappuccina",
    "Chef Crabracadabra",
    "Lionel Cactuseli",
    "Glorbo Fruttodrillo",
    "Blueberrinni Octopusini",
    "Pandaccini Bananini",
    "Frigo Camelo",
    "Orangutini Ananassini",
    "Rhino Toasterino",
    "Bombardiro Crocodilo",
    "Bombombini Gusini",
    "Cavallo Virtuoso",
    "Spioniro Golubiro",
    "Zibra Zubra Zibralini",
    "Tigrilini Watermelini",
    "Cocofanto Elefanto",
    "Girafa Celestre",
    "Gattatino Nyanino",
    "Matteo",
    "Tralalero Tralala",
    "Odin Din Din Dun",
    "Statutino Libertino",
    "Trenostruzzo Turbo 3000",
    "Tigroligre Frutonni",
    "Orcalero Orcala",
    "La Vacca Saturno Saturnita",
    "Chimpanzini Spiderini",
    "Los Tralaleritos",
    "Las Tralaleritas",
    "Graipus Medussi",
    "La Grande Combinasion",
    "Garama and Madundung",
    "Torrtuginni Dragonfrutini",
    "Pot Hotspot"
}

-- UI (Rayfield)
loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Interface by storzayy",
    LoadingTitle = "Steal a Brainrot",
    LoadingSubtitle = "by storzayy",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotAutoFarm",
        FileName = "AutoFarmConfig"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

-- Tabs and Options
local MainTab = Window:CreateTab("AutoFarm", 4483362458)
MainTab:CreateDropdown({
    Name = "Choose Brainrot",
    Options = brainrots,
    CurrentOption = "",
    Callback = function(Value)
        selectedBrainrot = Value
    end,
})

MainTab:CreateToggle({
    Name = "Enable AutoFarm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarmEnabled = Value
    end,
})

-- Teleport function
local function teleportTo(part)
    if HumanoidRootPart and part then
        local tween = TweenService:Create(
            HumanoidRootPart,
            TweenInfo.new((HumanoidRootPart.Position - part.Position).Magnitude / 200, Enum.EasingStyle.Linear),
            {CFrame = part.CFrame + Vector3.new(0, 3, 0)}
        )
        tween:Play()
        tween.Completed:Wait()
    end
end

-- AutoFarm logic
task.spawn(function()
    while RunService.RenderStepped:Wait() do
        if autoFarmEnabled and selectedBrainrot then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == selectedBrainrot then
                    local root = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
                    if root then
                        teleportTo(root)
                        wait(1)
                    end
                end
            end
        end
    end
end)
