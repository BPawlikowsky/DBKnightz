extends Node2D

var player_packered = preload("res://scenes/Player.tscn")

var player01
var player02

func _ready():
	player01 = player_packered.instance()
	player02 = player_packered.instance()
	add_child(player01)
	get_child(4).name = "Player01"
	get_child(4).set_position(Vector2(100, get_viewport_rect().size.y / 2))
	
	add_child(player02)
	get_child(5).name = "Player02"
	get_child(5).set_position(Vector2(get_viewport_rect().size.x - 100, get_viewport_rect().size.y/2))
	
	$Player02.set_move_left("ui_2_left")
	$Player02.set_move_right("ui_2_right")
	$Player02.set_move_up("ui_2_up")
	$Player02.set_move_down("ui_2_down")
	$Player02.set_throw_ball("ui_2_accept")
	$Player02/Shield.rotation = deg2rad(180)
	
func _process(delta):
	
	if get_child(4).get_cooldown() == 0:
		if Input.is_action_pressed("ui_shield"):
			get_child(4).set_shield_up(true)
			get_child(4).get_node("Shield").visible = true
			get_child(4).get_node("Shield/CollisionShape2D").disabled = false
		else:
			get_child(4).set_shield_up(false)
			get_child(4).get_node("Shield").visible = false
			get_child(4).get_node("Shield/CollisionShape2D").disabled = true
	
	if get_child(5).get_cooldown() == 0:
		if Input.is_action_pressed("ui_2_shield"):
			get_child(5).set_shield_up(true)
			get_child(5).get_node("Shield").visible = true
			get_child(5).get_node("Shield/CollisionShape2D").disabled = false
		else:
			get_child(5).set_shield_up(false)
			get_child(5).get_node("Shield").visible = false
			get_child(5).get_node("Shield/CollisionShape2D").disabled = true