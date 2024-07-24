local coregui = game:GetService("CoreGui")

local lib = {}
lib.__index = lib

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

function lib:CreateWindow()
    if lib.initialized == true then
        local newwindow = {}
        setmetatable(newwindow, lib)

        newwindow.Dragabble = false
        newwindow.Size = UDim2.new(0.5, 0, 0.5, 0)
        newwindow.Position = UDim2.new(0.5, 0, 0.5, 0)
        newwindow.Name = ""

        print(newwindow)

        function newwindow.Render()
            local frame = Instance.new("Frame")
            frame.Parent = lib.activescreengui

            frame.Name = newwindow.Name.."_WINDOW"
            frame.Size = newwindow.Size
            frame.Position = newwindow.Position
        end

        return newwindow
    else
        warn("[NXUI]: NXUI has not been initialized, event failed.")
    end
end

return lib