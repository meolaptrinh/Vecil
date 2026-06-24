extends TextureRect
@onready var building_layer = $"building_layer";
@onready var army_layer = $"ArmyLayer";
#func _input(event: InputEvent) -> void:
		#if(event is InputEventMouseButton):
			#if(event.button_index == MOUSE_BUTTON_LEFT):
				#var mousePos = get_local_mouse_position();
				#print(mousePos.x," ",mousePos.y);


func _on_blayer_button_pressed() -> void:
	building_layer.visible = !building_layer.visible;
func _on_alayer_button_pressed() -> void:
	army_layer.visible = !army_layer.visible;
