local lib = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/n6ux/nxui-lib/main/main.lua"))()

lib:Initialize()

lib:CreateAndRenderWindow({
    draggable = true,
    size = UDim2.new(0, 650, 0, 450),
    pos = UDim2.new(0.5, 0, 0.5, 0),
    name = "testing"
})