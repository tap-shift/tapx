local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create loader GUI
local loaderGui = Instance.new("ScreenGui")
loaderGui.Name = "TapXLoaderUI"
loaderGui.ResetOnSpawn = false
loaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loaderGui.Parent = player:WaitForChild("PlayerGui")

-- Notification function
local function showNotification(text, isError)
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.AnchorPoint = Vector2.new(1, 1)
    notif.Position = UDim2.new(1, -20, 1, -20)
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.BackgroundColor3 = isError and Color3.fromRGB(80, 40, 40) or Color3.fromRGB(40, 40, 50)
    notif.BackgroundTransparency = 0.2
    notif.Parent = loaderGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notif

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = notif

    -- Animation
    notif.Position = UDim2.new(1, -20, 1, 100)
    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -20, 1, -20)}):Play()
    
    delay(3, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -20, 1, 100)}):Play()
        delay(0.3, function() notif:Destroy() end)
    end)
end

-- Main loader frame
local loaderFrame = Instance.new("Frame")
loaderFrame.Name = "LoaderFrame"
loaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
loaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
loaderFrame.Size = UDim2.new(0, 350, 0, 250)
loaderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
loaderFrame.BackgroundTransparency = 0.15
loaderFrame.BorderSizePixel = 0
loaderFrame.ClipsDescendants = true
loaderFrame.Parent = loaderGui

-- Header section (for dragging)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
header.BorderSizePixel = 0
header.Parent = loaderFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "TAPX LOADER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button (same as main script)
local closeButton = Instance.new("ImageButton")
closeButton.Name = "CloseButton"
closeButton.AnchorPoint = Vector2.new(1, 0.5)
closeButton.Position = UDim2.new(1, -10, 0.5, 0)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.BackgroundTransparency = 1
closeButton.Image = "rbxassetid://3926305904"
closeButton.ImageRectOffset = Vector2.new(284, 4)
closeButton.ImageRectSize = Vector2.new(24, 24)
closeButton.ImageColor3 = Color3.fromRGB(200, 200, 200)
closeButton.Parent = header

-- Key input section
local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Position = UDim2.new(0.1, 0, 0.3, 30) -- Adjusted for header
keyInput.Size = UDim2.new(0.8, 0, 0, 40)
keyInput.PlaceholderText = "Enter your license key..."
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = loaderFrame

local noKeyButton = Instance.new("TextButton")
noKeyButton.Name = "NoKeyButton"
noKeyButton.Position = UDim2.new(0.1, 0, 0.5, 30) -- Adjusted for header
noKeyButton.Size = UDim2.new(0.8, 0, 0, 20)
noKeyButton.BackgroundTransparency = 1
noKeyButton.Text = "I don't have a key (free version)"
noKeyButton.TextColor3 = Color3.fromRGB(100, 150, 255)
noKeyButton.TextSize = 12
noKeyButton.Font = Enum.Font.Gotham
noKeyButton.TextXAlignment = Enum.TextXAlignment.Left
noKeyButton.Parent = loaderFrame

local underline = Instance.new("Frame")
underline.Name = "Underline"
underline.Position = UDim2.new(0, 0, 1, 0)
underline.Size = UDim2.new(1, 0, 0, 1)
underline.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
underline.BorderSizePixel = 0
underline.Parent = noKeyButton

local checkKeyButton = Instance.new("TextButton")
checkKeyButton.Name = "CheckKeyButton"
checkKeyButton.Position = UDim2.new(0.3, 0, 0.7, 30) -- Adjusted for header
checkKeyButton.Size = UDim2.new(0.4, 0, 0, 40)
checkKeyButton.Text = "CHECK KEY"
checkKeyButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.TextSize = 14
checkKeyButton.Font = Enum.Font.GothamBold
checkKeyButton.Parent = loaderFrame

-- Add corner radius to elements
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = loaderFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = keyInput

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = checkKeyButton

-- Dragging functionality
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    loaderFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X,
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = loaderFrame.Position
        
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                connection:Disconnect()
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or 
        input.UserInputType == Enum.UserInputType.Touch) and dragging then
        updateInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or 
       input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    loaderGui:Destroy()
end)

-- Load keys database
local keys
local function loadKeys()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/main/keys.lua"))()
    end)
    if success then
        keys = result
    end
    return success and keys or nil
end

-- Check if user is whitelisted for a specific key
local function isWhitelisted(key, username)
    local keyType = keys[key].type
    local scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/main/"..keyType..".lua"
    
    local success, keyData = pcall(function()
        return loadstring(game:HttpGet(scriptUrl))()
    end)
    
    if success and keyData then
        for _, data in ipairs(keyData) do
            if data.key == key then
                for _, name in ipairs(data.users) do
                    if string.lower(name) == string.lower(username) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

-- Load the appropriate script version
local function loadScriptVersion(keyType)
    loaderGui:Destroy() -- Remove loader UI
    
    local scriptUrl
    if keyType == "free" then
        scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/free/main.lua"
    else
        scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/pro/main.lua"
    end
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
    
    if not success then
        warn("Failed to load script: "..tostring(err))
    end
end

-- Button events
checkKeyButton.MouseButton1Click:Connect(function()
    if not loadKeys() then
        showNotification("Failed to load keys database", true)
        return
    end
    
    local key = string.trim(keyInput.Text)
    if key == "" then
        showNotification("Please enter a key", true)
        return
    end
    
    if not keys[key] then
        showNotification("Invalid key", true)
        return
    end
    
    local username = player.Name
    if not isWhitelisted(key, username) then
        showNotification("Key not whitelisted for your account", true)
        return
    end
    
    showNotification("Key accepted! Loading "..keys[key].type.." version...")
    loadScriptVersion(keys[key].type)
end)

noKeyButton.MouseButton1Click:Connect(function()
    showNotification("Loading free version...")
    loadScriptVersion("free")
end)
