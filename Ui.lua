-- ╔════════════════════════════════════════════════════════════╗
-- ║        PandX Premium v3.0 — Full Integrated Script         ║
-- ║                    Made by vex                             ║
-- ║         Junkie Key Validation + Full PandX ESP             ║
-- ╚════════════════════════════════════════════════════════════╝

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PandX_Premium"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================== CUSTOM UI ====================
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -155)
MainFrame.Size = UDim2.new(0, 420, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 200)
UIStroke.Thickness = 2.5
UIStroke.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 18)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Font = Enum.Font.GothamBlack
Title.Text = "PANDX PREMIUM"
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.TextSize = 24

local Subtitle = Instance.new("TextLabel")
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 0, 0, 48)
Subtitle.Size = UDim2.new(1, 0, 0, 18)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Expert Edition • Made by vex"
Subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
Subtitle.TextSize = 11

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
KeyInput.Position = UDim2.new(0.1, 0, 0.28, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 44)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Enter your premium key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
KeyInput.ClearTextOnFocus = false

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = KeyInput

-- Unlock Button
local UnlockBtn = Instance.new("TextButton")
UnlockBtn.Parent = MainFrame
UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
UnlockBtn.Position = UDim2.new(0.15, 0, 0.48, 0)
UnlockBtn.Size = UDim2.new(0.7, 0, 0, 42)
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.Text = "UNLOCK PREMIUM"
UnlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockBtn.TextSize = 15

local UnlockCorner = Instance.new("UICorner")
UnlockCorner.CornerRadius = UDim.new(0, 10)
UnlockCorner.Parent = UnlockBtn

-- Get Key Button
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Parent = MainFrame
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
GetKeyBtn.Position = UDim2.new(0.15, 0, 0.65, 0)
GetKeyBtn.Size = UDim2.new(0.7, 0, 0, 36)
GetKeyBtn.Font = Enum.Font.Gotham
GetKeyBtn.Text = "GET PREMIUM KEY"
GetKeyBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
GetKeyBtn.TextSize = 13

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 10)
GetKeyCorner.Parent = GetKeyBtn

-- Exit Button
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ExitBtn.Position = UDim2.new(0.15, 0, 0.82, 0)
ExitBtn.Size = UDim2.new(0.7, 0, 0, 34)
ExitBtn.Font = Enum.Font.GothamBold
ExitBtn.Text = "EXIT SCRIPT"
ExitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitBtn.TextSize = 12

local ExitCorner = Instance.new("UICorner")
ExitCorner.CornerRadius = UDim.new(0, 10)
ExitCorner.Parent = ExitBtn

-- ==================== KEY VALIDATION ====================
local SERVICE_ID = "1cda68e4-387f-49ff-a1b0-cb2433a52176"
local HttpService = game:GetService("HttpService")

local function ValidateKey(key)
    if not key or key == "" then return false end
    
    local url = "https://junkie-development.de/api/validate?service=" .. SERVICE_ID .. "&key=" .. key
    
    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    
    if success then
        local data = HttpService:JSONDecode(response)
        return data and data.valid == true
    end
    return false
end

-- ==================== BUTTON LOGIC ====================
UnlockBtn.MouseButton1Click:Connect(function()
    local key = KeyInput.Text
    
    if key == "" then
        KeyInput.PlaceholderText = "Please enter a key!"
        wait(1.5)
        KeyInput.PlaceholderText = "Enter your premium key..."
        return
    end
    
    UnlockBtn.Text = "VERIFYING..."
    UnlockBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    wait(0.8)
    
    local isValid = ValidateKey(key)
    
    if isValid then
        UnlockBtn.Text = "ACCESS GRANTED"
        UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
        wait(1)
        ScreenGui:Destroy()
        
        print("✅ PandX Premium Loaded Successfully")
        
        -- ==================== FULL PANDX ESP LOADS HERE ====================
        -- Paste your full PandX ESP code below this line
        
    else
        UnlockBtn.Text = "INVALID KEY"
        UnlockBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        wait(1.5)
        UnlockBtn.Text = "UNLOCK PREMIUM"
        UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 140)
    end
end)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/DM2wxd6K4e")
    GetKeyBtn.Text = "COPIED!"
    wait(1.5)
    GetKeyBtn.Text = "GET PREMIUM KEY"
end)

ExitBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

print("PandX Premium Key System Loaded — Made by vex")
