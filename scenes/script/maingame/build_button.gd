extends TextureButton

@onready var invis = false;
@onready var colorRect = $ColorRect;
@onready var scrContainer = $ScrollContainer;
@onready var cancelLabel = $cancel_label;
@onready var containerH = $ScrollContainer/containerH;
@onready var topbar = get_parent().get_node("topbar");
@onready var map = get_parent().get_parent().get_node("map");
@onready var layer = get_parent().get_parent().get_node("map").get_node("building_layer");
@onready var buildlist = buildings.buildings_list;
@onready var maingame_data = get_parent().get_parent().get_node("maingame_data");
@onready var maingame = get_parent().get_parent();
@onready var warn_popup = get_parent().get_parent().get_node("warn_popup");
@onready var label_warn = warn_popup.get_node("Label");
@onready var struct_cnt:Array[int];
var placing = false;
var pixelfont = preload("res://res/fonts/dearpix-1-94.ttf");
var placingimg = "";
var placingcost = 0;
var placingtype = "";
var placing_inpd = 0;
var placing_id = 0;
var placing_lm = -1;
func _on_pressed() -> void:
	invis = !invis;
	colorRect.visible = invis;
	scrContainer.visible = invis;
	containerH.visible = invis;
func _ready() -> void:
	struct_cnt.resize(buildlist.size());
	struct_cnt.fill(0);
	warn_popup.visible = false;
	colorRect.visible = false;
	scrContainer.visible = false;
	containerH.visible = false;
	cancelLabel.visible = false;
	if(level_data.curmode == 0 or level_data.curmode == 2):
		for building in buildlist:
			if(int(building["mode"]) == level_data.curmode):
				var buildcard = Button.new();
				var containerV = VBoxContainer.new();
				var namebuild = Label.new();
				var imgbuild = TextureRect.new();
				var costbuild = Label.new();
				#Gán các thông tin cần thiết 
				namebuild.text = building["name"];
				costbuild.text = str(int(building["cost"])) + (" % Tỉ lệ" if (level_data.curmode == 2) else " Gỗ");
				namebuild.add_theme_font_override("font",pixelfont);
				costbuild.add_theme_font_override("font",pixelfont);
				imgbuild.texture = load(building["img"]);
				#Căn giữa
				namebuild.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
				costbuild.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER;
				imgbuild.size_flags_horizontal = Control.SIZE_SHRINK_CENTER;
				
				#add node vào để hiển thị 
				containerV.add_child(namebuild);
				containerV.add_child(imgbuild);
				containerV.add_child(costbuild);
				buildcard.add_child(containerV);
				buildcard.custom_minimum_size = Vector2(88, 115);
				buildcard.pressed.connect(on_building_press.bind(building));
				containerH.add_child(buildcard);
	else:
		visible = false;
# hàm khi nhấn vào công trình 
func on_building_press(building):
	Input.set_custom_mouse_cursor(load(building["img"]),Input.CURSOR_ARROW);
	cancelLabel.visible = true;
	placingimg = building["img"];
	placingcost = building["cost"];
	placingtype = building["uses"]["type"];
	placing_inpd = building["uses"]["incre_per_day"];
	placing_id = building["id"];
	placing = true;
	if(level_data.curmode == 2):
		placing_lm = building["limit"];
func _input(event: InputEvent) -> void:
	if(placing):
		if(event is InputEventMouseButton):
			if(event.button_index == MOUSE_BUTTON_LEFT):
				if(level_data.curmode == 0 and maingame_data.resources["wood"]<placingcost):
					Input.set_custom_mouse_cursor(null);
					placing = false;
					placingimg = "";
					cancelLabel.visible = false;
					return;
				#Lấy màu con trỏ chuột
				var mouseColor = maingame.get_mouse_color();
				var mouse_pos: Vector2 = get_viewport().get_mouse_position();
				#kiểm tra màu đang nhấn phải VN k
				if(abs(mouseColor.r*255 - map_data.maps[maingame_data.level_id]["vn"]["r"])<0.5):
					if(abs(mouseColor.b*255 - map_data.maps[maingame_data.level_id]["vn"]["b"])<0.5):
						if(abs(mouseColor.g*255 - map_data.maps[maingame_data.level_id]["vn"]["g"])<0.5):
							if(level_data.curmode == 0):
								var structimg = TextureRect.new();
								structimg.texture = load(placingimg);
								var local_pos = map.make_canvas_position_local(mouse_pos);
								structimg.set_position(local_pos);
								layer.add_child(structimg);
								Input.set_custom_mouse_cursor(null);
								placing = false;
								placingimg = "";
								cancelLabel.visible = false;
								maingame_data.res_per_day[placingtype] += placing_inpd;
								maingame_data.resources["wood"]-=placingcost;
								topbar.showtopbar();
							else:
								if(maingame.ban_build>0):
									Input.set_custom_mouse_cursor(null);
									placing = false;
									placingimg = "";
									cancelLabel.visible = false;
									maingame.stop_time = true;
									warn_popup.visible = true;
									label_warn.text = "Cảnh báo \n Ngươi đang trong thời gian chấp hành lệnh cấm";
									return;
								if(struct_cnt[placing_id] == placing_lm):
									Input.set_custom_mouse_cursor(null);
									placing = false;
									placingimg = "";
									cancelLabel.visible = false;
									maingame.stop_time = true;
									warn_popup.visible = true;
									label_warn.text = "Cảnh báo \n Triều đình đã phê duyệt cho ngươi loại công trình \n này quá nhiều. Ngươi nên biết giới hạn";
									return;									
								var acp = randi_range(1,100);
								if(acp>placingcost):
									Input.set_custom_mouse_cursor(null);
									placing = false;
									placingimg = "";
									cancelLabel.visible = false;
									maingame.stop_time = true;
									warn_popup.visible = true;
									label_warn.text = "Cảnh báo \n Triều đình không phê chuẩn công trình của ngươi, phó tướng "+character.charname+"\n Ngươi bị cấm đề xuất trong 60 ngày \n ";;
									print(maingame.ban_build);
									maingame.ban_build = 60;
									return;
								else:
									var structimg = TextureRect.new();
									structimg.texture = load(placingimg);
									var local_pos = map.make_canvas_position_local(mouse_pos);
									structimg.set_position(local_pos);
									layer.add_child(structimg);
									Input.set_custom_mouse_cursor(null);
									placing = false;
									placingimg = "";
									cancelLabel.visible = false;
									struct_cnt[placing_id] +=1;
									
		elif(event is InputEventKey):
			if(event.keycode == KEY_X):
				Input.set_custom_mouse_cursor(null);
				placing = false;
				placingimg = "";
				cancelLabel.visible = false;
#func _process(delta: float) -> void:
#	pass;
