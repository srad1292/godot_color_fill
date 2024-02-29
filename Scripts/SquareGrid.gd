extends GridContainer

var game_square_resource = preload("res://Scenes/game_square.tscn")

var rows: int = 14
var grid: Array[GameSquare] = []
var colors: Array[Color] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	self.columns = rows
	_setup_colors()
	_create_grid()

func on_square_pressed(square: GameSquare):
	pass
	
func _setup_colors(): 
	var red: Color = Color(0.8490566, 0.2683339, 0.2683339, 1)
	var blue: Color = Color(0.3117657, 0.38893, 0.5849056, 1)
	var orange: Color = Color(0.8773585, 0.5854089, 0.2524475, 1)
	var purple: Color = Color(0.6499212, 0.2257921, 0.8113208, 1)
	var green: Color = Color(0.2980392, 0.6431373, 0.6431373, 1)
	var yellow: Color = Color(0.945098, 0.8705882, 0.3058824, 1)
	colors = [red, blue, orange, purple, green, yellow]
	
func _create_grid():
	var area_size: int = rows*rows
	var c: Color
	for i in area_size:
		c = _choose_color()
		_create_square(i, c)
	
func _create_square(index: int, color: Color):
	var game_square_instance = game_square_resource.instantiate()
	game_square_instance.connect("custom_on_pressed", on_square_pressed)
	add_child(game_square_instance)
	game_square_instance.initialize_me(index, color)
	grid.append(game_square_instance)
	
func _choose_color():
	return colors[randi() % colors.size()]
