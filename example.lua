local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/n6ux/nxui-lib/main/main.lua"))()

lib:Initalize()

lib:CreateAndRenderWindow({
    true,
    UDim2.new(0, 650, 0, 450),
    UDim2.new(0.5, 0, 0.5, 0),
    "testing"
})