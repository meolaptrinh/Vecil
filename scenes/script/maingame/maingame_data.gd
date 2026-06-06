extends Node
@onready var curlv = level_data.curlv;
@onready var levels = level_data.levels;
@onready var chardata = character.levels[level_data.curlv];
@onready var food = int(levels[curlv]["food"]);
@onready var iron = int(levels[curlv]["iron"]);
@onready var wood = int(levels[curlv]["wood"]);
@onready var population = int(levels[curlv]["population"]);
func set_ready_data():
	food = levels[curlv]["food"];
	iron = levels[curlv]["iron"];
	wood = levels[curlv]["wood"];
	population = levels[curlv]["population"];
	chardata = character.levels[curlv];
	match level_data.curmode:
		0:
			chardata["allyking"] = character.charname;
		1: 
			chardata["allygener"] = character.charname;
		2:
			chardata["allysubgen"] = character.charname;
		
			
