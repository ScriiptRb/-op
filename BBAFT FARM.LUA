local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Переменные
local farmActive = true
local waitTime = 5
local speed = 50

-- Функция телепорта к сундуку
local function teleportToChest()
    local chest = nil
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Part") and v.Name:find("Chest") then
            chest = v
            break
        end
    end
    if chest then
        rootPart.CFrame = chest.CFrame + Vector3.new(0, 5, 0)
        wait(1)
        firetouchinterest(rootPart, chest, 0)
        wait(0.5)
        firetouchinterest(rootPart, chest, 1)
    end
end

-- Функция респавна (если упал)
local function respawn()
    if character and humanoid.Health <= 0 then
        player:LoadCharacter()
        wait(3)
    end
end

-- Основной цикл
spawn(function()
    while farmActive do
        teleportToChest()
        wait(waitTime)
        respawn()
        wait(1)
    end
end)

-- ГУИ панель (удобно управлять)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "BABFT Фарм v1.0"
title.TextColor3 = Color3.fromRGB(255, 200, 50)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
toggleBtn.Text = "Остановить"
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 16
toggleBtn.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0.75, 0)
status.Text = "✅ Работает"
status.TextColor3 = Color3.fromRGB(0, 255, 100)
status.BackgroundTransparency = 1
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.Parent = frame

toggleBtn.MouseButton1Click:Connect(function()
    farmActive = not farmActive
    if farmActive then
        toggleBtn.Text = "Остановить"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        status.Text = "✅ Работает"
        status.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        toggleBtn.Text = "Запустить"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        status.Text = "⏸ Остановлен"
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
    end
end)

print("[BABFT] Автофарм загружен! Управляй через ГУИ.")
