extends TextureRect
func setimg():
	var prev = get_parent().get_node("prev_img");
	var after = get_parent().get_node("after_img");
	var des = get_parent().get_node("desLabel");
	texture = load(level_data.levels[level_data.curlv]["image"]);
	des.text = level_data.levels[level_data.curlv]["description"];
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
