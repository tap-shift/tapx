local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TapXBypasserFreeUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Notification management system
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
    notificationContainer.Parent = gui
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
    task.spawn(function()
        task.wait(0.3)
        if notif and notif.Parent then
            notif:Destroy()
        end
        
        -- Start timer for next notification if it exists
        if #notificationQueue > 0 and notificationQueue[1] then
            startNotificationTimer(notificationQueue[1])
        end
    end)
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

-- CACHING SYSTEM FOR FREE VERSION
local pageCache = {}
local libraryCache = nil
local cacheTimestamp = tick()
local CACHE_TIMEOUT = 600 -- 10 minutes cache timeout for free version

-- Cache validation
local function isCacheValid()
    return (tick() - cacheTimestamp) < CACHE_TIMEOUT
end

-- Clear cache after timeout
local function clearCacheIfExpired()
    if not isCacheValid() then
        pageCache = {}
        libraryCache = nil
        cacheTimestamp = tick()
        showNotification("Cache refreshed", false)
    end
end

-- Load and cache library
local function loadLib()
    clearCacheIfExpired()
    
    if libraryCache and isCacheValid() then
        showNotification("Library loaded from cache", false)
        return libraryCache
    end
    
    showNotification("Loading library...", false)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/free/lib.lua"))()
    end)
    
    if not success then
        showNotification("Failed to load bypasser library", true)
        warn("Failed to load library: "..tostring(result))
        return nil
    end
    
    libraryCache = result
    cacheTimestamp = tick()
    showNotification("Library loaded and cached", false)
    return result
end

-- Page loading with caching
local function loadPageCached(pageName, url)
    clearCacheIfExpired()
    
    if pageCache[pageName] and isCacheValid() then
        showNotification(pageName .. " loaded from cache", false)
        return pageCache[pageName]
    end
    
    showNotification("Loading " .. pageName .. " page...", false)
    local success, result = pcall(function()
        local code = game:HttpGet(url)
        local loadedFunction = loadstring(code)
        if type(loadedFunction) ~= "function" then
            error("Invalid page format")
        end
        return loadedFunction
    end)
    
    if not success then
        showNotification("Failed to load " .. pageName .. " page", true)
        warn("Failed to load " .. pageName .. " page: "..tostring(result))
        return nil
    end
    
    -- Cache the loaded function
    pageCache[pageName] = result
    cacheTimestamp = tick()
    showNotification(pageName .. " loaded and cached", false)
    return result
end

-- Individual page load functions with caching
local function loadBypasserPage(frame, bypasser)
    local pageFunction = loadPageCached("Bypasser", "https://raw.githubusercontent.com/tap-shift/tapx/free/bypasser.lua")
    if not pageFunction then return nil end
    
    local success, result = pcall(function()
        return pageFunction()(frame, bypasser)
    end)
    
    if not success then
        showNotification("Failed to execute Bypasser page", true)
        warn("Failed to execute Bypasser page: "..tostring(result))
        return nil
    end
    return result
end

local function loadHistoryPage(frame, bypasser)
    local pageFunction = loadPageCached("History", "https://raw.githubusercontent.com/tap-shift/tapx/free/history.lua")
    if not pageFunction then return nil end
    
    local success, result = pcall(function()
        return pageFunction()(frame, bypasser)
    end)
    
    if not success then
        showNotification("Failed to execute History page", true)
        warn("Failed to execute History page: "..tostring(result))
        return nil
    end
    return result
end

local function loadSettingsPage(frame, bypasser)
    local pageFunction = loadPageCached("Settings", "https://raw.githubusercontent.com/tap-shift/tapx/free/settings.lua")
    if not pageFunction then return nil end
    
    local success, result = pcall(function()
        return pageFunction()(frame, bypasser)
    end)
    
    if not success then
        showNotification("Failed to execute Settings page", true)
        warn("Failed to execute Settings page: "..tostring(result))
        return nil
    end
    return result
end

