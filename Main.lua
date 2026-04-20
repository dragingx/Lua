-- ╔════════════════════════════════════════════════════════════╗
-- ║                    PandX v5.0 — ESP                        ║
-- ║                    Made by vex                             ║
-- ║              Best Rayfield ESP for Roblox                  ║
-- ╚════════════════════════════════════════════════════════════╝

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PandX | AIMBOT",
   LoadingTitle = "PandX",
   LoadingSubtitle = "Made by vex • ",
   ConfigurationSaving = { Enabled = true, FolderName = "PandX" },
   Discord = { Enabled = false },
   KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- Settings
getgenv().PandX = {
    Enabled = false,
    TeamCheck = false,
    VisibleCheck = false,
    BoxESP = true,
    NameESP = true,
    HealthESP = true,
    DistanceESP = true,
    TracerESP = false,
    SkeletonESP = false,
    ShowFOV = false,
    FOVRadius = 150,
    HighlightTarget = false,
    Color = Color3.fromRGB(0, 255, 200)
}

-- Rayfield Tabs
local MainTab = Window:CreateTab("Main", 4483362748)
local VisualTab = Window:CreateTab("Visuals", 4483362748)
local SettingsTab = Window:CreateTab("Settings", 4483362748)

-- Main Tab
MainTab:CreateToggle({
   Name = "Enable ESP",
   CurrentValue = false,
   Flag = "ESPEnabled",
   Callback = function(Value)
      getgenv().PandX.Enabled = Value
   end
})

MainTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = false,
   Flag = "TeamCheck",
   Callback = function(Value)
      getgenv().PandX.TeamCheck = Value
   end
})

MainTab:CreateToggle({
   Name = "Visible Check",
   CurrentValue = false,
   Flag = "VisibleCheck",
   Callback = function(Value)
      getgenv().PandX.VisibleCheck = Value
   end
})

-- Visual Tab
VisualTab:CreateToggle({
   Name = "Box ESP",
   CurrentValue = true,
   Flag = "BoxESP",
   Callback = function(Value) getgenv().PandX.BoxESP = Value end
})

VisualTab:CreateToggle({
   Name = "Name ESP",
   CurrentValue = true,
   Flag = "NameESP",
   Callback = function(Value) getgenv().PandX.NameESP = Value end
})

VisualTab:CreateToggle({
   Name = "Health ESP",
   CurrentValue = true,
   Flag = "HealthESP",
   Callback = function(Value) getgenv().PandX.HealthESP = Value end
})

VisualTab:CreateToggle({
   Name = "Distance ESP",
   CurrentValue = true,
   Flag = "DistanceESP",
   Callback = function(Value) getgenv().PandX.DistanceESP = Value end
})

VisualTab:CreateToggle({
   Name = "Tracer ESP",
   CurrentValue = false,
   Flag = "TracerESP",
   Callback = function(Value) getgenv().PandX.TracerESP = Value end
})

VisualTab:CreateToggle({
   Name = "Skeleton ESP",
   CurrentValue = false,
   Flag = "SkeletonESP",
   Callback = function(Value) getgenv().PandX.SkeletonESP = Value end
})

VisualTab:CreateToggle({
   Name = "Show FOV Circle",
   CurrentValue = false,
   Flag = "ShowFOV",
   Callback = function(Value) getgenv().PandX.ShowFOV = Value end
})

VisualTab:CreateSlider({
   Name = "FOV Radius",
   Range = {50, 500},
   Increment = 5,
   CurrentValue = 150,
   Flag = "FOVRadius",
   Callback = function(Value) getgenv().PandX.FOVRadius = Value end
})

VisualTab:CreateToggle({
   Name = "Highlight Closest Target",
   CurrentValue = false,
   Flag = "HighlightTarget",
   Callback = function(Value) getgenv().PandX.HighlightTarget = Value end
})

VisualTab:CreateColorPicker({
   Name = "ESP Color",
   Color = Color3.fromRGB(0, 255, 200),
   Flag = "ESPColor",
   Callback = function(Value) getgenv().PandX.Color = Value end
})

-- Settings Tab
SettingsTab:CreateButton({
   Name = "Destroy PandX",
   Callback = function()
      for _, v in pairs(getgenv().PandX_Drawings or {}) do
         if v then for _, obj in pairs(v) do if obj then obj:Remove() end end end
      end
      Window:Destroy()
   end
})

SettingsTab:CreateLabel("Made by vex • PandX v5.0")
SettingsTab:CreateLabel("Best ESP UI in 2026")

-- Drawing Setup
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.NumSides = 100
FOVCircle.Filled = false
FOVCircle.Visible = false
FOVCircle.ZIndex = 999

local TargetHighlight = Drawing.new("Square")
TargetHighlight.Thickness = 2.5
TargetHighlight.Filled = false
TargetHighlight.Visible = false
TargetHighlight.ZIndex = 999

getgenv().PandX_Drawings = {}

local function CreateESP(Player)
   if getgenv().PandX_Drawings[Player] then return end
   
   local Box = Drawing.new("Square")
   Box.Thickness = 1.5
   Box.Filled = false
   Box.Visible = false
   Box.ZIndex = 2
   
   local Name = Drawing.new("Text")
   Name.Center = true
   Name.Outline = true
   Name.Size = 14
   Name.Visible = false
   Name.ZIndex = 3
   
   local HealthBar = Drawing.new("Square")
   HealthBar.Thickness = 1
   HealthBar.Filled = true
   HealthBar.Visible = false
   HealthBar.ZIndex = 2
   
   local Distance = Drawing.new("Text")
   Distance.Center = true
   Distance.Outline = true
   Distance.Size = 12
   Distance.Visible = false
   Distance.ZIndex = 3
   
   local Tracer = Drawing.new("Line")
   Tracer.Thickness = 1.5
   Tracer.Visible = false
   Tracer.ZIndex = 1
   
   getgenv().PandX_Drawings[Player] = {
      Box = Box, Name = Name, Health = HealthBar, 
      Distance = Distance, Tracer = Tracer
   }
