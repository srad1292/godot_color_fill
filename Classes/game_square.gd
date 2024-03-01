extends Button
class_name GameSquare

signal custom_on_pressed(square: GameSquare)

@export var seen: bool = false
@export var captured: bool = false
@export var squareColor: Color = Color(0.0, 1.0, 0.0)
@export var index: int = 0

var colorOption: ColorOption

var stylebox_flat := StyleBoxFlat.new()

func _ready():
	_set_style_overrides()
	self.set_custom_minimum_size(Vector2(36,36))
	self.focus_mode = Control.FOCUS_NONE

func initialize_me(index: int, color: ColorOption):
	self.index = index
	set_color(color)
	

func set_color(color: ColorOption):
	colorOption = color
	squareColor = colorOption.value
	self.modulate = squareColor
	stylebox_flat.bg_color = squareColor
	
func _set_style_overrides():
	self.add_theme_stylebox_override("normal", stylebox_flat)
	self.add_theme_stylebox_override("pressed", stylebox_flat)
	self.add_theme_stylebox_override("hover", stylebox_flat)




func _on_pressed():
	custom_on_pressed.emit(self)
