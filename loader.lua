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

-- Close button
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
keyInput.Position = UDim2.new(0.1, 0, 0.3, 30)
keyInput.Size = UDim2.new(0.8, 0, 0, 40)
keyInput.PlaceholderText = "Enter your license key..."
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = loaderFrame

local noKeyButton = Instance.new("TextButton")
noKeyButton.Name = "NoKeyButton"
noKeyButton.Position = UDim2.new(0.1, 0, 0.5, 30)
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
checkKeyButton.Position = UDim2.new(0.3, 0, 0.7, 30)
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

-- Load keys database with better error handling
local keys
local function loadKeys()
    local success, result = pcall(function()
        local response = game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/main/keys.lua", true)
        if not response then error("Empty response from server") end
        local func = loadstring(response)
        if not func then error("Failed to compile keys data") end
        return func()
    end)
    
    if not success then
        showNotification("Failed to load keys database", true)
        warn("Key loading error: "..tostring(result))
        return nil
    end
    return result
end

-- Fixed verifyKeyAndUser function (line 314)
local function verifyKeyAndUser(key, username)
    if not keys or not keys[key] then 
        warn("Key not found in database")
        return false, nil 
    end
    
    local keyType = keys[key].type
    if not keyType then
        warn("Key has no type specified")
        return false, nil
    end
    
    local scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/main/"..keyType..".lua"
    
    local success, keyData = pcall(function()
        local response = game:HttpGet(scriptUrl, true)
        if not response then error("Empty response from server") end
        local func = loadstring(response)
        if not func then error("Failed to compile key data") end
        return func()
    end)
    
    if not success then
        showNotification("Failed to verify key", true)
        warn("Key verification error: "..tostring(keyData))
        return false, nil
    end
    
    if not keyData or type(keyData) ~= "table" then
        warn("Invalid key data format")
        return false, nil
    end

    -- Check both array and dictionary formats
    local keyEntry
    if #keyData > 0 then
        -- Array format
        for _, entry in ipairs(keyData) do
            if entry and entry.key == key then
                keyEntry = entry
                break
            end
        end
    else
        -- Dictionary format
        keyEntry = keyData[key]
    end

    if keyEntry and keyEntry.users and type(keyEntry.users) == "table" then
        for _, user in ipairs(keyEntry.users) do
            if string.lower(tostring(user)) == string.lower(username) then
                return true, keyType
            end
        end
    end
    
    warn("User not whitelisted for this key")
    return false, nil
end

-- Load script version
local function loadScriptVersion(keyType)
    if not loaderGui or not loaderGui.Parent then return end
    
    loaderGui:Destroy()
    
    local scriptUrl
    if keyType == "pro" or keyType == "eb" then
        scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/pro/main.lua"
    elseif keyType == "eu" then
        scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/free/main.lua"
    else
        showNotification("Invalid license type", true)
        game:GetService("Players").LocalPlayer:Kick("Invalid license type")
        return
    end
    
    local success, err = pcall(function()
        local response = game:HttpGet(scriptUrl, true)
        if not response then error("Empty response from server") end
        local func = loadstring(response)
        if not func then error("Failed to compile script") end
        func()
    end)
    
    if not success then
        showNotification("Failed to load script", true)
        warn("Script loading error: "..tostring(err))
        game:GetService("Players").LocalPlayer:Kick("Failed to load script")
    end
end

-- Check key button with proper error handling
checkKeyButton.MouseButton1Click:Connect(function()
    showNotification("Verifying key...")
    
    -- Load keys if not already loaded
    if not keys then
        keys = loadKeys()
        if not keys then return end
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
    local isValid, keyType = verifyKeyAndUser(key, username)
    
    if not isValid or not keyType then
        showNotification("Key not authorized for your account", true)
        game:GetService("Players").LocalPlayer:Kick("Unauthorized license usage")
        return
    end
    
    showNotification("Key accepted! Loading...")
    loadScriptVersion(keyType)
end)

-- Free version button
noKeyButton.MouseButton1Click:Connect(function()
    showNotification("Loading free version...")
    loaderGui:Destroy()
    local success, err = pcall(function()
        local response = game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/free/main.lua", true)
        if not response then error("Empty response from server") end
        local func = loadstring(response)
        if not func then error("Failed to compile script") end
        func()
    end)
    if not success then
        showNotification("Failed to load free version", true)
        warn("Free version error: "..tostring(err))
        game:GetService("Players").LocalPlayer:Kick("Failed to load free version")
    end
end)