-- Show welcome notification
showNotification("Welcome to TapX Free Edition!", false)

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

-- Glass morphism effect
local backgroundBlur = Instance.new("Frame")
backgroundBlur.Name = "BackgroundBlur"
backgroundBlur.Size = UDim2.new(1, 0, 1, 0)
backgroundBlur.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
backgroundBlur.BackgroundTransparency = 0.4
backgroundBlur.ZIndex = -1
backgroundBlur.Parent = mainFrame

local blurCorner = Instance.new("UICorner")
blurCorner.CornerRadius = UDim.new(0, 12)
blurCorner.Parent = backgroundBlur

-- Main content frame
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, 0, 1, 0)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Header section
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
header.BorderSizePixel = 0
header.Parent = contentFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title with version
local titleContainer = Instance.new("Frame")
titleContainer.Name = "TitleContainer"
titleContainer.Position = UDim2.new(0, 20, 0, 0)
titleContainer.Size = UDim2.new(0.6, 0, 1, 0)
titleContainer.BackgroundTransparency = 1
titleContainer.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 0, 1, 0)
title.AutomaticSize = Enum.AutomaticSize.X
title.BackgroundTransparency = 1
title.Text = "TAPX BYPASSER FREE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

local version = Instance.new("TextLabel")
version.Name = "Version"
version.Position = UDim2.new(0, title.TextBounds.X + 40, 0, 0)
version.Size = UDim2.new(0, 0, 1, 0)
version.AutomaticSize = Enum.AutomaticSize.X
version.BackgroundTransparency = 1
version.Text = "v1.8"
version.TextColor3 = Color3.fromRGB(180, 180, 180)
version.TextSize = 16
version.Font = Enum.Font.Gotham
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = titleContainer

-- User indicator with cache status
local userIndicator = Instance.new("TextLabel")
userIndicator.Name = "UserIndicator"
userIndicator.AnchorPoint = Vector2.new(1, 0.5)
userIndicator.Position = UDim2.new(1, -50, 0.5, 0)
userIndicator.Size = UDim2.new(0, 0, 0, 20)
userIndicator.AutomaticSize = Enum.AutomaticSize.X
userIndicator.BackgroundTransparency = 1
userIndicator.Text = "👤 " .. player.Name .. " (FREE) 🔄"
userIndicator.TextColor3 = Color3.fromRGB(100, 200, 255) -- Light blue color for free version
userIndicator.TextSize = 12
userIndicator.Font = Enum.Font.Gotham
userIndicator.TextXAlignment = Enum.TextXAlignment.Right
userIndicator.Parent = header

-- Close button
local closeButton = Instance.new("ImageButton")
closeButton.Name = "CloseButton"
closeButton.AnchorPoint = Vector2.new(1, 0.5)
closeButton.Position = UDim2.new(1, -15, 0.5, 0)
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.BackgroundTransparency = 1
closeButton.Image = "rbxassetid://3926305904"
closeButton.ImageRectOffset = Vector2.new(284, 4)
closeButton.ImageRectSize = Vector2.new(24, 24)
closeButton.ImageColor3 = Color3.fromRGB(200, 200, 200)
closeButton.Parent = header

-- Sidebar for pages
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Position = UDim2.new(0, 0, 0, 50)
sidebar.Size = UDim2.new(0, 120, 1, -50)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
sidebar.BackgroundTransparency = 0.2
sidebar.BorderSizePixel = 0
sidebar.Parent = contentFrame

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebar

-- Page buttons container
local pageButtons = Instance.new("Frame")
pageButtons.Name = "PageButtons"
pageButtons.Position = UDim2.new(0, 10, 0, 10)
pageButtons.Size = UDim2.new(1, -20, 1, -20)
pageButtons.BackgroundTransparency = 1
pageButtons.Parent = sidebar

local pageListLayout = Instance.new("UIListLayout")
pageListLayout.Padding = UDim.new(0, 8)
pageListLayout.Parent = pageButtons

