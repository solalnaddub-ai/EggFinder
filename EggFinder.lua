
-- EGG FINDER - UI v1.0
-- Interface autonome pour Roblox Studio
-- LocalScript dans StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "EggFinder"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local function corner(object, radius)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, radius)
	c.Parent = object
end

local function create(class, props, parent)
	local obj = Instance.new(class)
	for k, v in pairs(props) do
		obj[k] = v
	end
	obj.Parent = parent
	return obj
end

-- Floating button

local toggle = create("TextButton", {
	Name = "Toggle",
	Size = UDim2.fromOffset(48, 48),
	Position = UDim2.new(0, 20, 0.5, -24),
	BackgroundColor3 = Color3.fromRGB(35, 39, 52),
	Text = "🥚",
	TextSize = 25,
	TextColor3 = Color3.new(1,1,1),
}, gui)

corner(toggle, 14)

-- Main window

local main = create("Frame", {
	Name = "Main",
	Size = UDim2.fromOffset(540, 390),
	Position = UDim2.new(0.5, -270, 0.5, -195),
	BackgroundColor3 = Color3.fromRGB(20, 23, 32),
	Visible = false,
	BorderSizePixel = 0,
}, gui)

corner(main, 12)

-- Header

local header = create("Frame", {
	Size = UDim2.new(1, 0, 0, 55),
	BackgroundColor3 = Color3.fromRGB(29, 34, 47),
	BorderSizePixel = 0,
}, main)

corner(header, 12)

create("TextLabel", {
	Size = UDim2.new(1, -70, 1, 0),
	Position = UDim2.fromOffset(18, 0),
	BackgroundTransparency = 1,
	Text = "EGG FINDER",
	TextColor3 = Color3.fromRGB(255,255,255),
	Font = Enum.Font.GothamBold,
	TextSize = 20,
	TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local close = create("TextButton", {
	Size = UDim2.fromOffset(36, 36),
	Position = UDim2.new(1, -45, 0, 9),
	BackgroundColor3 = Color3.fromRGB(55, 61, 77),
	Text = "X",
	TextColor3 = Color3.new(1,1,1),
	TextSize = 16,
}, header)

corner(close, 8)

-- Scanner status

create("TextLabel", {
	Size = UDim2.new(1, -30, 0, 30),
	Position = UDim2.fromOffset(15, 62),
	BackgroundTransparency = 1,
	Text = "SERVER SCANNER  •  DEMO MODE",
	TextColor3 = Color3.fromRGB(120, 200, 160),
	Font = Enum.Font.GothamBold,
	TextSize = 12,
	TextXAlignment = Enum.TextXAlignment.Left,
}, main)

-- Egg list

local list = create("ScrollingFrame", {
	Size = UDim2.new(1, -30, 1, -110),
	Position = UDim2.fromOffset(15, 100),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 4,
	CanvasSize = UDim2.new(0,0,0,0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)

local layout = create("UIListLayout", {
	Padding = UDim.new(0, 9),
	SortOrder = Enum.SortOrder.LayoutOrder,
}, list)

-- Demo data only

local eggs = {
	{name = "Divine Egg", gain = "250B/s", size = "x12.3"},
	{name = "Secret Egg", gain = "85B/s", size = "x8.5"},
	{name = "Eternal Egg", gain = "42B/s", size = "x6.2"},
}

for index, egg in ipairs(eggs) do
	local card = create("Frame", {
		Size = UDim2.new(1, -5, 0, 85),
		BackgroundColor3 = Color3.fromRGB(35, 40, 54),
		BorderSizePixel = 0,
		LayoutOrder = index,
	}, list)

	corner(card, 9)

	create("TextLabel", {
		Size = UDim2.new(0.65, 0, 0, 25),
		Position = UDim2.fromOffset(12, 8),
		BackgroundTransparency = 1,
		Text = egg.name,
		TextColor3 = Color3.new(1,1,1),
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, card)

	create("TextLabel", {
		Size = UDim2.new(0.65, 0, 0, 22),
		Position = UDim2.fromOffset(12, 38),
		BackgroundTransparency = 1,
		Text = egg.gain .. "  •  " .. egg.size,
		TextColor3 = Color3.fromRGB(100, 220, 155),
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
	}, card)

	local join = create("TextButton", {
		Size = UDim2.fromOffset(90, 34),
		Position = UDim2.new(1, -102, 0.5, -17),
		BackgroundColor3 = Color3.fromRGB(75, 115, 220),
		Text = "JOIN",
		TextColor3 = Color3.new(1,1,1),
		Font = Enum.Font.GothamBold,
		TextSize = 12,
	}, card)

	corner(join, 7)

	join.MouseButton1Click:Connect(function()
		print("Demo: sélection de " .. egg.name)
	end)
end

-- Controls

toggle.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

close.MouseButton1Click:Connect(function()
	main.Visible = false
end)

-- Drag window

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

print("Egg Finder UI loaded!")
