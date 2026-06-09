extends Node
#khai báo trước mấy cái biến hệ thống để tránh ghi đè 
@onready var curlv = level_data.curlv;
@onready var levels = level_data.levels;
@onready var chardata = character.levels[level_data.curlv];
@onready var level_id = levels[curlv]["id"];
#tài nguyên
@onready var resources = levels[curlv];
@onready var res_per_day = levels[curlv].duplicate();
#các biến thời gian
@onready var day = levels[curlv]["start_time"]["day"];
@onready var month = levels[curlv]["start_time"]["month"];
@onready var year = levels[curlv]["start_time"]["year"];

func set_ready_data():
	resources = levels[curlv];
	chardata = character.levels[curlv];
	
	day = levels[curlv]["start_time"]["day"];
	month = levels[curlv]["start_time"]["month"];
	year = levels[curlv]["start_time"]["year"];
	
	for i in res_per_day:
		if(res_per_day[i] is int or res_per_day[i] is float):
			res_per_day[i] = 0;

	match level_data.curmode:
		0:
			chardata["allyking"] = character.charname;
		1: 
			chardata["allygener"] = character.charname;
		2:
			chardata["allysubgen"] = character.charname;
		
	
