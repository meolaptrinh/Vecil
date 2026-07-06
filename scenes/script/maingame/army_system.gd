extends Node
@onready var buildingvar = $"../layertopbar/build_button"
@onready var map = $"../map/ArmyLayer";
@onready var maingame_data = $"../maingame_data";
@onready var army_user_panel = $"army_control_panel";
@onready var topbar = $"../layertopbar/topbar"
@onready var land_system = $"../land_system";
@onready var army_path = $"../map/army_path"
@onready var onmap =$"../map";
@onready var army = army_data.army_dict[maingame_data.level_id];
@onready var select_id = -1;
@onready var curdiv:Dictionary;
@onready var deffood = maingame_data.resources["army_food"];
@onready var tex_size:Vector2;
var kinglead = false; #Vua leader
var sublead = false; # Phó Tướng leader
var genlead = false; # Tướng leader
var moving = false;
func _ready() -> void:
	army_user_panel.visible = false;
	show_army();
func show_army():
	for child in map.get_children():
		child.queue_free()
	for divi in army:
		if(divi == null):
			continue;
		var box = Button.new();
		box.text = "⚔️ "+str(int(divi["unit"]));
		var box_pos = Vector2(divi["pos_x"],divi["pos_y"]);
		#Set màu + bo góc
		var style_normal = StyleBoxFlat.new();
		var style_hover = StyleBoxFlat.new();
		var style_pressed = StyleBoxFlat.new();
		style_normal.bg_color = Color("a98300ff");
		style_hover.bg_color = Color("98a700ff");
		style_pressed.bg_color = Color("7d6400ff");
		style_normal.set_corner_radius_all(5);
		style_hover.set_corner_radius_all(5);
		style_pressed.set_corner_radius_all(5);
		box.add_theme_stylebox_override("normal", style_normal);
		box.add_theme_stylebox_override("hover", style_hover);
		box.add_theme_stylebox_override("pressed", style_pressed);
		#------
		box.pressed.connect(divi_pressed.bind(divi));
		box.set_position(box_pos);
		map.add_child(box);
		divi["node"] = box;
		divi["path"] = [];
func divi_pressed(divi):
	if(!buildingvar.placing):
		if(select_id != divi["id"]):
			curdiv = divi;
			army_user_panel.popup();
			select_id = divi["id"];
		else:
			army_user_panel.visible = false;
			select_id = -1;



func _on_bt_4_pressed() -> void:
	if((level_data.curmode == 1 or curdiv["leader"] == "allyking") and curdiv["unit"]>1):
		var old_unit = curdiv["unit"];
		if(int(curdiv["unit"])%2 == 0):
			curdiv["unit"] /= 2;
		else:
			curdiv["unit"] = int(curdiv["unit"]/2) + 1;
		var divi_2 = {
			"id": army.size(),
			"pos_x": curdiv["pos_x"],
			"pos_y": curdiv["pos_y"] - 23,
			"unit": old_unit - curdiv["unit"],
			"lv": curdiv["lv"],
			"leader": "",
			"type": curdiv["type"],

			"path": [],
			"path_index": 0
		}
		var p = land_system.nearest_land(
		Vector2i(
			int(curdiv["pos_x"]),
			int(curdiv["pos_y"] - 23)
			)
			)

		divi_2["pos_x"] = p.x
		divi_2["pos_y"] = p.y
		army.append(divi_2);
		curdiv = divi_2;
		show_army();


func _on_bt_3_pressed() -> void:
	if(army_user_panel.panel_two_on):
		army_user_panel.popup();
	else:
		army[curdiv["id"]] = null;
		army_user_panel.visible = false;
		maingame_data.resources["army_food"] += min(int(sqrt(curdiv["unit"]*deffood)),9999-maingame_data.resources["army_food"]);;
		maingame_data.resources["soldiers"] -= curdiv["unit"];
		show_army();
		topbar.showtopbar();


func _on_bt_1_pressed() -> void:
	if(army_user_panel.panel_two_on):
		curdiv["leader"] = "allygener";
		genlead = true;
		army_user_panel.popup();
	elif(level_data.curmode == 0 and kinglead == false):
		curdiv["leader"] = "allyking";
		army_user_panel.visible = false;
		select_id = -1;
		kinglead = true;
	elif(level_data.curmode == 1 or kinglead == true):
		moving = true
		army_user_panel.visible = false


func _on_bt_2_pressed() -> void:
	if(level_data.curmode == 1):
		if(!army_user_panel.panel_two_on):
			army_user_panel.panel_two();
		else:
			curdiv["leader"] = "allysubgen";
			sublead = true;
			army_user_panel.popup();


func _on_bt_5_button_down() -> void:
	if(level_data.curmode == 1):
		if(maingame_data.resources["army_food"]>=curdiv["unit"]*0.15*curdiv["lv"]):
			maingame_data.resources["army_food"] -= curdiv["unit"]*0.3*curdiv["lv"];
			curdiv["lv"]+=1;
		army_user_panel.visible = false;



func _process(delta: float) -> void:
	for divi in army:
		if divi == null:
			continue

		if divi["path"].is_empty():
			continue

		var target: Vector2 = divi["path"][0]

		var pos = Vector2(divi["pos_x"], divi["pos_y"])
		pos = pos.move_toward(target, 80 * delta)

		divi["pos_x"] = pos.x
		divi["pos_y"] = pos.y
		divi["node"].position = pos

		if pos.distance_to(target) < 1:
			divi["path"].pop_front()

			if divi == curdiv:
				army_path.path = divi["path"]
				army_path.queue_redraw()
func _input(event):
	if !moving:
		return

	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:

		var mouse = map.get_local_mouse_position()
		if mouse.x < 0 or mouse.y < 0:
			moving = false
			return

		if mouse.x >= tex_size.x or mouse.y >= tex_size.y:
			moving = false
			return
		curdiv["path"] = land_system.find_path(
			Vector2i(curdiv["pos_x"], curdiv["pos_y"]),
			Vector2i(mouse.x, mouse.y)
		)

		army_path.path = curdiv["path"] #line 174
		army_path.queue_redraw()

		moving = false
