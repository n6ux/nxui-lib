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
        local frame = Instance.new("Frame")
        frame.Parent = lib.activescreengui

        frame.Name = properties.name.."_WINDOW"
        frame.Size = properties.size
        frame.Position = properties.pos
    else
        warn("[NXUI]: NXUI has not been initialized, event failed.")
    end
end

return lib