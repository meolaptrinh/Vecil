extends Node2D
@onready var map = $map;
@onready var levels = level_data.levels;
@onready var curlv = level_data.curlv;
@onready var maingame_data = $maingame_data
@onready var topbar = $layertopbar/topbar
func _ready() -> void:
	map.texture = load(levels[curlv]["map"]);
	maingame_data.set_ready_data();
	topbar.showtopbar();
	
#func _process(delta: float) -> void:
#	pass
