extends Node2D

var path = [];
func _draw():
	if path.size() < 2:
		return

	for i in range(path.size()-1):
		draw_line(
			Vector2(path[i]),
			Vector2(path[i+1]),
			Color.YELLOW,
			2.0
		)
