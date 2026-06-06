extends Node
@onready var km = $kingmode;
@onready var gm = $genmode;
@onready var sgm = $subgenmode;
func _ready() -> void:
	km.texture_normal = load("res://res/img/buttons/level_select/kingmode2.png");
	gm.texture_normal = load("res://res/img/buttons/level_select/genermode1.png");
	sgm.texture_normal = load("res://res/img/buttons/level_select/subgen1.png"); 
	level_data.curmode = 0;


func _on_kingmode_pressed() -> void:
	gm.texture_normal = load("res://res/img/buttons/level_select/genermode1.png");
	sgm.texture_normal = load("res://res/img/buttons/level_select/subgen1.png"); 
	km.texture_normal = load("res://res/img/buttons/level_select/kingmode2.png");
	level_data.curmode = 0;

func _on_genmode_pressed() -> void:
	sgm.texture_normal = load("res://res/img/buttons/level_select/subgen1.png"); 
	gm.texture_normal = load("res://res/img/buttons/level_select/genermode2.png");
	km.texture_normal = load("res://res/img/buttons/level_select/kingmode1.png");
	level_data.curmode = 1;

func _on_subgenmode_pressed() -> void:
	sgm.texture_normal = load("res://res/img/buttons/level_select/subgen2.png"); 
	gm.texture_normal = load("res://res/img/buttons/level_select/genermode1.png");
	km.texture_normal = load("res://res/img/buttons/level_select/kingmode1.png");
	level_data.curmode = 2;
