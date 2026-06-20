local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local SpawnRemote = ReplicatedStorage:WaitForChild("SpawnCar")
local GiveMoneyEvent = ReplicatedStorage:WaitForChild("GiveMoneyEvent")

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "NovaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 10

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 520)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -260)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 15)

-- Aesthetic Glow
local Glow = Instance.new("ImageLabel", MainFrame)
Glow.Name = "Glow"
Glow.BackgroundTransparency = 1
Glow.Position = UDim2.new(0, -15, 0, -15)
Glow.Size = UDim2.new(1, 30, 1, 30)
Glow.ZIndex = 0
Glow.Image = "rbxassetid://4996891991"
Glow.ImageColor3 = Color3.fromRGB(0, 140, 255)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(20, 20, 280, 280)

local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.Text = "NovaHub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

-- Rainbow Title Effect
task.spawn(function()
    while task.wait() do
        local hue = tick() % 5 / 5
        Title.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
    end
end)

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, 0, 0, 45)
TabBar.Position = UDim2.new(0, 0, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabBar.BorderSizePixel = 0

local function CreateTab(name, pos)
    local btn = Instance.new("TextButton", TabBar)
    btn.Size = UDim2.new(0.333, 0, 1, 0)
    btn.Position = UDim2.new(pos, 0, 0, 0)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.TextColor3 = Color3.new(0.5, 0.5, 0.5)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    return btn
end

local CarTabBtn = CreateTab("CARS", 0)
local MoneyTabBtn = CreateTab("MONEY", 0.333)
local SettingsTabBtn = CreateTab("SETTINGS", 0.666)
CarTabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CarTabBtn.TextColor3 = Color3.new(1, 1, 1)

local CarPage = Instance.new("Frame", MainFrame)
CarPage.Size = UDim2.new(1, -30, 1, -110)
CarPage.Position = UDim2.new(0, 15, 0, 105)
CarPage.BackgroundTransparency = 1

local MoneyPage = Instance.new("Frame", MainFrame)
MoneyPage.Size = UDim2.new(1, -30, 1, -110)
MoneyPage.Position = UDim2.new(0, 15, 0, 105)
MoneyPage.BackgroundTransparency = 1
MoneyPage.Visible = false

local SettingsPage = Instance.new("Frame", MainFrame)
SettingsPage.Size = UDim2.new(1, -30, 1, -110)
SettingsPage.Position = UDim2.new(0, 15, 0, 105)
SettingsPage.BackgroundTransparency = 1
SettingsPage.Visible = false

-- CAR PAGE
local CarWipNote = Instance.new("TextLabel", CarPage)
CarWipNote.Size = UDim2.new(1, 0, 0, 30)
CarWipNote.Text = "SOME CARS WONT SPAWN (WIP)"
CarWipNote.TextColor3 = Color3.fromRGB(255, 200, 50)
CarWipNote.Font = Enum.Font.GothamBold
CarWipNote.TextSize = 15
CarWipNote.BackgroundTransparency = 1

local DropdownBtn = Instance.new("TextButton", CarPage)
DropdownBtn.Size = UDim2.new(1, 0, 0, 50)
DropdownBtn.Position = UDim2.new(0, 0, 0, 35)
DropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
DropdownBtn.Text = "Select a Car..."
DropdownBtn.TextColor3 = Color3.new(1, 1, 1)
DropdownBtn.Font = Enum.Font.GothamMedium
DropdownBtn.TextSize = 18
DropdownBtn.BorderSizePixel = 0
Instance.new("UICorner", DropdownBtn)

local ScrollFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollFrame.Size = UDim2.new(0, 320, 0, 250)
ScrollFrame.Position = UDim2.new(0, 15, 0, 195)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ScrollFrame.Visible = false
ScrollFrame.ZIndex = 100
ScrollFrame.ScrollBarThickness = 0
Instance.new("UICorner", ScrollFrame)
Instance.new("UIListLayout", ScrollFrame).Padding = UDim.new(0, 5)

local SpawnBtn = Instance.new("TextButton", CarPage)
SpawnBtn.Size = UDim2.new(1, 0, 0, 60)
SpawnBtn.Position = UDim2.new(0, 0, 1, -65)
SpawnBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
SpawnBtn.Text = "SPAWN VEHICLE"
SpawnBtn.TextColor3 = Color3.new(1, 1, 1)
SpawnBtn.Font = Enum.Font.GothamBold
SpawnBtn.TextSize = 20
Instance.new("UICorner", SpawnBtn)

-- MONEY PAGE
local MoneyNote = Instance.new("TextLabel", MoneyPage)
MoneyNote.Size = UDim2.new(1, 0, 0, 30)
MoneyNote.Text = "MUST BE IN A CAR FOR THIS TO WORK"
MoneyNote.TextColor3 = Color3.fromRGB(255, 60, 60)
MoneyNote.Font = Enum.Font.GothamBold
MoneyNote.TextSize = 15
MoneyNote.BackgroundTransparency = 1

local MoneyNote2 = Instance.new("TextLabel", MoneyPage)
MoneyNote2.Size = UDim2.new(1, 0, 0, 20)
MoneyNote2.Position = UDim2.new(0, 0, 0, 30)
MoneyNote2.Text = "(ALL METHODS GIVE ONLY 2500)"
MoneyNote2.TextColor3 = Color3.new(1, 1, 1)
MoneyNote2.Font = Enum.Font.GothamBold
MoneyNote2.TextSize = 13
MoneyNote2.BackgroundTransparency = 1

local MethodBtn = Instance.new("TextButton", MoneyPage)
MethodBtn.Size = UDim2.new(1, 0, 0, 50)
MethodBtn.Position = UDim2.new(0, 0, 0, 70)
MethodBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MethodBtn.Text = "Method: Driving income"
MethodBtn.TextColor3 = Color3.new(1, 1, 1)
MethodBtn.Font = Enum.Font.GothamMedium
MethodBtn.TextSize = 18
Instance.new("UICorner", MethodBtn)

local MethodScroll = Instance.new("ScrollingFrame", MainFrame)
MethodScroll.Size = UDim2.new(0, 320, 0, 125)
MethodScroll.Position = UDim2.new(0, 15, 0, 230)
MethodScroll.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MethodScroll.Visible = false
MethodScroll.ZIndex = 101
MethodScroll.ScrollBarThickness = 0
Instance.new("UICorner", MethodScroll)
Instance.new("UIListLayout", MethodScroll).Padding = UDim.new(0, 5)

local MoneyToggleBtn = Instance.new("TextButton", MoneyPage)
MoneyToggleBtn.Size = UDim2.new(1, 0, 0, 70)
MoneyToggleBtn.Position = UDim2.new(0, 0, 1, -75)
MoneyToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
MoneyToggleBtn.Text = "LOOP MONEY: OFF"
MoneyToggleBtn.TextColor3 = Color3.new(1, 1, 1)
MoneyToggleBtn.Font = Enum.Font.GothamBold
MoneyToggleBtn.TextSize = 20
Instance.new("UICorner", MoneyToggleBtn)

-- SETTINGS PAGE
local CreditLabel = Instance.new("TextLabel", SettingsPage)
CreditLabel.Size = UDim2.new(1, 0, 0, 30)
CreditLabel.Text = "Made By Slammy"
CreditLabel.TextColor3 = Color3.new(1, 1, 1)
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.TextSize = 20
CreditLabel.BackgroundTransparency = 1

local AntiAfkBtn = Instance.new("TextButton", SettingsPage)
AntiAfkBtn.Size = UDim2.new(1, 0, 0, 45)
AntiAfkBtn.Position = UDim2.new(0, 0, 0, 40)
AntiAfkBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
AntiAfkBtn.Text = "ANTI-AFK: OFF"
AntiAfkBtn.TextColor3 = Color3.new(1, 1, 1)
AntiAfkBtn.Font = Enum.Font.GothamBold
AntiAfkBtn.TextSize = 16
Instance.new("UICorner", AntiAfkBtn)

-- Custom Add: Walkspeed Boost
local SpeedBtn = Instance.new("TextButton", SettingsPage)
SpeedBtn.Size = UDim2.new(1, 0, 0, 45)
SpeedBtn.Position = UDim2.new(0, 0, 0, 95)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBtn.Text = "Walkspeed: Default"
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.TextSize = 16
Instance.new("UICorner", SpeedBtn)

local ExitBtn = Instance.new("TextButton", SettingsPage)
ExitBtn.Size = UDim2.new(1, 0, 0, 60)
ExitBtn.Position = UDim2.new(0, 0, 1, -65)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ExitBtn.Text = "CLOSE GUI"
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.TextSize = 20
Instance.new("UICorner", ExitBtn)

-- LOGIC
local cars = {
    {n = "BWM e36 M3", p = 0}, {n = "Matalan Arrow", p = 4000000}, {n = "Ladybug Riva", p = 3000}, 
    {n = "Cobra Simvy", p = 3200}, {n = "Bayone P20 G3", p = 5000}, {n = "Taryvet Sunstorm", p = 6200}, 
    {n = "Bayone P25 G5", p = 7500}, {n = "Yuzu 125", p = 10000}, {n = "Taryvet Chased", p = 10500}, 
    {n = "Nivlon Dilvia D1", p = 15000}, {n = "Nivlon D65", p = 18000}, {n = "Nivlon Dilvia D2", p = 21000}, 
    {n = "Wulks Tull", p = 28500}, {n = "Kawi N300", p = 30000}, {n = "Nivlon D700", p = 32000}, 
    {n = "Nivlon GR32", p = 40000}, {n = "Dizzy RG7", p = 42000}, {n = "Surudu Impressive", p = 44500}, 
    {n = "Taryvet Sub TK3", p = 45000}, {n = "Nivlon GR34", p = 50000}, {n = "Mercury GB70", p = 50000}, 
    {n = "Crystal 300", p = 60000}, {n = "Peturn C670", p = 60000}, {n = "Force Horse", p = 70000}, 
    {n = "Mercury CGB90", p = 75000}, {n = "Mercury GA70", p = 80000}, {n = "Tay R6", p = 80000}, 
    {n = "Destruct Wire", p = 85000}, {n = "Bayone G2", p = 86000}, {n = "Destruct Quest", p = 95000}, 
    {n = "Force Failtan", p = 98500}, {n = "Cherry Camo", p = 115000}, {n = "Bayone G4", p = 120000}, 
    {n = "Bayone P70 G5", p = 125000}, {n = "Taryvet Sub TK5", p = 130000}, {n = "Bayone UV", p = 145000}, 
    {n = "Gravel RH", p = 150000}, {n = "Destruct Snake", p = 150000}, {n = "Rex Tour", p = 175000}, 
    {n = "Bayone P90 G3", p = 180000}, {n = "Candy Escape", p = 206000}, {n = "Bayone XT5", p = 210000}, 
    {n = "Taturn ER1", p = 225000}, {n = "AVANT K6", p = 227000}, {n = "Nivlon GR5", p = 249000}, 
    {n = "Bayone G4 DLR", p = 254000}, {n = "Peturn GV3", p = 255000}, {n = "Lureo Tornado", p = 280000}, 
    {n = "Taturn DC8", p = 285000}, {n = "AVANT AR8", p = 295500}, {n = "Cobra TBRR", p = 300000}, 
    {n = "Mercury H", p = 300000}, {n = "Lureo SUV", p = 378950}, {n = "Royal Rings Cost", p = 400000}, 
    {n = "LEZ L5", p = 445000}, {n = "Mercury HSPORT", p = 498950}, {n = "Force G7T", p = 500000}, 
    {n = "Mercury Matalan Silk", p = 670500}, {n = "Tropical Luxury", p = 675000}, {n = "Lureo Aware", p = 855000}, 
    {n = "Peturn Reptile", p = 970000}, {n = "Tropical futuro", p = 999999}, {n = "Pigeon zebra UR", p = 1400000}, 
    {n = "Matalan GV1", p = 1500000}, {n = "Mercury Luxus 6x6", p = 1700000}, {n = "Matalan Speed", p = 1750000}, 
    {n = "Matalan UV1", p = 2000000}, {n = "Koning AGT", p = 2200000}, {n = "Howler VT5", p = 2500000}, 
    {n = "Butaro Wayo", p = 2500000}, {n = "Pigeon hyena GR", p = 2600000}, {n = "Koning JRT", p = 3000000}, 
    {n = "Lureo Courage", p = 3000000}, {n = "Koning AGT II", p = 3250000}, {n = "Koning Ultraspeed", p = 3680000}, 
    {n = "Lureo Versus", p = 4400000}, {n = "Butaro CE", p = 5259000}, {n = "Butaro AVO", p = 5800000}, 
    {n = "Butaro Avaran", p = 8200000}, {n = "Butaro Bowler", p = 14500000}, {n = "Evil Sixteen", p = 21000000}
}
table.sort(cars, function(a, b) return a.p < b.p end)

local function SwitchPage(show)
    CarPage.Visible = (show == CarPage)
    MoneyPage.Visible = (show == MoneyPage)
    SettingsPage.Visible = (show == SettingsPage)
    ScrollFrame.Visible = false
    MethodScroll.Visible = false
    
    CarTabBtn.BackgroundColor3 = (show == CarPage) and Color3.fromRGB(35,35,35) or Color3.fromRGB(20,20,20)
    MoneyTabBtn.BackgroundColor3 = (show == MoneyPage) and Color3.fromRGB(35,35,35) or Color3.fromRGB(20,20,20)
    SettingsTabBtn.BackgroundColor3 = (show == SettingsPage) and Color3.fromRGB(35,35,35) or Color3.fromRGB(20,20,20)
    
    CarTabBtn.TextColor3 = (show == CarPage) and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
    MoneyTabBtn.TextColor3 = (show == MoneyPage) and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
    SettingsTabBtn.TextColor3 = (show == SettingsPage) and Color3.new(1,1,1) or Color3.new(0.5,0.5,0.5)
end

CarTabBtn.MouseButton1Click:Connect(function() SwitchPage(CarPage) end)
MoneyTabBtn.MouseButton1Click:Connect(function() SwitchPage(MoneyPage) end)
SettingsTabBtn.MouseButton1Click:Connect(function() SwitchPage(SettingsPage) end)

local SelectedCar = ""
for _, car in ipairs(cars) do
    local b = Instance.new("TextButton", ScrollFrame)
    b.Size = UDim2.new(1, -10, 0, 45)
    b.Text = car.n .. " ($" .. tostring(car.p) .. ")"
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 15
    b.ZIndex = 101
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedCar = car.n
        DropdownBtn.Text = car.n
        ScrollFrame.Visible = false
    end)
