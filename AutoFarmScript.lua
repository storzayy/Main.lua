-- Interface by storzayy

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Brainrot Autofarm",
    LoadingTitle = "Interface by storzayy",
    LoadingSubtitle = "Script is initializing...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BrainrotAutofarm", 
        FileName = "AutoFarmSettings"
    },
    Discord = {
        Enabled = false,
        Invite = "", 
        RememberJoins = false
    },
    KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)

local allBrainrots = {
"Noobini Pizzanini","Espresso Signora","Orcalero Orcala","Tigroligre Frutonni","Pot Hotspot",
"Torrtuginni Dragonfrutini","Cocofanto Elefanto","Girafa Celestre","Gattatino Nyanino","Matteo",
"Tralalero Tralala","Odin Din Din Dun","Statutino Libertino","Trenostruzzo Turbo 3000",
"La Vacca Saturno Saturnita","Chimpanzini Spiderini","Los Tralaleritos","Las Tralaleritas",
"Graipus Medussi","La Grande Combinasion","Garama and Madundung"
}

local rareBrainrots = {
["Noobini Pizzanini"] = true,
["Cocofanto Elefanto"] = true,
["Girafa Celestre"] = true,
["Gattatino Nyanino"] = true,
["Matteo"] = true,
["Tralalero Tralala"] = true,
["Odin Din Din Dun"] = true,
["Statutino Libertino"] = true,
["Trenostruzzo Turbo 3000"] = true,
["La Vacca Saturno Saturnita"] = true,
["Chimpanzini Spiderini"] = true,
["Los Tralaleritos"] = true,
["Las Tralaleritas"] = true,
["Graipus Medussi"] = true,
["La Grande Combinasion"] = true,
["Garama and Madundung"] = true
}

local autofarm = false
local autobuy = false
local selectedBrainrot = nil

Tab:CreateDropdown({
    Name = "Select Brainrot",
    Options = allBrainrots,
    CurrentOption = "",
    Callback = function(Option)
        selectedBrainrot = Option
    end,
})

Tab:CreateToggle({
    Name = "Auto Farm Coins",
    CurrentValue = false,
    Callback = function(Value)
        autofarm = Value
        while autofarm do
            task.wait(1)
            local base = player.SpawnLocation and tonumber(player.SpawnLocation.Name)
            if base then
                local tile = workspace:FindFirstChild("AnimalPodiums")
                if tile then
                    local hitbox = tile:FindFirstChild(tostring(base)) and tile[tostring(base)]:FindFirstChild("base") and tile[tostring(base)].base:FindFirstChild("claim")
                    if hitbox and hitbox:FindFirstChild("hitbox") and hitbox.hitbox:FindFirstChild("main") then
                        local part = hitbox.hitbox.main
                        local goal = {CFrame = part.CFrame + Vector3.new(0, 5, 0)}
                        TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(1), goal):Play()
                    end
                end
            end
        end
    end,
})

Tab:CreateToggle({
    Name = "Auto Buy Rare Brainrots",
    CurrentValue = false,
    Callback = function(Value)
        autobuy = Value
        while autobuy do
            task.wait(1)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and rareBrainrots[v.Name] then
                    local part = v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local goal = {CFrame = part.CFrame + Vector3.new(0, 5, 0)}
                        TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(1), goal):Play()
                        task.wait(2)
                    end
                end
            end
        end
    end,
})

Tab:CreateButton({
    Name = "Teleport to Selected Brainrot",
    Callback = function()
        if selectedBrainrot then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == selectedBrainrot then
                    local part = v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local goal = {CFrame = part.CFrame + Vector3.new(0, 5, 0)}
                        TweenService:Create(player.Character.HumanoidRootPart, TweenInfo.new(1), goal):Play()
                        break
                    end
                end
            end
        end
    end,
})

Window:CreateTab("Changelog", 4483362458):CreateParagraph({
    Title = "v1.0",
    Content = [[
- ✅ Автофарм монет (через SpawnLocation → AnimalPodiums)
- ✅ Телепорт к выбранному Brainrot
- ✅ Автопокупка Secret и God Brainrots
- ✅ Поддержка Tween-перемещений
- ✅ Тестовая покупка Noobini Pizzanini
]]
})
