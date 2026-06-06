extends Node
@onready var curlv = level_data.curlv;
@onready var levels = level_data.levels;
@onready var characters = character.levels;
@onready var food = int(levels[curlv]["food"]);
@onready var iron = int(levels[curlv]["iron"]);
@onready var wood = int(levels[curlv]["wood"]);
@onready var population = int(levels[curlv]["population"]);
func set_to_default():
	food = levels[curlv]["food"];
	iron = levels[curlv]["iron"];
	wood = levels[curlv]["wood"];
	population = levels[curlv]["population"];
