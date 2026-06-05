extends Camera2D

@export var move_speed: float = 800.0
@export var zoom_step: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 3.0
@onready var map = get_parent().get_node("map");
@onready var mapsize = map.size;
func _ready():
	limit_left = -100;
	limit_top = -150;
	limit_right = mapsize.x + 200;
	limit_bottom = mapsize.y+200;
func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		dir.x -= 1;

	if Input.is_action_pressed("ui_right"):
		dir.x += 1;

	if Input.is_action_pressed("ui_up"):
		dir.y -= 1;

	if Input.is_action_pressed("ui_down"):
		dir.y += 1;

	if dir != Vector2.ZERO:
		position += dir.normalized() * move_speed * delta;


func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:

		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			var new_zoom = zoom.x - zoom_step;
			new_zoom = clamp(new_zoom, min_zoom, max_zoom);
			zoom = Vector2(new_zoom, new_zoom);

		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			var new_zoom = zoom.x + zoom_step;
			new_zoom = clamp(new_zoom, min_zoom, max_zoom);
			zoom = Vector2(new_zoom, new_zoom);
