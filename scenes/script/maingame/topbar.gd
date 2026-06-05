extends ColorRect
@onready var foodshow = $food/label;
@onready var woodshow = $wood/label;
@onready var ironshow = $iron/label;
@onready var popshow = $population/label;
func showtopbar():
	foodshow.text = str(maingame_data.food)+"/9999";
	woodshow.text = str(maingame_data.iron)+"/9999";
	ironshow.text = str(maingame_data.wood)+"/9999";
	popshow.text = str(maingame_data.population)+"/9999";
func _ready() -> void:
	showtopbar();
