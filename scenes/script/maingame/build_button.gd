extends TextureButton

@onready var invis = false;
@onready var colorRect = $ColorRect;
@onready var scrContainer = $ScrollContainer;
@onready var containerH = $ScrollContainer/containerH;
@onready var buildlist = buildings.buildings_list;
var pixelfont = load("res://res/fonts/dearpix-1-94.ttf");

func _on_pressed() -> void:
	invis = !invis;
	colorRect.visible = invis;
	scrContainer.visible = invis;
	containerH.visible = invis;
func _ready() -> void:
	colorRect.visible = false;
	scrContainer.visible = false;
	containerH.visible = false;
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
	print(building["name"]);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
