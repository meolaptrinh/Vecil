extends TextureButton
func _on_pressed() -> void:
	music_manager.stop_music();
	get_tree().change_scene_to_file("res://scenes/maingame.tscn");
