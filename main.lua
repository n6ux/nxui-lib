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
        frame.Position = UDim2.new(0.019, 0, 0.219, 0)

        infoframe.BackgroundColor3 = Color3.fromRGB(51, 43, 78)
        infoframe.BorderColor3 = Color3.fromRGB(41, 41, 41)
        infoframe.BorderMode = Enum.BorderMode.Outline
        infoframe.BorderSizePixel = 2.3
    else
        warn("[NXUI]: NXUI has not been initialized, event failed.")
    end
end

return lib