end
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #cars * 50)

DropdownBtn.MouseButton1Click:Connect(function() ScrollFrame.Visible = not ScrollFrame.Visible end)
SpawnBtn.MouseButton1Click:Connect(function() 
    if SelectedCar ~= "" then SpawnRemote:FireServer(SelectedCar .. " - Stock") end 
end)

local currentMethod = "Driving income"
local methods = {"Driving income", "Close call!", "Overtake!"}
for _, m in ipairs(methods) do
    local b = Instance.new("TextButton", MethodScroll)
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Text = m
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.ZIndex = 102
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        currentMethod = m
        MethodBtn.Text = "Method: " .. m
        MethodScroll.Visible = false
    end)
end
MethodScroll.CanvasSize = UDim2.new(0, 0, 0, #methods * 45)
MethodBtn.MouseButton1Click:Connect(function() MethodScroll.Visible = not MethodScroll.Visible end)

local moneyLooping = false
MoneyToggleBtn.MouseButton1Click:Connect(function()
    moneyLooping = not moneyLooping
    MoneyToggleBtn.Text = moneyLooping and "LOOP MONEY: ON" or "LOOP MONEY: OFF"
    MoneyToggleBtn.BackgroundColor3 = moneyLooping and Color3.fromRGB(20, 80, 50) or Color3.fromRGB(50, 20, 20)
    if moneyLooping then
        task.spawn(function()
            while moneyLooping do
                GiveMoneyEvent:FireServer(5500, currentMethod)
                task.wait(1)
            end
        end)
    end
end)

local antiAfkEnabled = false
AntiAfkBtn.MouseButton1Click:Connect(function()
    antiAfkEnabled = not antiAfkEnabled
    AntiAfkBtn.Text = antiAfkEnabled and "ANTI-AFK: ON" or "ANTI-AFK: OFF"
    AntiAfkBtn.BackgroundColor3 = antiAfkEnabled and Color3.fromRGB(20, 80, 50) or Color3.fromRGB(50, 20, 20)
end)

Player.Idled:Connect(function()
    if antiAfkEnabled then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

local speeds = {16, 50, 100, 250}
local currentSpeedIdx = 1
SpeedBtn.MouseButton1Click:Connect(function()
    currentSpeedIdx = currentSpeedIdx % #speeds + 1
    local s = speeds[currentSpeedIdx]
    Player.Character.Humanoid.WalkSpeed = s
    SpeedBtn.Text = "Walkspeed: " .. (s == 16 and "Default" or s)
end)

ExitBtn.MouseButton1Click:Connect(function()
    moneyLooping = false
    antiAfkEnabled = false
    ScreenGui:Destroy()
end)
