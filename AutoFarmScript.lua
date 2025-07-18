local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Анти-АФК
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Функция безопасного получения PlayerGui
local function getPlayerGui()
    local player = game:GetService("Players").LocalPlayer
    return player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui")
end

-- UI Config
local Window = Rayfield:CreateWindow({
	Name = "Steal a Brainrot - Autofarm | by storzayy",
	LoadingTitle = "Steal a Brainrot",
	LoadingSubtitle = "Made with ❤️",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "BrainrotAutoFarm", -- Измени по желанию
		FileName = "AutoFarmConfig"
	},
        Discord = {
           Enabled = false,
           Invite = "", 
           RememberJoins = true
        },
        KeySystem = false,
})

-- Переменные
local TeleportService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local selectedBrainrot = nil

-- Телепортация к brainrot
local function safeTeleport(position)
	local tween = TeleportService:Create(humanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(position)})
	tween:Play()
	tween.Completed:Wait()
end

-- Пример списка brainrots (замени на свой список)
local brainrots = {
	"Noobini Pizzanini", "Cocofanto Elefanto", "Girafa Celestre",
	"Tralalero Tralala", "Matteo", "Odin Din Din Dun",
	"Statutino Libertino", "Trenostruzzo Turbo 3000",
	"La Vacca Saturno Saturnita", "Graipus Medussi", "Garama and Madundung"
}

-- Dropdown с brainrots
local Dropdown = Window:CreateDropdown({
	Name = "Выбрать Brainrot для телепорта",
	Options = brainrots,
	CurrentOption = "",
	Flag = "BrainrotDropdown",
	Callback = function(Option)
		selectedBrainrot = Option
	end,
})

-- Кнопка телепорта
Window:CreateButton({
	Name = "Телепорт к выбранному Brainrot",
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

-- Автофарм монет с тайла
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

-- Тоггл автосбора монет
Window:CreateToggle({
	Name = "Авто сбор монет",
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
