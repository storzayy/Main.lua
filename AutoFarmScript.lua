-- AutoFarmScript.lua
-- Created by storzayy ❤️

-- Anti‑AFK
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua"))()

-- Initial loading notification
local Window = Rayfield:CreateWindow({
    Name = "Steal a Brainrot Autofarm",
    LoadingTitle = "Loading Interface",
    LoadingSubtitle = "Made with ❤️ by storzayy",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotConfig",
        FileName = "AutoFarmSettings"
    },
    Discord = { Enabled = false },
    KeySystem = false
})

-- Variables
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

local AutoTeleport = false
local AutoBuy = false
local AutoCollect = false
local SelectedBrainrot = nil

-- Brainrot lists
local RareBrainrots = {
    ["Noobini Pizzanini"] = true, ["Cocofanto Elefanto"] = true, ["Girafa Celestre"] = true,
    ["Gattatino Nyanino"] = true, ["Matteo"] = true, ["Tralalero Tralala"] = true,
    ["Odin Din Din Dun"] = true, ["Statutino Libertino"] = true, ["Trenostruzzo Turbo 3000"] = true,
    ["La Vacca Saturno Saturnita"] = true, ["Chimpanzini Spiderini"] = true,
    ["Los Tralaleritos"] = true, ["Las Tralaleritas"] = true, ["Graipus Medussi"] = true,
    ["La Grande Combinasion"] = true, ["Garama and Madundung"] = true
}

local AllBrainrots = {
    "Noobini Pizzanini", "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino", "Matteo",
    "Tralalero Tralala", "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
    "La Vacca Saturno Saturnita", "Chimpanzini Spiderini", "Los Tralaleritos", "Las Tralaleritas",
    "Graipus Medussi", "La Grande Combinasion", "Garama and Madundung"
}

-- Safe tween teleport function
local function safeTeleport(posCFrame)
    TweenService:Create(HRP, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = posCFrame}):Play()
end

-- Auto‑teleport loop
task.spawn(function()
    while task.wait(1) do
        if AutoTeleport and SelectedBrainrot then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj.Name == SelectedBrainrot then
                    local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                    if root then safeTeleport(root.CFrame + Vector3.new(0,5,0)) end
                end
            end
        end
    end
end)

-- Auto‑buy rare brainrots loop
task.spawn(function()
    while task.wait(2) do
        if AutoBuy then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and RareBrainrots[obj.Name] then
                    local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                    if root then
                        safeTeleport(root.CFrame + Vector3.new(0,5,0))
                        task.wait(1)
                        -- fire buy if prompt exists
                        local prompt = root:FindFirstChildOfClass("ProximityPrompt")
                        if prompt then prompt:InputHoldBegin() task.wait(0.5) prompt:InputHoldEnd() end
                    end
                end
            end
        end
    end
end)

-- Auto‑collect cash loop
task.spawn(function()
    while task.wait(3) do
        if AutoCollect then
            local baseNum = LocalPlayer:FindFirstChild("SpawnLocation") and LocalPlayer.SpawnLocation.Value or 1
            local path = Workspace:FindFirstChild("AnimalPodiums")
            if path and path:FindFirstChild(tostring(baseNum)) then
                local main = path[tostring(baseNum)]:FindFirstChild("base"):FindFirstChild("claim"):FindFirstChild("hitbox"):FindFirstChild("main")
                if main and main:IsA("BasePart") then
                    safeTeleport(main.CFrame + Vector3.new(0,5,0))
                    firetouchinterest(HRP, main, 0)
                    firetouchinterest(HRP, main, 1)
                end
            end
        end
    end
end)

-- UI elements
local MainTab = Window:CreateTab("Main", 4483362458)
MainTab:CreateDropdown({
    Name = "Select Brainrot",
    Options = AllBrainrots,
    CurrentOption = "",
    Callback = function(v) SelectedBrainrot = v end
})
MainTab:CreateToggle({
    Name = "Auto Teleport to Selected",
    CurrentValue = false,
    Callback = function(v) AutoTeleport = v end
})
MainTab:CreateToggle({
    Name = "Auto Buy Rare Brainrots",
    CurrentValue = false,
    Callback = function(v) AutoBuy = v end
})
MainTab:CreateToggle({
    Name = "Auto Collect Cash/Money",
    CurrentValue = false,
    Callback = function(v) AutoCollect = v end
})
MainTab:CreateParagraph({
    Title = "Made with ❤️",
    Content = "by storzayy"
})

Rayfield:LoadConfiguration()
