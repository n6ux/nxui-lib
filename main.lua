local coregui = game:GetService("CoreGui")

local lib = {}

lib.initialized = false
lib.activescreengui = nil

function lib:Initialize()
    local screengui = Instance.new("ScreenGui")
    screengui.Parent = coregui
    screengui.Name = "NXUI"

    lib.initialized = true
    lib.activescreengui = screengui

    warn("[NXUI]: Lib initialized!")
end

function lib:CreateAndRenderWindow(properties: {}) --draggable, pos, name
    if lib.initialized == true then
        --/Creating frame
        local frame = Instance.new("Frame")
        frame.Parent = lib.activescreengui

        frame.Name = properties.name.."_WINDOW"
        frame.Size = UDim2.new(0, 510, 0, 688)
        frame.Position = properties.pos

        --/Making the frame look nicer 
        frame.BackgroundColor3 = Color3.fromRGB(30, 25, 46)
        frame.BorderColor3 = Color3.fromRGB(112, 83, 158)
        frame.BorderMode = Enum.BorderMode.Outline
        frame.BorderSizePixel = 2.3

        --Adding information section
        local infoframe = Instance.new("Frame")
        infoframe.Parent = frame

        infoframe.BackgroundColor3 = Color3.fromRGB(33, 22, 46)
        infoframe.BorderColor3 = Color3.fromRGB(41, 41, 41)
        infoframe.BorderMode = Enum.BorderMode.Outline
        infoframe.BorderSizePixel = 2.3
        infoframe.Position = UDim2.new(0.019, 0, 0.086, 0)
        infoframe.Size = UDim2.new(0, 491, 0, 619)

        --Window text
        local textlabel = Instance.new("TextLabel")
        textlabel.Parent = frame
        textlabel.Position = UDim2.new(0, 25, 0, 11)

        textlabel.BackgroundTransparency = 1
        textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textlabel.RichText = true
        textlabel.TextSize = 23
        textlabel.Font = Enum.Font.TitilliumWeb
        textlabel.Text = properties.name
    else
        warn("[NXUI]: NXUI has not been initialized, event failed.")
    end
end

return lib