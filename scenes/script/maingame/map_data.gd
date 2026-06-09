extends Node
var file = FileAccess.open("res://data/maps.json",FileAccess.READ);
var json_text = file.get_as_text();
var maps = JSON.parse_string(json_text);
