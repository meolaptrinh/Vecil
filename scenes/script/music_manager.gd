extends Node
var musicPlayer:AudioStreamPlayer;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicPlayer = AudioStreamPlayer.new();
	add_child(musicPlayer);
	musicPlayer.stream = load("res://res/music/main_theme.mp3");
	musicPlayer.autoplay = true;
	musicPlayer.play();
func stop_music():
	musicPlayer.stop();
func play_music():
	if(!musicPlayer.playing):
		musicPlayer.play();
