local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local topFrame = Instance.new("Frame")
topFrame.Name = "TopMenu"
topFrame.Size = UDim2.new(1, 0, 0, 50)
topFrame.Position = UDim2.new(0, 0, 0, 0)
topFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topFrame.BorderColor3 = Color3.fromRGB(204, 204, 204)
topFrame.Parent = screenGui

local buttonWindows = {} -- Список для хранения окон с кнопками

for i = 1, 4 do
    local menuButton = Instance.new("TextButton")
    menuButton.Size = UDim2.new(0, 180, 0, 30)
    menuButton.Position = UDim2.new(0, (i - 1) * 180, 0, 10)
    menuButton.Text = "Пункт " .. i
    menuButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    menuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    menuButton.Parent = topFrame

    menuButton.MouseButton1Click:Connect(function()
        
        if buttonWindows[i] then
            
            buttonWindows[i].Visible = not buttonWindows[i].Visible
        else  
            local buttonWindow = Instance.new("Frame")
            buttonWindow.Size = UDim2.new(0, 200, 0, 300)
            buttonWindow.Position = UDim2.new(0, (i - 1) * 200 + 10, 0, 60)
            buttonWindow.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            buttonWindow.BorderColor3 = Color3.fromRGB(204, 204, 204)
            buttonWindow.Parent = screenGui
            buttonWindows[i] = buttonWindow -- Сохраняем окно в список

            
            for j = 1, 10 do
                local newButton = Instance.new("TextButton")
                newButton.Size = UDim2.new(0, 180, 0, 25)
                newButton.Position = UDim2.new(0, 10, 0, (j - 1) * 30)
                newButton.Text = "Кнопка " .. j
                newButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                newButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                newButton.Parent = buttonWindow

                newButton.MouseButton1Click:Connect(function()
                    print("Кнопка " .. j .. " в окне " .. i .. " нажата")
                end)
            end
        end
    end)
end

local userInputService = game:GetService("UserInputService")
local dragging = false
local dragStart = Vector3.new(0, 0, 0)
local startPos = Vector2.new(0, 0)

topFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = topFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            topFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset)
        end
    end
end)
