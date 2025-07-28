local Players = game:GetService("Players")

local UserInputService = game:GetService("UserInputService")

local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer



-- Fonction trim pour supprimer les espaces

local function trim(s)

    if not s then return "" end

    return s:match("^%s*(.-)%s*$")

end



-- Create loader GUI

local loaderGui = Instance.new("ScreenGui")

loaderGui.Name = "TapXLoaderUI"

loaderGui.ResetOnSpawn = false

loaderGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

loaderGui.Parent = player:WaitForChild("PlayerGui")



-- NEW NOTIFICATION SYSTEM ============================================

local notificationQueue = {}

local notificationContainer = nil



-- Create notification container that's always on top

local function createNotificationContainer()

    if notificationContainer then return end

    

    notificationContainer = Instance.new("Frame")

    notificationContainer.Name = "NotificationContainer"

    notificationContainer.Size = UDim2.new(0, 320, 1, 0)

    notificationContainer.Position = UDim2.new(1, -20, 0, 0)

    notificationContainer.BackgroundTransparency = 1

    notificationContainer.ZIndex = 10000 -- Always on top

    notificationContainer.Parent = loaderGui

end



-- Update positions of all notifications

local function updateNotificationPositions()

    if not notificationContainer then return end

    

    local yOffset = 20

    for i, notif in ipairs(notificationQueue) do

        if notif and notif.Parent then

            local targetPos = UDim2.new(1, -320, 0, yOffset)

            TweenService:Create(notif, TweenInfo.new(0.2), {Position = targetPos}):Play()

            yOffset = yOffset + 70

        end

    end

end



-- Remove notification from queue and update positions

local function removeNotification(notif)

    for i, queuedNotif in ipairs(notificationQueue) do

        if queuedNotif == notif then

            table.remove(notificationQueue, i)

            break

        end

    end

    

    -- Animate out

    TweenService:Create(notif, TweenInfo.new(0.3), {

        Position = UDim2.new(1, 50, notif.Position.Y.Scale, notif.Position.Y.Offset),

        BackgroundTransparency = 1

    }):Play()

    

    -- Update remaining notifications

    updateNotificationPositions()

    

    -- Destroy after animation

    task.wait(0.3)

    if notif and notif.Parent then

        notif:Destroy()

    end

    

    -- Start timer for next notification if it exists

    if #notificationQueue > 0 and notificationQueue[1] then

        startNotificationTimer(notificationQueue[1])

    end

end



-- Start disappear timer for notification

local function startNotificationTimer(notif)

    if not notif or not notif.Parent then return end

    

    task.spawn(function()

        task.wait(3) -- 3 second display time

        if notif and notif.Parent then

            removeNotification(notif)

        end

    end)

end



-- Enhanced notification function with queue management

local function showNotification(text, isError)

    createNotificationContainer()

    

    local notif = Instance.new("Frame")

    notif.Name = "Notification"

    notif.AnchorPoint = Vector2.new(1, 0)

    notif.Size = UDim2.new(0, 300, 0, 60)

    notif.BackgroundColor3 = isError and Color3.fromRGB(80, 40, 40) or Color3.fromRGB(40, 40, 50)

    notif.BackgroundTransparency = 0.2

    notif.ZIndex = 10001 -- Higher than container

    notif.Parent = notificationContainer



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

    label.ZIndex = 10002

    label.Parent = notif



    -- Add to queue

    table.insert(notificationQueue, notif)

    

    -- Start slide-in animation from right

    notif.Position = UDim2.new(1, 50, 0, 20)

    

    -- Update all positions

    updateNotificationPositions()

    

    -- If this is the first (oldest) notification, start its timer

    if notificationQueue[1] == notif then

        startNotificationTimer(notif)

    end

end

-- END OF NEW NOTIFICATION SYSTEM ====================================



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

        if not response or response == "" then

            error("Empty response from server")

        end

        local func = loadstring(response)

        if not func then

            error("Failed to compile keys data")

        end

        local data = func()

        if not data then

            error("No data returned from keys file")

        end

        return data

    end)

    

    if not success then

        showNotification("Failed to load keys database", true)

        warn("Key loading error: "..tostring(result))

        return nil

    end

    return result

end



-- Updated verifyKeyAndUser function for the new keys.lua structure

local function verifyKeyAndUser(key, username)

    if not keys then

        warn("Keys database not loaded")

        showNotification("System error: Keys not loaded", true)

        return false, nil

    end

    

    -- Check if key exists in database

    if not keys.keys or not keys.keys[key] then 

        warn("Key not found in database:", key)

        showNotification("Invalid license key", true)

        return false, nil 

    end

    

    -- Get key type

    local keyType = keys.keys[key].type

    if not keyType then

        warn("Key has no type specified:", key)

        showNotification("Invalid key format", true)

        return false, nil

    end

    

    -- Get the key data from the combined file

    local keyData = keys[keyType]

    if not keyData then

        warn("No data found for key type:", keyType)

        showNotification("Invalid key type configuration", true)

        return false, nil

    end

    

    -- Search for matching key in data

    local foundEntry

    for _, entry in ipairs(keyData) do

        if entry and entry.key and entry.key == key then

            foundEntry = entry

            break

        end

    end



    if not foundEntry then

        warn("No matching key entry found in data")

        showNotification("Key verification failed", true)

        return false, nil

    end



    -- Verify users list

    if not foundEntry.users or type(foundEntry.users) ~= "table" then

        warn("Key has no valid users list")

        showNotification("Invalid key configuration", true)

        return false, nil

    end



    -- Check if user is whitelisted

    local lowerUsername = string.lower(username)

    for _, user in ipairs(foundEntry.users) do

        if string.lower(tostring(user)) == lowerUsername then

            warn("User found in whitelist")

            return true, keyType

        end

    end

    

    warn("User not in whitelist")

    showNotification("Key not authorized for your account", true)

    return false, nil

end



-- Load script version with error handling

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

    

    warn("Loading script from:", scriptUrl)

    local success, err = pcall(function()

        local response = game:HttpGet(scriptUrl, true)

        if not response or response == "" then

            error("Empty response from server")

        end

        local func = loadstring(response)

        if not func then

            error("Failed to compile script")

        end

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

        warn("Loading keys database...")

        keys = loadKeys()

        if not keys then 

            return 

        end

        warn("Keys database loaded successfully")

    end

    

    -- CORRECTION ICI : Utilisation de la fonction trim personnalisée

    local key = trim(keyInput.Text)

    if key == "" then

        showNotification("Please enter a key", true)

        return

    end

    

    warn("Checking key:", key)

    if not keys.keys[key] then

        showNotification("Invalid key", true)

        warn("Key not found in database")

        return

    end

    

    local username = player.Name

    warn("Verifying user:", username)

    

    local isValid, keyType = verifyKeyAndUser(key, username)

    

    if not isValid or not keyType then

        return

    end

    

    warn("Key verification successful, type:", keyType)

    showNotification("Key accepted! Loading...")

    loadScriptVersion(keyType)

end)



-- Free version button

noKeyButton.MouseButton1Click:Connect(function()

    showNotification("Loading free version...")

    loaderGui:Destroy()

    local success, err = pcall(function()

        local response = game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/free/main.lua", true)

        if not response or response == "" then

            error("Empty response from server")

        end

        local func = loadstring(response)

        if not func then

            error("Failed to compile script")

        end

        func()

    end)

    if not success then

        showNotification("Failed to load free version", true)

        warn("Free version error: "..tostring(err))

        game:GetService("Players").LocalPlayer:Kick("Failed to load free version")

    end

end)