-- Page container
local pageContainer = Instance.new("Frame")
pageContainer.Name = "PageContainer"
pageContainer.Position = UDim2.new(0, 130, 0, 50)
pageContainer.Size = UDim2.new(1, -130, 1, -50)
pageContainer.BackgroundTransparency = 1
pageContainer.Parent = contentFrame

-- Create page scrolling frame
local pageScroller = Instance.new("ScrollingFrame")
pageScroller.Name = "PageScroller"
pageScroller.Size = UDim2.new(1, 0, 1, 0)
pageScroller.BackgroundTransparency = 1
pageScroller.ScrollBarThickness = 5
pageScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
pageScroller.Parent = pageContainer

-- Mobile responsiveness
if UserInputService.TouchEnabled then
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    sidebar.Size = UDim2.new(0, 90, 1, -50)
    pageContainer.Position = UDim2.new(0, 100, 0, 50)
    pageContainer.Size = UDim2.new(1, -100, 1, -50)
    title.TextSize = 16
    version.TextSize = 14
    userIndicator.TextSize = 10
end

-- Dragging functionality
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
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
        startPos = mainFrame.Position
        
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
    gui:Destroy()
end)

-- Page management
local currentPage = nil
local Bypasser = nil

local function createPageButton(pageName)
    local button = Instance.new("TextButton")
    button.Name = pageName
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    button.BackgroundTransparency = 0.5
    button.Text = pageName:upper()
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = pageButtons
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    button.MouseButton1Click:Connect(function()
        -- Load library if not loaded yet
        if not Bypasser then
            Bypasser = loadLib()
            if not Bypasser then return end
        end
        
        -- Clear current page
        if currentPage then
            currentPage:Destroy()
            currentPage = nil
        end
        
        -- Create new page container
        local pageContent = Instance.new("Frame")
        pageContent.Name = pageName
        pageContent.Size = UDim2.new(1, 0, 0, 0)
        pageContent.AutomaticSize = Enum.AutomaticSize.Y
        pageContent.BackgroundTransparency = 1
        pageContent.Parent = pageScroller
        
        -- Load specific page based on name
        local success, err = pcall(function()
            if pageName == "Bypasser" then
                loadBypasserPage(pageContent, Bypasser)
            elseif pageName == "History" then
                loadHistoryPage(pageContent, Bypasser)
            elseif pageName == "Settings" then
                loadSettingsPage(pageContent, Bypasser)
            end
        end)
        
        if not success then
            showNotification("Error in "..pageName.." page", true)
            warn("Page script error: "..tostring(err))
            pageContent:Destroy()
            return
        end
        
        currentPage = pageContent
        
        -- Update button colors
        for _, btn in ipairs(pageButtons:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                btn.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        
        button.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Update cache indicator
        userIndicator.Text = "👤 " .. player.Name .. " (FREE) ⚡"
    end)
    
    return button
end

-- Create pages
createPageButton("Bypasser")
createPageButton("History")
createPageButton("Settings")

-- Pre-load all pages in background for faster access
task.spawn(function()
    wait(1) -- Wait for UI to load
    showNotification("Pre-loading pages...", false)
    
    -- Pre-load library
    Bypasser = loadLib()
    if not Bypasser then return end
    
    -- Pre-load all page functions
    loadPageCached("Bypasser", "https://raw.githubusercontent.com/tap-shift/tapx/free/bypasser.lua")
    loadPageCached("History", "https://raw.githubusercontent.com/tap-shift/tapx/free/history.lua")
    loadPageCached("Settings", "https://raw.githubusercontent.com/tap-shift/tapx/free/settings.lua")
    
    showNotification("All pages cached successfully", false)
    userIndicator.Text = "👤 " .. player.Name .. " (FREE) ⚡"
end)

-- Load default page
task.spawn(function()
    wait(0.1) -- Small delay to ensure everything is loaded
    pageButtons:FindFirstChild("Bypasser"):MouseButton1Click()
end)
