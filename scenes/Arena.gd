extends Node2D

var player_packered = preload("res://scenes/Player.tscn")

var player01
var player02

func _ready():
	player01 = player_packered.instance()
	player02 = player_packered.instance()
	add_child(player01)
	get_child(3).name = "Player01"
	get_child(3).set_position(Vector2(100, get_viewport_rect().size.y/2))
	
	add_child(player02)
	get_child(4).name = "Player02"
	get_child(4).set_position(Vector2(get_viewport_rect().size.x - 100, get_viewport_rect().size.y/2))
	
	$Player02.set_move_left("ui_2_left")
	$Player02.set_move_right("ui_2_right")
	$Player02.set_move_up("ui_2_up")
	$Player02.set_move_down("ui_2_down")
	$Player02.set_throw_ball("ui_2_accept")