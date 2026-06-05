extends Node2D
@onready var map = $map;
@onready var levels = level_data.levels;
@onready var curlv = level_data.curlv;
func _ready() -> void:
	map.texture = load(levels[curlv]["map"]);
func _process(delta: float) -> void:
	pass
