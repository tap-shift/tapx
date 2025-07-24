local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TapXBypasserUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Notification function (unchanged)
local function showNotification(text)
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.AnchorPoint = Vector2.new(1, 1)
    notif.Position = UDim2.new(1, -20, 1, -20)
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
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

-- New modern frame design
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 380, 0, 500) -- Slightly larger
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

-- Glass morphism effect
local backgroundBlur = Instance.new("Frame")
backgroundBlur.Name = "BackgroundBlur"
backgroundBlur.Size = UDim2.new(1, 0, 1, 0)
backgroundBlur.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
backgroundBlur.BackgroundTransparency = 0.3
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

-- Glow effect
local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.Size = UDim2.new(1, 40, 1, 40)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://5028857084"
glow.ImageColor3 = Color3.fromRGB(80, 120, 200)
glow.ImageTransparency = 0.8
glow.ScaleType = Enum.ScaleType.Slice
glow.SliceCenter = Rect.new(24, 24, 276, 276)
glow.Parent = mainFrame
glow.ZIndex = -1

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
title.Text = "TAPX BYPASSER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleContainer

local version = Instance.new("TextLabel")
version.Name = "Version"
version.Position = UDim2.new(0, title.TextBounds.X + 8, 0, 0)
version.Size = UDim2.new(0, 0, 1, 0)
version.AutomaticSize = Enum.AutomaticSize.X
version.BackgroundTransparency = 1
version.Text = "v1.0"
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

-- Main content area
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Position = UDim2.new(0, 0, 0, 50)
contentArea.Size = UDim2.new(1, 0, 1, -50)
contentArea.BackgroundTransparency = 1
contentArea.Parent = contentFrame

-- Input section
local inputSection = Instance.new("Frame")
inputSection.Name = "InputSection"
inputSection.Position = UDim2.new(0, 20, 0, 20)
inputSection.Size = UDim2.new(1, -40, 0, 150)
inputSection.BackgroundTransparency = 1
inputSection.Parent = contentArea

local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(1, 0, 0, 20)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "INPUT TEXT"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
inputLabel.TextSize = 14
inputLabel.Font = Enum.Font.GothamMedium
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = inputSection

local inputBox = Instance.new("TextBox")
inputBox.Name = "InputBox"
inputBox.Position = UDim2.new(0, 0, 0, 25)
inputBox.Size = UDim2.new(1, 0, 1, -25)
inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Gotham
inputBox.TextWrapped = true
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.PlaceholderText = "Type text to bypass here..."
inputBox.Parent = inputSection

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

local inputPadding = Instance.new("UIPadding")
inputPadding.PaddingLeft = UDim.new(0, 10)
inputPadding.PaddingRight = UDim.new(0, 10)
inputPadding.PaddingTop = UDim.new(0, 10)
inputPadding.PaddingBottom = UDim.new(0, 10)
inputPadding.Parent = inputBox

-- Output section
local outputSection = Instance.new("Frame")
outputSection.Name = "OutputSection"
outputSection.Position = UDim2.new(0, 20, 0, 190)
outputSection.Size = UDim2.new(1, -40, 0, 150)
outputSection.BackgroundTransparency = 1
outputSection.Parent = contentArea

local outputLabel = Instance.new("TextLabel")
outputLabel.Name = "OutputLabel"
outputLabel.Size = UDim2.new(1, 0, 0, 20)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "BYPASSED TEXT"
outputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
outputLabel.TextSize = 14
outputLabel.Font = Enum.Font.GothamMedium
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = outputSection

local outputBox = Instance.new("TextLabel")
outputBox.Name = "OutputBox"
outputBox.Position = UDim2.new(0, 0, 0, 25)
outputBox.Size = UDim2.new(1, 0, 1, -25)
outputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
outputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
outputBox.TextSize = 14
outputBox.Font = Enum.Font.Gotham
outputBox.TextWrapped = true
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.Text = ""
outputBox.Parent = outputSection

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputBox

local outputPadding = Instance.new("UIPadding")
outputPadding.PaddingLeft = UDim.new(0, 10)
outputPadding.PaddingRight = UDim.new(0, 10)
outputPadding.PaddingTop = UDim.new(0, 10)
outputPadding.PaddingBottom = UDim.new(0, 10)
outputPadding.Parent = outputBox

-- Action buttons
local actionButtons = Instance.new("Frame")
actionButtons.Name = "ActionButtons"
actionButtons.Position = UDim2.new(0, 20, 0, 360)
actionButtons.Size = UDim2.new(1, -40, 0, 50)
actionButtons.BackgroundTransparency = 1
actionButtons.Parent = contentArea

local bypassButton = Instance.new("TextButton")
bypassButton.Name = "BypassButton"
bypassButton.Size = UDim2.new(0.48, 0, 1, 0)
bypassButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
bypassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bypassButton.Text = "BYPASS"
bypassButton.TextSize = 14
bypassButton.Font = Enum.Font.GothamBold
bypassButton.Parent = actionButtons

local copyButton = Instance.new("TextButton")
copyButton.Name = "CopyButton"
copyButton.Position = UDim2.new(0.52, 0, 0, 0)
copyButton.Size = UDim2.new(0.48, 0, 1, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Text = "COPY"
copyButton.TextSize = 14
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = actionButtons

-- Add corner radius to buttons
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = bypassButton
buttonCorner:Clone().Parent = copyButton

-- Discord button
local discordButton = Instance.new("TextButton")
discordButton.Name = "DiscordButton"
discordButton.Position = UDim2.new(0, 20, 0, 420)
discordButton.Size = UDim2.new(1, -40, 0, 30)
discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Text = "JOIN OUR DISCORD"
discordButton.TextSize = 14
discordButton.Font = Enum.Font.GothamBold
discordButton.Parent = contentArea

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 6)
discordCorner.Parent = discordButton

-- Mobile responsiveness
if UserInputService.TouchEnabled then
    mainFrame.Size = UDim2.new(0.9, 0, 0, 500)
    inputBox.TextSize = 16
    outputBox.TextSize = 16
    bypassButton.TextSize = 16
    copyButton.TextSize = 16
    discordButton.TextSize = 15
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

-- Discord button functionality
discordButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/FkNXHAxdmR")
        showNotification("Discord link copied to clipboard!")
    else
        showNotification("Clipboard not available - check console")
        print("Join our Discord: https://discord.gg/FkNXHAxdmR")
    end
end)

-- Load bypasser module
local function loadBypasser()
    local bypasserUrl = "https://raw.githubusercontent.com/tap-shift/tapx/main/bypasser.lua"
    local success, bypasser = pcall(function()
        return loadstring(game:HttpGet(bypasserUrl))()
    end)
    
    if not success then
        warn("Failed to load bypasser module: " .. tostring(bypasser))
        return nil
    end
    return bypasser
end

-- Initialize bypasser
local Bypasser = loadBypasser() or error("Failed to load bypasser module")

-- Connect buttons
bypassButton.MouseButton1Click:Connect(function()
    outputBox.Text = Bypasser.bypassText(inputBox.Text)
end)

copyButton.MouseButton1Click:Connect(function()
    Bypasser.copyToClipboard(outputBox.Text)
    showNotification("Copied to clipboard!")
end)
