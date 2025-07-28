return function(frame, Bypasser)

    local inputSection = Instance.new("Frame")

    inputSection.Name = "InputSection"

    inputSection.Size = UDim2.new(1, -20, 0, 80)

    inputSection.Position = UDim2.new(0, 10, 0, 10)

    inputSection.BackgroundTransparency = 1

    inputSection.Parent = frame



    local inputLabel = Instance.new("TextLabel")

    inputLabel.Text = "INPUT TEXT"

    inputLabel.Size = UDim2.new(1, 0, 0, 20)

    inputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

    inputLabel.TextSize = 14

    inputLabel.Font = Enum.Font.GothamMedium

    inputLabel.TextXAlignment = Enum.TextXAlignment.Left

    inputLabel.BackgroundTransparency = 1

    inputLabel.Parent = inputSection



    local inputBox = Instance.new("TextBox")

    inputBox.PlaceholderText = "Type text to bypass here..."

    inputBox.Size = UDim2.new(1, 0, 0, 50)

    inputBox.Position = UDim2.new(0, 0, 0, 25)

    inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    inputBox.TextSize = 14

    inputBox.Font = Enum.Font.Gotham

    inputBox.TextWrapped = true

    inputBox.Parent = inputSection



    local outputSection = Instance.new("Frame")

    outputSection.Name = "OutputSection"

    outputSection.Size = UDim2.new(1, -20, 0, 80)

    outputSection.Position = UDim2.new(0, 10, 0, 100)

    outputSection.BackgroundTransparency = 1

    outputSection.Parent = frame



    local outputLabel = Instance.new("TextLabel")

    outputLabel.Text = "BYPASSED TEXT"

    outputLabel.Size = UDim2.new(1, 0, 0, 20)

    outputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

    outputLabel.TextSize = 14

    outputLabel.Font = Enum.Font.GothamMedium

    outputLabel.TextXAlignment = Enum.TextXAlignment.Left

    outputLabel.BackgroundTransparency = 1

    outputLabel.Parent = outputSection



    local outputBox = Instance.new("TextLabel")

    outputBox.Text = ""

    outputBox.Size = UDim2.new(1, 0, 0, 50)

    outputBox.Position = UDim2.new(0, 0, 0, 25)

    outputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)

    outputBox.TextColor3 = Color3.fromRGB(255, 255, 255)

    outputBox.TextSize = 14

    outputBox.Font = Enum.Font.Gotham

    outputBox.TextWrapped = true

    outputBox.Parent = outputSection



    local actionButtons = Instance.new("Frame")

    actionButtons.Name = "ActionButtons"

    actionButtons.Size = UDim2.new(1, -20, 0, 40)

    actionButtons.Position = UDim2.new(0, 10, 0, 190)

    actionButtons.BackgroundTransparency = 1

    actionButtons.Parent = frame



    local bypassButton = Instance.new("TextButton")

    bypassButton.Text = "BYPASS"

    bypassButton.Size = UDim2.new(0.48, 0, 1, 0)

    bypassButton.BackgroundColor3 = Color3.fromRGB(80, 120, 200)

    bypassButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    bypassButton.TextSize = 14

    bypassButton.Font = Enum.Font.GothamBold

    bypassButton.Parent = actionButtons



    local copyButton = Instance.new("TextButton")

    copyButton.Text = "COPY"

    copyButton.Position = UDim2.new(0.52, 0, 0, 0)

    copyButton.Size = UDim2.new(0.48, 0, 1, 0)

    copyButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)

    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

    copyButton.TextSize = 14

    copyButton.Font = Enum.Font.GothamBold

    copyButton.Parent = actionButtons



    -- Add corner radius to all elements

    for _, element in pairs({inputBox, outputBox, bypassButton, copyButton}) do

        local corner = Instance.new("UICorner")

        corner.CornerRadius = UDim.new(0, 6)

        corner.Parent = element

    end



    -- Connect buttons using the Bypasser library

    bypassButton.MouseButton1Click:Connect(function()

        outputBox.Text = Bypasser.bypassText(inputBox.Text)

    end)



    copyButton.MouseButton1Click:Connect(function()

        Bypasser.copyToClipboard(outputBox.Text)

    end)

end
