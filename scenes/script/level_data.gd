extends Node
var file = FileAccess.open("res://data/level_data.json",FileAccess.READ);
var json_text = file.get_as_text();
var data = JSON.parse_string(json_text);
var levels = data["levels"];
var curlv = 0;
var curmode = 0;
