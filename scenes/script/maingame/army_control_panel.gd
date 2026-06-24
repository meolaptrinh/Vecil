extends PopupPanel
@onready var panel_bt1 = $"VBoxContainer/bt1";
@onready var panel_bt2 = $"VBoxContainer/bt2";
@onready var panel_bt3 = $"VBoxContainer/bt3";
@onready var panel_bt4 = $"VBoxContainer/bt4"
@onready var panel_bt5 = $"VBoxContainer/bt5"
@onready var army_panel_label = $"VBoxContainer/army_panel_label";
@onready var maingame_data = get_parent().get_parent().get_node("maingame_data");
@onready var army_system = $"..";
var panel_two_on = false;
func _on_about_to_popup() -> void:
	panel_two_on = false;
	army_panel_label.visible = true;
	if(level_data.curmode == 1 or army_system.curdiv["leader"] == "allyking"):
		panel_bt2.visible = (army_system.curdiv["leader"] == "");
		panel_bt3.visible = true;
		panel_bt4.visible = true;
		panel_bt5.visible = true;
		panel_bt1.text = "Di chuyển quân đội";
		panel_bt2.text = "Chọn chỉ huy";
		panel_bt3.text = "Giải tán";
		panel_bt4.text = "Chia làm hai đoàn";
		panel_bt5.text = "Nâng cấp đoàn quân";
		if(maingame_data.resources["morale"]>8000):
			army_panel_label.text = "Chúng tôi chờ lệnh từ " + character.charname + ", \n vị anh hùng anh dũng bậc nhất \n của đất nước";
		elif(maingame_data.resources["morale"]>6800):
			army_panel_label.text = "Chúng tôi không sợ thất bại, vẫn một lòng tin vào ngài " + character.charname;
		elif(maingame_data.resources["morale"]>5500):
			army_panel_label.text = "Ngài " + character.charname + " trí dũng song \n toàn, nhất định sẽ cứu quân \n sĩ khỏi thất bại";
		else:
			army_panel_label.text = "Nhất định rằng chủ công " + character.charname + "\n sẽ giúp quân sĩ vượt qua khó khăn\nnhưng thất bại là quá lớn";;
		var power_atk;
		if(army_system.curdiv["leader"] == ""):
			power_atk = min(sqrt(army_system.curdiv["unit"]*army_system.curdiv["lv"]),9999);
		else:
			power_atk = min(sqrt(army_system.curdiv["unit"]*army_system.curdiv["lv"]*character.characters[maingame_data.level_id][army_system.curdiv["leader"]]["atk"]),9999)
		army_panel_label.text += "\n Sức mạnh của đoàn \n quân này là " + str(int(power_atk));
	elif(level_data.curmode == 0):
		panel_bt1.text = "Ta sẽ tự mình dẫn dắt";
		panel_bt1.visible  = !army_system.kinglead;
		panel_bt2.visible = false;
		panel_bt3.visible = false;
		panel_bt4.visible = false;
		panel_bt5.visible = false;
		army_panel_label.text = "Hoàng thượng " +character.charname + " vạn tuế, những \nviệc này cứ để tướng quân \n " + character.characters[maingame_data.level_id]["allygener"]["name"] + " phụ trách";;
	elif(level_data.curmode == 2):
		panel_bt1.text = "Nộp đơn xin chỉ huy";
		panel_bt1.visible  = !army_system.sublead;
		panel_bt2.visible = false;
		panel_bt3.visible = false;
		panel_bt4.visible = false;
		panel_bt5.visible = false;
		army_panel_label.text = "Ngài không có quyền kiểm soát quân \n đội, thưa phó tướng";		
func _ready() -> void:
	position = Vector2(900,0);
func panel_two():
	panel_two_on = true;
	if(level_data.curmode == 1):
		panel_bt1.visible = !army_system.genlead;
		panel_bt2.visible = !army_system.sublead;
		panel_bt3.visible = true;
		panel_bt4.visible = false;
		panel_bt4.visible = false;
		panel_bt5.visible = false;
		if(army_system.genlead and army_system.sublead):
			army_panel_label.visible = true;
			army_panel_label.text = "Triều đình đã hết tướng để \nchỉ huy";
		else:
			army_panel_label.visible = false;
		panel_bt1.text = "Ta sẽ tự dẫn dắt";
		panel_bt2.text = "Giao cho " + character.characters[maingame_data.level_id]["allysubgen"]["name"];
		panel_bt3.text = "Quay lại";
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
