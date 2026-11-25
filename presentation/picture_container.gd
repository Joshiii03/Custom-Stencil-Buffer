@tool
extends MarginContainer

@export var ratio: Vector2 = Vector2(1, 1):
	set(new_value):
		ratio = new_value
		_update_margins()

@export_range(0.0, 0.2) var screen_margin: float = 0.05:
	set(new_value):
		screen_margin = new_value
		_update_margins()

# Positive values shift content to the right
@export_range(-1.0, 1.0) var horizontal_offset: float = 0.0:
	set(new_value):
		horizontal_offset = new_value
		_update_margins()

func _ready():
	draw.connect(_update_margins)
	
	_update_margins()



func _update_margins():
	print("visibility changed", name)
	if ratio.x <= 0 or ratio.y <= 0:
		return

	var parent_size: Vector2 = size
	var outer_margin: float = parent_size.length() * screen_margin

	var available_size: Vector2 = parent_size - Vector2.ONE * outer_margin * 2.0

	var target_ratio: float = ratio.x / ratio.y
	var content_size: Vector2

	if available_size.x / available_size.y > target_ratio:
		content_size.y = available_size.y
		content_size.x = content_size.y * target_ratio
	else:
		content_size.x = available_size.x
		content_size.y = content_size.x / target_ratio

	# Calculate centered margins
	var remaining_x: float = parent_size.x - content_size.x
	var remaining_y: float = parent_size.y - content_size.y

	# Apply horizontal offset
	var offset: float = horizontal_offset * remaining_x / 2.0

	var margin_left: int = int(remaining_x / 2.0 - offset)
	var margin_right: int = int(remaining_x / 2.0 + offset)

	var margin_top: int = int(remaining_y / 2.0)
	var margin_bottom: int = int(remaining_y / 2.0)

	add_theme_constant_override("margin_left", margin_left)
	add_theme_constant_override("margin_right", margin_right)
	add_theme_constant_override("margin_top", margin_top)
	add_theme_constant_override("margin_bottom", margin_bottom)
