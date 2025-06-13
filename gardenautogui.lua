-- Garden Auto GUI Template with Gear Dropdown and Auto-Buy (CoreGui version)
local gearList = {
    "watering can", "trowel", "recall wrench", "basic sprinkler", "advanced sprinkler",
    "godly sprinkler", "master sprinkler", "lightning rod", "favorite tool", "harvest tool", "friendship pot"
}

local selectedGear = gearList[1]

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GardenAutoGUI"
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌻 Garden Auto GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 28
title.Parent = mainFrame

local dropdownLabel = Instance.new("TextLabel")
dropdownLabel.Size = UDim2.new(0, 200, 0, 30)
dropdownLabel.Position = UDim2.new(0, 30, 0, 60)
dropdownLabel.BackgroundTransparency = 1
dropdownLabel.Text = "Select Gear: " .. selectedGear
dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownLabel.Font = Enum.Font.SourceSans
dropdownLabel.TextSize = 20
dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
dropdownLabel.Parent = mainFrame

local dropdownButton = Instance.new("TextButton")
dropdownButton.Size = UDim2.new(0, 30, 0, 30)
dropdownButton.Position = UDim2.new(0, 230, 0, 60)
dropdownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
dropdownButton.Text = "▼"
dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dropdownButton.Font = Enum.Font.SourceSansBold
dropdownButton.TextSize = 18
dropdownButton.Parent = mainFrame

local dropdownFrame = Instance.new("Frame")
dropdownFrame.Size = UDim2.new(0, 200, 0, #gearList * 25)
dropdownFrame.Position = UDim2.new(0, 30, 0, 90)
dropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
dropdownFrame.Visible = false
dropdownFrame.Parent = mainFrame

for i, gear in ipairs(gearList) do
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 25)
    option.Position = UDim2.new(0, 0, 0, (i-1)*25)
    option.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    option.Text = gear
    option.TextColor3 = Color3.fromRGB(255, 255, 255)
    option.Font = Enum.Font.SourceSans
    option.TextSize = 18
    option.Parent = dropdownFrame
    option.MouseButton1Click:Connect(function()
        selectedGear = gear
        dropdownLabel.Text = "Select Gear: " .. selectedGear
        dropdownFrame.Visible = false
    end)
end

dropdownButton.MouseButton1Click:Connect(function()
    dropdownFrame.Visible = not dropdownFrame.Visible
end)

local autoBuy = false
local autoBuyLabel = Instance.new("TextLabel")
autoBuyLabel.Size = UDim2.new(0, 200, 0, 30)
autoBuyLabel.Position = UDim2.new(0, 30, 0, 130)
autoBuyLabel.BackgroundTransparency = 1
autoBuyLabel.Text = "Auto Buy Selected Gear"
autoBuyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBuyLabel.Font = Enum.Font.SourceSans
autoBuyLabel.TextSize = 20
autoBuyLabel.TextXAlignment = Enum.TextXAlignment.Left
autoBuyLabel.Parent = mainFrame

local autoBuyButton = Instance.new("TextButton")
autoBuyButton.Size = UDim2.new(0, 40, 0, 30)
autoBuyButton.Position = UDim2.new(0, 250, 0, 130)
autoBuyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
autoBuyButton.Text = "OFF"
autoBuyButton.TextColor3 = Color3.fromRGB(255, 80, 80)
autoBuyButton.Font = Enum.Font.SourceSansBold
autoBuyButton.TextSize = 18
autoBuyButton.Parent = mainFrame

autoBuyButton.MouseButton1Click:Connect(function()
    autoBuy = not autoBuy
    if autoBuy then
        autoBuyButton.Text = "ON"
        autoBuyButton.TextColor3 = Color3.fromRGB(80, 255, 80)
        autoBuyButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
    else
        autoBuyButton.Text = "OFF"
        autoBuyButton.TextColor3 = Color3.fromRGB(255, 80, 80)
        autoBuyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end)

-- Auto-Buy Logic
spawn(function()
    while true do
        if autoBuy then
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "AutoBuy",
                Text = "Trying to buy: "..selectedGear
            })
            game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer(selectedGear)
        end
        wait(3)
    end
end)
