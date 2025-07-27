local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TapXBypasserProUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Original notification function (bottom right, script themed)
local function showNotification(text, isError)
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.AnchorPoint = Vector2.new(1, 1)
    notif.Position = UDim2.new(1, -20, 1, -20)
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.BackgroundColor3 = isError and Color3.fromRGB(80, 40, 40) or Color3.fromRGB(40, 40, 50)
    notif.BackgroundTransparency = 0.2
    notif.Parent = gui

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
title.Text = "TAPX BYPASSER PRO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

local version = Instance.new("TextLabel")
version.Name = "Version"
version.Position = UDim2.new(0, title.TextBounds.X + 32, 0, 0)
version.Size = UDim2.new(0, 0, 1, 0)
version.AutomaticSize = Enum.AutomaticSize.X
version.BackgroundTransparency = 1
version.Text = "v1.5"
version.TextColor3 = Color3.fromRGB(180, 180, 180)
version.TextSize = 16
version.Font = Enum.Font.Gotham
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = titleContainer

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
    mainFrame.Size = UDim2.new(0.75, 0, 0.8, 0)
    -- Also adjust sidebar width for mobile
    sidebar.Size = UDim2.new(0, 90, 1, -50)
    pageContainer.Position = UDim2.new(0, 100, 0, 50)
    pageContainer.Size = UDim2.new(1, -100, 1, -50)
    -- Make text smaller on mobile
    title.TextSize = 16
    version.TextSize = 14
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

local function loadLib()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/pro/lib.lua"))()
    end)
    
    if not success then
        showNotification("Failed to load bypasser library", true)
        warn("Failed to load library: "..tostring(result))
        return nil
    end
    return result
end

-- Individual page load functions with updated pro branch links
local function loadBypasserPage(frame, bypasser)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/pro/bypasser.lua"))()
    end)
    
    if not success then
        showNotification("Failed to load Bypasser page", true)
        warn("Failed to load Bypasser page: "..tostring(result))
        return nil
    end
    return result(frame, bypasser)
end

local function loadHistoryPage(frame, bypasser)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/pro/history.lua"))()
    end)
    
    if not success then
        showNotification("Failed to load History page", true)
        warn("Failed to load History page: "..tostring(result))
        return nil
    end
    return result(frame, bypasser)
end

local function loadSettingsPage(frame, bypasser)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/tap-shift/tapx/pro/settings.lua"))()
    end)
    
    if not success then
        showNotification("Failed to load Settings page", true)
        warn("Failed to load Settings page: "..tostring(result))
        return nil
    end
    return result(frame, bypasser)
end

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
    end)
    
    return button
end

-- Create pages
createPageButton("Bypasser")
createPageButton("History")
createPageButton("Settings")

-- Load default page
task.spawn(function()
    wait(0.1) -- Small delay to ensure everything is loaded
    pageButtons:FindFirstChild("Bypasser"):MouseButton1Click()
end)
