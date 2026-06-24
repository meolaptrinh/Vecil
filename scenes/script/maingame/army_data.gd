extends Node
var file = FileAccess.open("res://data/army.json",FileAccess.READ);
var json_text = file.get_as_text();
var data = JSON.parse_string(json_text);
@onready var army_dict = data["army"];
