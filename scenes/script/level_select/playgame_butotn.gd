extends TextureButton
@onready var namepopup = get_parent().get_node("namepopup");
@onready var labelrole = namepopup.get_node("container").get_node("namerolelabel");
@onready var nameline = namepopup.get_node("container").get_node("LineEdit");
func _on_pressed() -> void:
	namepopup.visible = true;
	namepopup.popup_centered();
	match level_data.curmode:
		0:
			labelrole.text = "Bạn là một nhà vua 👑";
		1:
			labelrole.text = "Bạn là một vị tướng quân 🗡️";
		2:
			labelrole.text = "Bạn là một phó tướng quân ⚔️";
func _on_okbutton_pressed() -> void:
	if(!nameline.text.strip_edges().is_empty()):
		get_tree().change_scene_to_file("res://scenes/maingame.tscn");
		music_manager.stop_music();
