extends GridContainer

var game_square_resource = preload("res://Scenes/game_square.tscn")

var rows: int = 14
var grid: Array[GameSquare] = []
var colors: Array[ColorOption] = []
var lastColor: ColorOption = ColorOption.new("White", Color(1.0, 1.0, 1.0))
var clicks = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.columns = rows
	_setup_colors()
	_create_grid()

func on_square_pressed(square: GameSquare):
	print("Pressed a square with index of: ", square.index)
	print("Color clicked: ", square.colorOption.name)
	print("Last color was: ", lastColor.name)
	if(square.colorOption.name == lastColor.name):
		return
	clicks += 1
	_capture_color(square.colorOption)
	
func _setup_colors(): 
	var red: ColorOption = ColorOption.new("Red", Color(0.8490566, 0.2683339, 0.2683339, 1))
	var blue: ColorOption = ColorOption.new("Blue", Color(0.3117657, 0.38893, 0.5849056, 1))
	var orange: ColorOption = ColorOption.new("Orange", Color(0.8773585, 0.5854089, 0.2524475, 1))
	var purple: ColorOption = ColorOption.new("Purple", Color(0.6499212, 0.2257921, 0.8113208, 1))
	var green: ColorOption = ColorOption.new("Green", Color(0.2980392, 0.6431373, 0.6431373, 1))
	var yellow: ColorOption = ColorOption.new("Yellow", Color(0.945098, 0.8705882, 0.3058824, 1))
	colors = [red, blue, orange, purple, green, yellow]
	
func _create_grid():
	var area_size: int = rows*rows
	var c: ColorOption
	for i in area_size:
		c = _choose_color()
		_create_square(i, c)
	grid[0].captured = true
	_capture_color(grid[0].colorOption)
	
func _create_square(index: int, color: ColorOption):
	var game_square_instance = game_square_resource.instantiate()
	game_square_instance.connect("custom_on_pressed", on_square_pressed)
	add_child(game_square_instance)
	game_square_instance.initialize_me(index, color)
	grid.append(game_square_instance)
	
func _choose_color() -> ColorOption:
	return colors[randi() % colors.size()]
	
func _capture_color(colorOption: ColorOption):
	if(colorOption.name == lastColor.name):
		return 
	lastColor = colorOption
	_capture_square_if_match(0, colorOption)
	_reset_seen_flag()
	_update_captured_colors(colorOption)
	
	
func _capture_square_if_match(index: int, colorOption: ColorOption):
	if(grid[index].seen):
		return
	grid[index].seen = true
	
	if(!grid[index].captured && !grid[index].colorOption.name == colorOption.name):
		return
	grid[index].captured = true
	
	if(index % rows != 0):
		_capture_square_if_match(index-1, colorOption)
	if((index+1)%rows != 0):
		_capture_square_if_match(index+1, colorOption)
	if(index > rows-1):
		_capture_square_if_match(index-rows, colorOption)
	if(index < (rows*rows)-rows):
		_capture_square_if_match(index+rows, colorOption)

func _reset_seen_flag():
	for square in grid:
		square.seen = false

func _update_captured_colors(colorOption: ColorOption):
	for square in grid:
		if(square.captured == true):
			square.set_color(colorOption)
