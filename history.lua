--!strict
return function(frame)
    local historyList = {}

    -- UI Setup
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
    historyLayout.SortOrder = Enum.SortOrder.LayoutOrder
    historyLayout.Parent = historyScroller

    local function refreshHistory()
        for _, child in ipairs(historyScroller:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end

        for _, text in ipairs(historyList) do
            local historyItem = Instance.new("Frame")
            historyItem.Size = UDim2.new(1, 0, 0, 40)
            historyItem.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            historyItem.Parent = historyScroller

            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = historyItem

            local textLabel = Instance.new("TextLabel")
            textLabel.Text = text
            textLabel.Size = UDim2.new(0.8, -10, 1, 0)
            textLabel.Position = UDim2.new(0, 10, 0, 0)
            textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            textLabel.TextSize = 14
            textLabel.Font = Enum.Font.Gotham
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.TextYAlignment = Enum.TextYAlignment.Center
            textLabel.TextWrapped = true
            textLabel.BackgroundTransparency = 1
            textLabel.Parent = historyItem

            local copyButton = Instance.new("TextButton")
            copyButton.Text = "COPY"
            copyButton.Size = UDim2.new(0.2, -10, 0.8, 0)
            copyButton.Position = UDim2.new(0.8, 0, 0.1, 0)
            copyButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
            copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            copyButton.TextSize = 12
            copyButton.Font = Enum.Font.GothamBold
            copyButton.Parent = historyItem

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 4)
            buttonCorner.Parent = copyButton

            copyButton.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(text)
                end
            end)
        end
    end

    local function addHistoryItem(text)
        table.insert(historyList, 1, text)
        if #historyList > 50 then
            table.remove(historyList, 51)
        end
        refreshHistory()
    end

    -- Expose Methode um History zu aktualisieren
    return {
        addHistoryItem = addHistoryItem
    }
end
