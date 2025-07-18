local Rayfield = loadstring(game:HttpGet("https://sirius.menu/sirius"))()

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")

local autofarming = false

local function safeTeleport(target)
	if not target then return end
	local goal = { CFrame = target.CFrame + Vector3.new(0, 5, 0) }
	local tween = TweenService:Create(HRP, TweenInfo.new(1, Enum.EasingStyle.Sine), goal)
	tween:Play()
end

local brainrots = {
	"Noobini Pizzanini", "Lirilì Larilà", "Tim Cheese", "Fluriflura", "Talpa Di Fero", "Svinina Bombardino",
	"Pipi Kiwi", "Trippi Troppi", "Tung Tung Tung Sahur", "Gangster Footera", "Bandito Bobritto",
	"Boneca Ambalabu", "Cacto Hipopotamo", "Ta Ta Ta Ta Sahur", "Tric Trac Baraboom",
	"Cappuccino Assassino", "Brr Brr Patapim", "Trulimero Trulicina", "Bambini Crostini",
	"Bananita Dolphinita", "Perochello Lemonchello", "Brri Brri Bicus Dicus Bombicus",
	"Burbaloni Loliloli", "Chimpanzini Bananini", "Ballerina Cappuccina", "Chef Crabracadabra",
	"Lionel Cactuseli", "Glorbo Fruttodrillo", "Blueberrinni Octopusini", "Pandaccini Bananini",
	"Frigo Camelo", "Orangutini Ananassini", "Rhino Toasterino", "Bombardiro Crocodilo",
	"Bombombini Gusini", "Cavallo Virtuoso", "Spioniro Golubiro", "Zibra Zubra Zibralini",
	"Tigrilini Watermelini", "Cocofanto Elefanto", "Girafa Celestre", "Gattatino Nyanino",
	"Matteo", "Tralalero Tralala", "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
	"Tigroligre Frutonni", "Orcalero Orcala", "La Vacca Saturno Saturnita", "Chimpanzini Spiderini",
	"Los Tralaleritos", "Las Tralaleritas", "Graipus Medussi", "La Grande Combinasion",
	"Garama and Madundung", "Torrtuginni Dragonfrutini", "Pot Hotspot"
}

local Window = Rayfield:CreateWindow({
	Name = "Interface by storzayy",
	LoadingTitle = "Interface by storzayy",
	LoadingSubtitle = "Loading...",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "StorzayyData",
		FileName = "BrainrotConfig"
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("АвтоФарм", 4483362458)

MainTab:CreateDropdown({
	Name = "Выберите Brainrot",
	Options = brainrots,
	CurrentOption = "",
	Flag = "SelectedBrainrot",
	Callback = function(Value)
		print("Выбран:", Value)
	end,
})

MainTab:CreateToggle({
	Name = "Включить AutoFarm",
	CurrentValue = false,
	Flag = "AutoFarmToggle",
	Callback = function(Value)
		autofarming = Value
		while autofarming do
			local selected = Rayfield.Flags.SelectedBrainrot.CurrentValue
			if selected and selected ~= "" then
				for _, v in pairs(workspace:GetDescendants()) do
					if v:IsA("Model") and v.Name == selected and v:FindFirstChild("HumanoidRootPart") then
						safeTeleport(v.HumanoidRootPart)
						wait(2)
						break
					end
				end
			end
			task.wait(1)
		end
	end,
})

Rayfield:LoadConfiguration()
