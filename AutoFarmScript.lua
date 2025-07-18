# Подготовка полного скрипта с учётом всех пожеланий пользователя и Brainrot'ов

brainrots = [
    "Noobini Pizzanini", "Lirilì Larilà", "Tim Cheese", "Fluriflura", "Talpa Di Fero", "Svinina Bombardino", "Pipi Kiwi",
    "Trippi Troppi", "Tung Tung Tung Sahur", "Gangster Footera", "Bandito Bobritto", "Boneca Ambalabu", "Cacto Hipopotamo",
    "Ta Ta Ta Ta Sahur", "Tric Trac Baraboom", "Cappuccino Assassino", "Brr Brr Patapim", "Trulimero Trulicina", "Bambini Crostini",
    "Bananita Dolphinita", "Perochello Lemonchello", "Brri Brri Bicus Dicus Bombicus", "Burbaloni Loliloli", "Chimpanzini Bananini",
    "Ballerina Cappuccina", "Chef Crabracadabra", "Lionel Cactuseli", "Glorbo Fruttodrillo", "Blueberrinni Octopusini",
    "Pandaccini Bananini", "Frigo Camelo", "Orangutini Ananassini", "Rhino Toasterino", "Bombardiro Crocodilo", "Bombombini Gusini",
    "Cavallo Virtuoso", "Spioniro Golubiro", "Zibra Zubra Zibralini", "Tigrilini Watermelini", "Cocofanto Elefanto", "Girafa Celestre",
    "Gattatino Nyanino", "Matteo", "Tralalero Tralala", "Odin Din Din Dun", "Statutino Libertino", "Trenostruzzo Turbo 3000",
    "Tigroligre Frutonni", "Orcalero Orcala", "La Vacca Saturno Saturnita", "Chimpanzini Spiderini", "Los Tralaleritos",
    "Las Tralaleritas", "Graipus Medussi", "La Grande Combinasion", "Garama and Madundung", "Torrtuginni Dragonfrutini", "Pot Hotspot"
]

# Генерация текста Lua-скрипта с Rayfield UI, dropdown и auto-teleport
dropdown_entries = ",\n            ".join(f'"{name}"' for name in brainrots)

final_script = f'''
-- AutoFarm Script for "Steal a Brainrot" by storzayy
-- Version: 1.0.0
-- Changelog:
-- + Rayfield UI
-- + Dropdown list of all Brainrots
-- + Safe teleport using TweenService
-- + Auto return to original position

-- Loadstring-Ready
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({{
   Name = "Interface by storzayy",
   LoadingTitle = "AutoFarm Loader",
   LoadingSubtitle = "by storzayy",
   ConfigurationSaving = {{
      Enabled = true,
      FolderName = "BrainrotFarm",
      FileName = "AutoFarmSettings"
   }},
   Discord = {{
      Enabled = false
   }},
   KeySystem = false
}})

local autofarming = false
local selectedBrainrot = nil

local MainTab = Window:CreateTab("AutoFarm", 4483362458)

MainTab:CreateDropdown({{
    Name = "Select Brainrot",
    Options = {{
        {dropdown_entries}
    }},
    CurrentOption = "",
    Callback = function(Option)
        selectedBrainrot = Option
    end
}})

MainTab:CreateToggle({{
    Name = "Enable AutoFarm",
    CurrentValue = false,
    Callback = function(Value)
        autofarming = Value
        if Value then
            Rayfield:Notify({{
               Title = "AutoFarm",
               Content = "AutoFarm Enabled",
               Duration = 4
            }})
            spawn(function()
                while autofarming do
                    if selectedBrainrot then
                        local brainrot = nil
                        for _,v in pairs(game:GetService("Workspace").Tiles:GetDescendants()) do
                            if v.Name == selectedBrainrot then
                                brainrot = v
                                break
                            end
                        end
                        if brainrot then
                            local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
                            local originalPos = root.Position

                            local tween = game:GetService("TweenService"):Create(
                                root,
                                TweenInfo.new((root.Position - brainrot.Position).Magnitude / 100, Enum.EasingStyle.Linear),
                                {{CFrame = CFrame.new(brainrot.Position)}}
                            )
                            tween:Play()
                            tween.Completed:Wait()
                            wait(1)
                            local tweenBack = game:GetService("TweenService"):Create(
                                root,
                                TweenInfo.new((originalPos - brainrot.Position).Magnitude / 100, Enum.EasingStyle.Linear),
                                {{CFrame = CFrame.new(originalPos)}}
                            )
                            tweenBack:Play()
                            tweenBack.Completed:Wait()
                            wait(2)
                        end
                    end
                    wait(0.5)
                end
            end)
        else
            Rayfield:Notify({{
               Title = "AutoFarm",
               Content = "AutoFarm Disabled",
               Duration = 4
            }})
        end
    end
}})
'''
