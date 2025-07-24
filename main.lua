local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Create main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TapXBypasserUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 5)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.8
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Parent = mainFrame
shadow.ZIndex = -1

-- Title bar (draggable area)
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Position = UDim2.new(0, 15, 0, 0)
title.Size = UDim2.new(1, -30, 1, 0)
title.BackgroundTransparency = 1
title.Text = "TAPX BYPASSER"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.AnchorPoint = Vector2.new(1, 0.5)
closeButton.Position = UDim2.new(1, -10, 0.5, 0)
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

-- Input frame
local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Position = UDim2.new(0, 15, 0, 50)
inputFrame.Size = UDim2.new(1, -30, 0, 120)
inputFrame.BackgroundTransparency = 1
inputFrame.Parent = mainFrame

local inputLabel = Instance.new("TextLabel")
inputLabel.Name = "InputLabel"
inputLabel.Size = UDim2.new(1, 0, 0, 20)
inputLabel.BackgroundTransparency = 1
inputLabel.Text = "INPUT TEXT:"
inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
inputLabel.TextSize = 14
inputLabel.Font = Enum.Font.Gotham
inputLabel.TextXAlignment = Enum.TextXAlignment.Left
inputLabel.Parent = inputFrame

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
inputBox.Parent = inputFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = inputBox

local inputPadding = Instance.new("UIPadding")
inputPadding.PaddingLeft = UDim.new(0, 8)
inputPadding.PaddingRight = UDim.new(0, 8)
inputPadding.PaddingTop = UDim.new(0, 8)
inputPadding.PaddingBottom = UDim.new(0, 8)
inputPadding.Parent = inputBox

-- Output frame
local outputFrame = Instance.new("Frame")
outputFrame.Name = "OutputFrame"
outputFrame.Position = UDim2.new(0, 15, 0, 190)
outputFrame.Size = UDim2.new(1, -30, 0, 120)
outputFrame.BackgroundTransparency = 1
outputFrame.Parent = mainFrame

local outputLabel = Instance.new("TextLabel")
outputLabel.Name = "OutputLabel"
outputLabel.Size = UDim2.new(1, 0, 0, 20)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "BYPASSED TEXT:"
outputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
outputLabel.TextSize = 14
outputLabel.Font = Enum.Font.Gotham
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = outputFrame

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
outputBox.Parent = outputFrame

local outputCorner = Instance.new("UICorner")
outputCorner.CornerRadius = UDim.new(0, 8)
outputCorner.Parent = outputBox

local outputPadding = Instance.new("UIPadding")
outputPadding.PaddingLeft = UDim.new(0, 8)
outputPadding.PaddingRight = UDim.new(0, 8)
outputPadding.PaddingTop = UDim.new(0, 8)
outputPadding.PaddingBottom = UDim.new(0, 8)
outputPadding.Parent = outputBox

-- Buttons
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Position = UDim2.new(0, 15, 0, 330)
buttonFrame.Size = UDim2.new(1, -30, 0, 50)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = mainFrame

local bypassButton = Instance.new("TextButton")
bypassButton.Name = "BypassButton"
bypassButton.Size = UDim2.new(0.48, 0, 1, 0)
bypassButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
bypassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
bypassButton.Text = "BYPASS"
bypassButton.TextSize = 14
bypassButton.Font = Enum.Font.GothamBold
bypassButton.Parent = buttonFrame

local copyButton = Instance.new("TextButton")
copyButton.Name = "CopyButton"
copyButton.Position = UDim2.new(0.52, 0, 0, 0)
copyButton.Size = UDim2.new(0.48, 0, 1, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Text = "COPY"
copyButton.TextSize = 14
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = buttonFrame

-- Add corner radius to buttons
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = bypassButton
buttonCorner:Clone().Parent = copyButton

-- Mobile responsiveness
if UserInputService.TouchEnabled then
    mainFrame.Size = UDim2.new(0.9, 0, 0, 400)
    inputBox.TextSize = 16
    outputBox.TextSize = 16
    bypassButton.TextSize = 16
    copyButton.TextSize = 16
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

titleBar.InputBegan:Connect(function(input)
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

titleBar.InputChanged:Connect(function(input)
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

-- Load bypasser module
local function loadBypasser()
    -- Get the current script's location
    local scriptPath = script:GetFullName()
    local repoPath = scriptPath:match("(.*/)") or ""
    local bypasserUrl = repoPath .. "bypasser.lua"
    
    -- Load the module
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
end)
