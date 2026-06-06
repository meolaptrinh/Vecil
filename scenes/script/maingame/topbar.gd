extends ColorRect
@onready var foodshow = $food/label;
@onready var woodshow = $wood/label;
@onready var ironshow = $iron/label;
@onready var popshow = $population/label;
@onready var maingame_data = get_parent().get_parent().get_node("maingame_data");
func showtopbar():
	foodshow.text = str(int(maingame_data.food))+"/9999";
	woodshow.text = str(int(maingame_data.wood))+"/9999";
	ironshow.text = str(int(maingame_data.iron))+"/9999";
	popshow.text = str(int(maingame_data.population))+"/9999";
