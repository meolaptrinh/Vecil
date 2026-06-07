extends ColorRect
@onready var slot1show = $slot1/label;
@onready var slot2show = $slot2/label;
@onready var slot3show = $slot3/label;
@onready var slot4show = $slot4/label;
@onready var slot1img = $slot1/icon;
@onready var slot2img = $slot2/icon;
@onready var slot3img = $slot3/icon;
@onready var slot4img = $slot4/icon;
@onready var maingame_data = get_parent().get_parent().get_node("maingame_data");
func showtopbar():
	if(level_data.curmode == 0):
		slot1show.text = str(int(maingame_data.resources["food"]))+"/9999";
		slot2show.text = str(int(maingame_data.resources["wood"]))+"/9999";
		slot3show.text = str(int(maingame_data.resources["iron"]))+"/9999";
		slot4show.text = str(int(maingame_data.resources["population"]))+"/9999";
		slot1img.texture = preload("res://res/img/resources/foodicon.png");
		slot2img.texture = preload("res://res/img/resources/iron_icon.png");
		slot3img.texture = preload("res://res/img/resources/woodicon.png");
		slot1img.texture = preload("res://res/img/resources/populationicon.png");
	if(level_data.curmode == 1):
		slot1show.text = str(int(maingame_data.resources["soldiers"]))+"/9999";
		slot1img.texture = preload("res://res/img/resources/soldiers.png");
