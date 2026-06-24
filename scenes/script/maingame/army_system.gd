extends Node
@onready var buildingvar = $"../layertopbar/build_button"
@onready var map = $"../map/ArmyLayer";
@onready var maingame_data = $"../maingame_data";
@onready var army_user_panel = $"army_control_panel";
@onready var army = army_data.army_dict[maingame_data.level_id];
@onready var select_id = -1;
@onready var topbar = $"../layertopbar/topbar"
@onready var curdiv:Dictionary;
@onready var deffood = maingame_data.resources["army_food"];
var kinglead = false; #Vua leader
var sublead = false; # Phó Tướng leader
var genlead = false; # Tướng leader
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
func divi_pressed(divi):
	if(!buildingvar.placing):
		if(select_id != divi["id"]):
			curdiv = divi;
			army_user_panel.popup();
			select_id = divi["id"];
		else:
			army_user_panel.visible = false;
			select_id = -1;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_bt_4_pressed() -> void:
	if((level_data.curmode == 1 or curdiv["leader"] == "allyking") and curdiv["unit"]>1):
		var old_unit = curdiv["unit"];
		if(int(curdiv["unit"])%2 == 0):
			curdiv["unit"] /= 2;
		else:
			curdiv["unit"] = int(curdiv["unit"]/2) + 1;
		var divi_2 = curdiv.duplicate();
		divi_2["leader"] = "";
		divi_2["id"] = army.size();
		divi_2["unit"] = old_unit - curdiv["unit"];
		divi_2["pos_y"] -= 23;
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
		print("move");


func _on_bt_2_pressed() -> void:
	if(level_data.curmode == 1):
		if(!army_user_panel.panel_two_on):
			army_user_panel.panel_two();
		else:
			curdiv["leader"] = "allysubgen";
			sublead = true;
			army_user_panel.popup();
