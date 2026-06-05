extends TextureRect
func setimg():
	var prev = get_parent().get_node("prev_img");
	var after = get_parent().get_node("after_img");
	var des = get_parent().get_node("desLabel");
	var diff = get_parent().get_node("diff_label");
	texture = load(level_data.levels[level_data.curlv]["image"]);
	des.text = level_data.levels[level_data.curlv]["description"];
	print(level_data.levels[level_data.curlv]["difficulty"]);
	match level_data.levels[level_data.curlv]["difficulty"]:
		0.0:
			diff.text = "Áp đảo";
			diff.add_theme_color_override("font_color",Color(0.27, 0.896, 0.0, 1.0));
		1.0:
			diff.text = "Cân bằng";
			diff.add_theme_color_override("font_color",Color(0.0, 0.64, 0.844, 1.0));
		2.0:
			diff.text = "Tử thủ";
			diff.add_theme_color_override("font_color",Color(0.614, 0.13, 0.159, 1.0));
		3.0:
			diff.text = "Huyền thoại"
			diff.add_theme_color_override("font_color",Color(0.752, 0.648, 0.0, 1.0));
	#show prev and next level
	if(level_data.curlv>0):
			prev.texture = load(level_data.levels[level_data.curlv-1]["mini_image"]);
	else:
		prev.texture = null;
	if(level_data.curlv<level_data.levels.size()-1):
			after.texture = load(level_data.levels[level_data.curlv+1]["mini_image"]);
	else:
		after.texture = null;
func _ready() -> void:
	setimg();
