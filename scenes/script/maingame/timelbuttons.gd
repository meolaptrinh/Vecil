extends Label
@onready var maingame = get_parent().get_parent();


func _on_stop_time_button_pressed() -> void:
	maingame.stop_time = true;


func _on_half_time_button_pressed() -> void:
	maingame.day_time_second = 2;
	maingame.stop_time = false;


func _on_once_time_button_pressed() -> void:
	maingame.day_time_second = 1;
	maingame.stop_time = false;


func _on_double_time_button_pressed() -> void:
	maingame.day_time_second = 0.5;
	maingame.stop_time = false;
