extends Node
var curlv = level_data.curlv;
var levels = level_data.levels;
var food = int(levels[curlv]["food"]);
var iron = int(levels[curlv]["iron"]);
var wood = int(levels[curlv]["wood"]);
var population = int(levels[curlv]["population"]);
func set_to_default():
	food = levels[curlv]["food"];
	iron = levels[curlv]["iron"];
	wood = levels[curlv]["wood"];
	population = levels[curlv]["population"];
