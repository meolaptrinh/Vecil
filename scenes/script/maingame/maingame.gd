extends Node2D
@onready var map = $map;
@onready var levels = level_data.levels;
@onready var curlv = level_data.curlv;
@onready var maingame_data = $maingame_data;
@onready var topbar = $layertopbar/topbar;
@onready var timelabel = $layertopbar/timelabel;

@onready var day_time_calculator :=0.0;
@onready var day_time_second := 1.0;
@onready var month_days = [31,28,31,30,31,30,31,31,30,31,30,31];
@onready var stop_time = false;
@onready var ban_build = 0;
func _ready() -> void:
	map.texture = load(map_data.maps[maingame_data.level_id]["map"]);
	maingame_data.set_ready_data();
	topbar.showtopbar();
	show_day();
func _process(delta: float) -> void:
	if(!stop_time):
		day_time_calculator += delta;
	if(day_time_calculator>=day_time_second):
		day_time_calculator = 0.0;
		next_day();
		show_day();
func next_day():
	if(ban_build>0):
		ban_build-=1;
	for i in maingame_data.res_per_day:
		if(maingame_data.res_per_day[i] is int or maingame_data.res_per_day[i] is float):
			if(maingame_data.resources[i]<9999):
				maingame_data.resources[i] += maingame_data.res_per_day[i];
			else:
				maingame_data.resources[i] = 9999;
	if(maingame_data.day == 28 and maingame_data.month == 2):
		if(maingame_data.year%4 == 0):
			if(maingame_data.year%100 == 0):
				if(maingame_data.year%400 == 0):
					month_days[1] = 29;
				else:
					month_days[1] = 28;
			else:
				month_days[1] = 29;
		else:
			month_days[1] = 28;
			
	if(maingame_data.day<month_days[maingame_data.month-1]):
		maingame_data.day+=1;
	else:
		if(maingame_data.month<12):
			maingame_data.month+=1;
			maingame_data.day = 1;
		else:
			maingame_data.month = 1;
			maingame_data.day = 1;
			maingame_data.year+=1;
	topbar.showtopbar();
func show_day():
	timelabel.text = str(int(maingame_data.day))+"/"+str(int(maingame_data.month))+"/"+str(int(maingame_data.year));;
func get_mouse_color():
	var mouse_pos: Vector2 = get_viewport().get_mouse_position();
	var local_mouse_pos = map.make_canvas_position_local(mouse_pos);
	var img: Image = map.texture.get_image();	
	if (img and img.get_width() > local_mouse_pos.x and img.get_height() > local_mouse_pos.y and local_mouse_pos.x >= 0 and local_mouse_pos.y >= 0):
		return img.get_pixelv(local_mouse_pos);
	return Color.WHITE;
