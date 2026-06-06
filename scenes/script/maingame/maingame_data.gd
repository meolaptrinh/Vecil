extends Node
#khai báo trước mấy cái biến hệ thống để tránh ghi đè 
@onready var curlv = level_data.curlv;
@onready var levels = level_data.levels;
@onready var chardata = character.levels[level_data.curlv];
#các biến tài nguyên 
@onready var food = int(levels[curlv]["food"]);
@onready var iron = int(levels[curlv]["iron"]);
@onready var wood = int(levels[curlv]["wood"]);
@onready var population = int(levels[curlv]["population"]);
#các biến thời gian
@onready var day = levels[curlv]["start_time"]["day"];
@onready var month = levels[curlv]["start_time"]["month"];
@onready var year = levels[curlv]["start_time"]["year"];
func set_ready_data():
	food = levels[curlv]["food"];
	iron = levels[curlv]["iron"];
	wood = levels[curlv]["wood"];
	population = levels[curlv]["population"];
	
	chardata = character.levels[curlv];
	
	day = levels[curlv]["start_time"]["day"];
	month = levels[curlv]["start_time"]["month"];
	year = levels[curlv]["start_time"]["year"];
	
	match level_data.curmode:
		0:
			chardata["allyking"] = character.charname;
		1: 
			chardata["allygener"] = character.charname;
		2:
			chardata["allysubgen"] = character.charname;
		
			