end

local function RemoveESP(Player)
   if getgenv().PandX_Drawings[Player] then
      for _, v in pairs(getgenv().PandX_Drawings[Player]) do
         if v then v:Remove() end
      end
      getgenv().PandX_Drawings[Player] = nil
   end
end

-- Main ESP Loop
RunService.RenderStepped:Connect(function()
   local Settings = getgenv().PandX
   
   if not Settings.Enabled then 
      FOVCircle.Visible = false
      TargetHighlight.Visible = false
      return 
   end
   
   -- FOV Circle
   FOVCircle.Visible = Settings.ShowFOV
   FOVCircle.Radius = Settings.FOVRadius
   FOVCircle.Position = game:GetService("UserInputService"):GetMouseLocation()
   FOVCircle.Color = Settings.Color
   
   local MousePos = game:GetService("UserInputService"):GetMouseLocation()
   local ClosestPlayer = nil
   local ClosestDist = math.huge
   
   for _, Player in ipairs(Players:GetPlayers()) do
      if Player == LocalPlayer or not Player.Character then 
         RemoveESP(Player)
         continue 
      end
      
      local Character = Player.Character
      local Humanoid = Character:FindFirstChild("Humanoid")
      local Root = Character:FindFirstChild("HumanoidRootPart")
      
      if not Humanoid or not Root or Humanoid.Health <= 0 then 
         RemoveESP(Player)
         continue 
      end
      
      if Settings.TeamCheck and Player.Team == LocalPlayer.Team then continue end
      
      if Settings.VisibleCheck then
         local ray = Ray.new(Camera.CFrame.Position, (Root.Position - Camera.CFrame.Position).Unit * 5000)
         local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Character})
         if hit and not hit:IsDescendantOf(Character) then continue end
      end
      
      local ScreenPos, OnScreen = Camera:WorldToViewportPoint(Root.Position)
      if not OnScreen then 
         RemoveESP(Player)
         continue 
      end
      
      local Dist = (Vector2.new(ScreenPos.X, ScreenPos.Y) - MousePos).Magnitude
      if Dist < ClosestDist then
         ClosestDist = Dist
         ClosestPlayer = Player
      end
      
      if not getgenv().PandX_Drawings[Player] then
         CreateESP(Player)
      end
      
      local ESP = getgenv().PandX_Drawings[Player]
      if not ESP then continue end
      
      local BoxSize = Vector2.new(2800 / ScreenPos.Z, 3800 / ScreenPos.Z)
      local BoxPos = Vector2.new(ScreenPos.X - BoxSize.X / 2, ScreenPos.Y - BoxSize.Y / 2)
      
      -- Box ESP
      if Settings.BoxESP then
         ESP.Box.Visible = true
         ESP.Box.Size = BoxSize
         ESP.Box.Position = BoxPos
         ESP.Box.Color = Settings.Color
      else
         ESP.Box.Visible = false
      end
      
      -- Name ESP
      if Settings.NameESP then
         ESP.Name.Visible = true
         ESP.Name.Text = Player.Name
         ESP.Name.Position = Vector2.new(ScreenPos.X, BoxPos.Y - 20)
         ESP.Name.Color = Settings.Color
      else
         ESP.Name.Visible = false
      end
      
      -- Health ESP
      if Settings.HealthESP and Humanoid then
         local HealthPercent = Humanoid.Health / Humanoid.MaxHealth
         ESP.Health.Visible = true
         ESP.Health.Size = Vector2.new(4, BoxSize.Y * HealthPercent)
         ESP.Health.Position = Vector2.new(BoxPos.X - 10, BoxPos.Y + (BoxSize.Y * (1 - HealthPercent)))
         ESP.Health.Color = Color3.fromRGB(255 * (1 - HealthPercent), 255 * HealthPercent, 0)
      else
         ESP.Health.Visible = false
      end
      
      -- Distance ESP
      if Settings.DistanceESP then
         local DistToPlayer = math.floor((Root.Position - Camera.CFrame.Position).Magnitude)
         ESP.Distance.Visible = true
         ESP.Distance.Text = tostring(DistToPlayer) .. "m"
         ESP.Distance.Position = Vector2.new(ScreenPos.X, BoxPos.Y + BoxSize.Y + 6)
         ESP.Distance.Color = Settings.Color
      else
         ESP.Distance.Visible = false
      end
      
      -- Tracer ESP
      if Settings.TracerESP then
         ESP.Tracer.Visible = true
         ESP.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
         ESP.Tracer.To = Vector2.new(ScreenPos.X, ScreenPos.Y)
         ESP.Tracer.Color = Settings.Color
      else
         ESP.Tracer.Visible = false
      end
   end
   
   -- Highlight Closest Target
   if Settings.HighlightTarget and ClosestPlayer and getgenv().PandX_Drawings[ClosestPlayer] then
      local ESP = getgenv().PandX_Drawings[ClosestPlayer]
      TargetHighlight.Visible = true
      TargetHighlight.Size = ESP.Box.Size
      TargetHighlight.Position = ESP.Box.Position
      TargetHighlight.Color = Color3.fromRGB(255, 50, 50)
   else
      TargetHighlight.Visible = false
   end
end)

-- Cleanup
Players.PlayerRemoving:Connect(RemoveESP)

print("✅ PandX v5.0 ESP loaded successfully — Made by vex")
Rayfield:Notify({
   Title = "PandX v5.0",
   Content = "ESP Ready • Made by vex",
   Duration = 4
})
