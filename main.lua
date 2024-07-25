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

function lib:CreateAndRenderWindow(properties: {}) --draggable, size, pos, name
    if lib.initialized == true then
        --/Creating frame
        local frame = Instance.new("Frame")
        frame.Parent = lib.activescreengui

        frame.Name = properties.name.."_WINDOW"
        frame.Size = properties.size
        frame.Position = properties.pos
        frame.BackgroundTransparency = 1

        --[[/Making the frame look nicer
        frame.BackgroundColor3 = Color3.fromRGB(31, 40, 66)
        frame.BackgroundTransparency = .35

        local uicorner = Instance.new("UICorner")
        uicorner.CornerRadius = UDim.new(0, 8)

        local textlabel = Instance.new("TextLabel")
        textlabel.Parent = frame
        textlabel.Size = UDim2.new(0, 163, 0, 35)
        textlabel.Position = UDim2.new(0, 0, 0, 0)
        textlabel.Text = properties.name
        textlabel.BackgroundTransparency = 1
        textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textlabel.FontFace = Enum.Font.Gotham.Name
        textlabel.TextScaled = true]]
    else
        warn("[NXUI]: NXUI has not been initialized, event failed.")
    end
end

return lib