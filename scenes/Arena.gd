extends Node2D

var player_packered = preload("res://scenes/Player.tscn")

var player01
var player02

var player01_start_pos = Vector2()
var player02_start_pos = Vector2()

################ _READY ###################

func _ready():
	
	# Initializing players start positions
	player01_start_pos = Vector2(100, get_viewport_rect().size.y / 2)
	player02_start_pos = Vector2(get_viewport_rect().size.x - 100, get_viewport_rect().size.y/2)
	
	# Instancing players from PackedScene
	player01 = player_packered.instance()
	player02 = player_packered.instance()
	
	# Add Player01 to scene and add name and position
	add_child(player01)
	get_child(5).name = "Player01"
	get_child(5).set_position(player01_start_pos)
	
	# Add Player02 to scene and add name and position
	add_child(player02)
	get_child(6).name = "Player02"
	get_child(6).set_position(player02_start_pos)
	
	# Player02 key setup and shield direction
	$Player02.set_move_left("ui_2_left")
	$Player02.set_move_right("ui_2_right")
	$Player02.set_move_up("ui_2_up")
	$Player02.set_move_down("ui_2_down")
	$Player02.set_throw_ball("ui_2_accept")
	$Player02/Shield.rotation = deg2rad(180)

################ _PROCESS ##################

func _process(delta):
	
	if $Player01.get_cooldown() == 0:
		if Input.is_action_pressed("ui_shield"):
			shield_up($Player01)
		else:
			shield_down($Player01)
	
	if $Player02.get_cooldown() == 0:
		if Input.is_action_pressed("ui_2_shield"):
			shield_up($Player02)
		else:
			shield_down($Player02)

################# CUSTOM FUNCS ###################

# Ball collision signals for future
func _on_ball_collision(ball_collision):
	#print("ball colided with" + ball_collision.collider.name)
	pass

# Reseting arena and players after a score
func _reset_arena(which_player):
	
	# Delete all balls
	for ball in get_tree().get_nodes_in_group("balls"):
		ball.queue_free()
	
	# Reset Player01
	$Player01.position = player01_start_pos
	shield_down($Player01)
	$Player01.set_cooldown(60)
	
	# Reset Player02
	$Player02.position = player02_start_pos
	shield_down($Player02)
	$Player02.set_cooldown(60)

func shield_up(player):
	player.set_shield_up(true)
	player.get_node("Shield").visible = true
	player.get_node("Shield/CollisionShape2D").disabled = false

func shield_down(player):
	player.set_shield_up(false)
	player.get_node("Shield").visible = false
	player.get_node("Shield/CollisionShape2D").disabled = true