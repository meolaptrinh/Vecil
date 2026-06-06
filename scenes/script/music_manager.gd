extends Node
var musicPlayer:AudioStreamPlayer;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	musicPlayer = AudioStreamPlayer.new();
	add_child(musicPlayer);
	musicPlayer.autoplay = true;
	play_music("res://res/music/main_theme.mp3");
func stop_music():
	musicPlayer.stop();
func play_music(file:String):
	if(!musicPlayer.playing):
		musicPlayer.stream = load(file);
		musicPlayer.play();
