return function(frame)
    local settingsLabel = Instance.new("TextLabel")
    settingsLabel.Text = "SETTINGS"
    settingsLabel.Size = UDim2.new(1, -20, 0, 40)
    settingsLabel.Position = UDim2.new(0, 10, 0, 10)
    settingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    settingsLabel.TextSize = 18
    settingsLabel.Font = Enum.Font.GothamBold
    settingsLabel.TextXAlignment = Enum.TextXAlignment.Left
    settingsLabel.BackgroundTransparency = 1
    settingsLabel.Parent = frame

    local settingsScroller = Instance.new("ScrollingFrame")
    settingsScroller.Size = UDim2.new(1, -20, 1, -60)
    settingsScroller.Position = UDim2.new(0, 10, 0, 60)
    settingsScroller.BackgroundTransparency = 1
    settingsScroller.ScrollBarThickness = 5
    settingsScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
    settingsScroller.Parent = frame

    local settingsLayout = Instance.new("UIListLayout")
    settingsLayout.Padding = UDim.new(0, 10)
    settingsLayout.Parent = settingsScroller

    -- Example setting (toggle)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 40)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = settingsScroller

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Text = "Auto-copy bypassed text"
    toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleLabel.TextSize = 14
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Text = "OFF"
    toggleButton.Position = UDim2.new(0.7, 0, 0, 0)
    toggleButton.Size = UDim2.new(0.3, 0, 1, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 14
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = toggleFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        if toggleButton.Text == "OFF" then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        end
    end)
end
