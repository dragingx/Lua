-- ╔════════════════════════════════════════════════════════════╗
-- ║        PandX Premium v2.0 — Generated Key System           ║
-- ║                    Made by vex                             ║
-- ║              Using Junkie Development                      ║
-- ╚════════════════════════════════════════════════════════════╝

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================== YOUR SERVICE ID ====================
local SERVICE_ID = "1cda68e4-387f-49ff-a1b0-cb2433a52176"

local HttpService = game:GetService("HttpService")

local function ValidateGeneratedKey(key)
    if not key or key == "" then 
        return false 
    end
    
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

-- ==================== RAYFIELD UI ====================
local Window = Rayfield:CreateWindow({
   Name = "PandX Premium",
   LoadingTitle = "PandX Premium",
   LoadingSubtitle = "Made by vex • Generated Keys",
   ConfigurationSaving = { Enabled = false },
   Discord = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("Premium Access", 4483362748)

Tab:CreateLabel("Premium Script • Generated Key Required")

Tab:CreateInput({
   Name = "Enter Your Generated Key",
   PlaceholderText = "Paste your key here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.PandX_Key = Text
   end
})

Tab:CreateButton({
   Name = "Unlock PandX Premium",
   Callback = function()
      local key = _G.PandX_Key or ""
      
      if key == "" then
         Rayfield:Notify({ Title = "PandX Premium", Content = "Please enter your key!", Duration = 3 })
         return
      end
      
      Rayfield:Notify({ Title = "PandX Premium", Content = "Verifying key with Junkie...", Duration = 2 })
      
      task.wait(0.8)
      
      local isValid = ValidateGeneratedKey(key)
      
      if isValid then
         Rayfield:Notify({ Title = "PandX Premium", Content = "✓ Premium Access Unlocked!", Duration = 3 })
         task.wait(1)
         Window:Destroy()
         
         print("✅ PandX Premium loaded successfully")
         
         -- ==================== LOAD YOUR FULL PANDX ESP HERE ====================
         -- Paste your full PandX code below this line
         
      else
         Rayfield:Notify({ Title = "PandX Premium", Content = "✗ Invalid or expired key", Duration = 4 })
      end
   end
})

Tab:CreateButton({
   Name = "Get Premium Key",
   Callback = function()
      setclipboard("https://discord.gg/DM2wxd6K4e")
      Rayfield:Notify({ Title = "PandX Premium", Content = "Discord link copied!", Duration = 3 })
   end
})

Tab:CreateLabel("Made by vex • Premium Version")
Tab:CreateLabel("Each buyer gets their own unique key")
