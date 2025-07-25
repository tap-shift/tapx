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

-- Key input section
local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
keyInput.Size = UDim2.new(0.8, 0, 0, 40)
keyInput.PlaceholderText = "Enter your license key..."
keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.TextSize = 14
keyInput.Font = Enum.Font.Gotham
keyInput.Parent = loaderFrame

local noKeyButton = Instance.new("TextButton")
noKeyButton.Name = "NoKeyButton"
noKeyButton.Position = UDim2.new(0.1, 0, 0.5, 0)
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
checkKeyButton.Position = UDim2.new(0.3, 0, 0.7, 0)
checkKeyButton.Size = UDim2.new(0.4, 0, 0, 40)
checkKeyButton.Text = "CHECK KEY"
checkKeyButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
checkKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
checkKeyButton.TextSize = 14
checkKeyButton.Font = Enum.Font.GothamBold
checkKeyButton.Parent = loaderFrame

-- Add corner radius to elements
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = loaderFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 6)
inputCorner.Parent = keyInput

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = checkKeyButton

-- Load keys database
local function loadKeys()
    local success, keys = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/main/keys.lua"))()
    end)
    return success and keys or nil
end

-- Check if user is whitelisted for a key type
local function isWhitelisted(keyType, username)
    local scriptUrl = "https://raw.githubusercontent.com/tap-shift/tapx/"..keyType.."/"..keyType..".lua"
    local success, whitelist = pcall(function()
        return loadstring(game:HttpGet(scriptUrl))()
    end)
    
    if success and whitelist then
        for _, name in ipairs(whitelist.users) do
            if string.lower(name) == string.lower(username) then
                return true
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
    local keys = loadKeys()
    if not keys then
        showNotification("Failed to load keys database", true)
        return
    end
    
    local key = string.trim(keyInput.Text)
    if key == "" then
        showNotification("Please enter a key", true)
        return
    end
    
    local keyData = keys[key]
    if not keyData then
        showNotification("Invalid key", true)
        return
    end
    
    local username = player.Name
    if not isWhitelisted(keyData.type, username) then
        showNotification("Key not whitelisted for your account", true)
        return
    end
    
    showNotification("Key accepted! Loading "..keyData.type.." version...")
    loadScriptVersion(keyData.type)
end)

noKeyButton.MouseButton1Click:Connect(function()
    showNotification("Loading free version...")
    loadScriptVersion("free")
end)
