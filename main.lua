local userinputservice = game:GetService("UserInputService")

local lib = {
	activescreengui = nil,
	windows = {},
	themes = {
		default = {
			windowcolor = Color3.fromRGB(16, 15, 33),
			tabholdercolor = Color3.fromRGB(32, 32, 49),
			windowtransparency = 0,
			windowtabholdertransparency = .25,
			windowtitlecolor = Color3.fromRGB(255, 255, 255),
			windowtitlefontface = Font.new("rbxassetid://12187365977", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			tabcategorytransparency = .5,
			tabcategorycolor = Color3.fromRGB(44, 44, 59),
			zindex = {
				window = 998,
				tabholder = 997,
				title = 1000,
				tabcategories = 999
			},
		}
	},
}

function createnewerrormessage(failedfunct: string, msg: string)
	if failedfunct == "newwindow" then
		warn("[nxui]: window creation failure! reason: "..msg)
	elseif failedfunct == "kill_lib" then
		warn("[nxui]: library quit failure! reason: "..msg)
	elseif failedfunct == "killwindow" then
		warn("[nxui]: window kill failure! reason: "..msg)
	elseif failedfunct == "newtabcategory" then
		warn("[nxui]: tab category creation failure! reason: "..msg)
	end
end



function lib:Initialize(usecoregui)
	local guiparent = nil
	if usecoregui then
		guiparent = game:GetService("CoreGui")
	else
		guiparent = game.Players.LocalPlayer.PlayerGui
	end
	
	local screengui = Instance.new("ScreenGui")
	screengui.Parent = guiparent
	screengui.Name = "nxui"
	screengui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	lib.activescreengui = screengui
end

function lib:NewWindow(properties: {name: string, size: UDim2, theme: string, draggable: boolean, addblur: boolean})
	if lib.activescreengui then
		local theme = lib.themes[properties.theme]
		if theme then
			local xtabholder, xoffsettabholder = math.floor(properties.size.X.Scale / 3), math.floor(properties.size.X.Offset / 3)
			
			local window = Instance.new("Frame")
			window.Parent = lib.activescreengui
			window.Size = UDim2.new(properties.size.X.Scale-xtabholder,properties.size.X.Offset-xoffsettabholder,properties.size.Y.Scale,properties.size.Y.Offset)
			window.AnchorPoint = Vector2.new(0.5,0.5)
			window.Position = UDim2.new(0.5,0,0.5,0)
			window.Name = properties.name.."_NXUI"
			window.ZIndex = theme.zindex.window

			window.BorderSizePixel = 0
			window.Transparency = theme.windowtransparency
			window.BackgroundColor3 = theme.windowcolor
			
			local uicorner = Instance.new("UICorner")
			uicorner.Parent = window
			uicorner.CornerRadius = UDim.new(0, 8)
			
			local tabholder = Instance.new("Frame")
			tabholder.Parent = window
			tabholder.Name = properties.name.."_WINDOWTABHOLDER"
			tabholder.Size = UDim2.new(xtabholder,xoffsettabholder,properties.size.Y.Scale,properties.size.Y.Offset)
			tabholder.ZIndex = theme.zindex.tabholder
			tabholder.Position = UDim2.new(-.48,0,0,0)
			
			tabholder.BorderSizePixel = 0
			tabholder.Transparency = theme.windowtabholdertransparency
			tabholder.BackgroundColor3 = theme.tabholdercolor
			
			if properties.addblur == true then
				local blurframemodule = loadstring(game:HttpGet("https://raw.githubusercontent.com/n6ux/blurframe/main/main.lua"))() --creds to @ImSnox
				blurframemodule:ModifyFrame(tabholder, "Blur")
			end
			
			local uicornertabholder = Instance.new("UICorner")
			uicornertabholder.Parent = tabholder
			uicornertabholder.CornerRadius = UDim.new(0, 8)
			
			local tablistlayout = Instance.new("UIListLayout")
			tablistlayout.Parent = tabholder
			tablistlayout.FillDirection = Enum.FillDirection.Vertical
			tablistlayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			tablistlayout.SortOrder = Enum.SortOrder.Name
			tablistlayout.ItemLineAlignment = Enum.ItemLineAlignment.End
			tablistlayout.VerticalAlignment = Enum.VerticalAlignment.Top
			
			local tabuipadding = Instance.new("UIPadding")
			tabuipadding.Parent = tabholder
			tabuipadding.PaddingTop = UDim.new(.16,0)
			tabuipadding.PaddingRight = UDim.new(.035,0)
			
			local title = Instance.new("TextLabel")
			title.Parent = window
			title.Name = "Title"
			title.Text = properties.name
			title.Size = UDim2.new(tabholder.Size.X.Scale,tabholder.Size.X.Offset - 10,0.2,0)
			title.RichText = true
			title.TextScaled = false
			title.TextSize = 47
			title.TextWrapped = true
			title.ZIndex = theme.zindex.title
			title.Position = UDim2.new(-.48,0,0,0)
			
			title.BackgroundTransparency = 1
			title.FontFace = theme.windowtitlefontface
			title.TextColor3 = theme.windowtitlecolor
			
			local windowtable : {}
			
			window.Destroying:Connect(function()
				for _,v in pairs(windowtable.listening) do
					v:Disconnect()
					v = nil
				end

				for i,v in pairs(lib.windows) do
					if v == windowtable then
						table.remove(lib.windows, i)
					end
				end
			end)
			
			windowtable = {
				object = window,
				name = properties.name,
				listening = {},
				themeused = theme
			}
			
			table.insert(lib.windows, windowtable)
			
			return windowtable
		else
			createnewerrormessage("newwindow", "THEME NOT FOUND")
		end
	else
		createnewerrormessage("newwindow", "LIBRARY NOT INITIALIZED")
	end
end

function lib:KillWindow(window)
	if window then
		window.object:Destroy()
		task.wait(.2)
		print(lib.windows)
	else
		createnewerrormessage("killwindow", "WINDOW PARAMETER MISSING")
	end
end

function lib:NewTabCategory(window: {object: Frame, name: string, listening: {RBXScriptConnection}}, name: string)
	if window then
		local tabholder = window.object:FindFirstChild(window.name.."_WINDOWTABHOLDER")
		local theme = window.themeused
		
		local tabcategory = Instance.new("Frame")
		tabcategory.Parent = tabholder
		tabcategory.Name = name.."_TABCATEGORY"
		tabcategory.Size = UDim2.new(tabholder.Size.X.Scale,tabholder.Size.X.Offset - 26,.3,0)
		tabcategory.ZIndex = theme.zindex.tabcategories
		
		tabcategory.BorderSizePixel = 0
		tabcategory.Transparency = theme.tabcategorytransparency
		tabcategory.BackgroundColor3 = theme.tabcategorycolor
	else
		createnewerrormessage("newtabcategory", "WINDOW PARAMATER MISSING")
	end
end

function lib.KillAllWindows()
	for _,v in pairs(lib.windows) do
		v:Destroy()
	end
end

function lib.KillLibrary()
	local activescreengui = lib.activescreengui
	
	if activescreengui then
		activescreengui:Destroy()
	else
		createnewerrormessage("kill_lib", "LIBRARY NOT INITIALIZED")
	end
end

return lib
