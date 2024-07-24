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
end

function lib:CreateWindow()
    if lib.initialized == true then
        local newwindow = {}
        setmetatable(newwindow, lib)

        newwindow.Dragabble = false
        newwindow.Size = UDim2.new()
        newwindow.Position = UDim2.new()
        newwindow.Name = ""

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