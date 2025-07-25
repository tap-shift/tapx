return function(frame)
    local historyLabel = Instance.new("TextLabel")
    historyLabel.Text = "HISTORY"
    historyLabel.Size = UDim2.new(1, -20, 0, 40)
    historyLabel.Position = UDim2.new(0, 10, 0, 10)
    historyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    historyLabel.TextSize = 18
    historyLabel.Font = Enum.Font.GothamBold
    historyLabel.TextXAlignment = Enum.TextXAlignment.Left
    historyLabel.BackgroundTransparency = 1
    historyLabel.Parent = frame

    local historyScroller = Instance.new("ScrollingFrame")
    historyScroller.Size = UDim2.new(1, -20, 1, -60)
    historyScroller.Position = UDim2.new(0, 10, 0, 60)
    historyScroller.BackgroundTransparency = 1
    historyScroller.ScrollBarThickness = 5
    historyScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
    historyScroller.Parent = frame

    local historyLayout = Instance.new("UIListLayout")
    historyLayout.Padding = UDim.new(0, 5)
    historyLayout.Parent = historyScroller

    -- Example history item (you would populate this from saved data)
    local exampleItem = Instance.new("TextLabel")
    exampleItem.Text = "Example bypassed text"
    exampleItem.Size = UDim2.new(1, 0, 0, 30)
    exampleItem.TextColor3 = Color3.fromRGB(200, 200, 200)
    exampleItem.TextSize = 14
    exampleItem.Font = Enum.Font.Gotham
    exampleItem.TextXAlignment = Enum.TextXAlignment.Left
    exampleItem.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    exampleItem.Parent = historyScroller

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = exampleItem
end
