extends Node2D

var player_packered = preload("res://scenes/Player.tscn")

var player01
var player02

var player01_start_pos = Vector2()
var player02_start_pos = Vector2()

export var shield_hits = 4
export var cooldown_shield_hit = 120

var shield_speed
var shield_slide
var normal_speed
var normal_slide

################ _READY ###################

func _ready():
	
	# Initializing players start positions
	player01_start_pos = Vector2(100, get_viewport_rect().size.y / 2)
	player02_start_pos = Vector2(get_viewport_rect().size.x - 100, get_viewport_rect().size.y/2)
	
	# Instancing players from PackedScene
	player01 = player_packered.instance()
	player02 = player_packered.instance()
	
	normal_speed = player01.speed
	normal_slide = player01.speedup_scale
	shield_speed = int(player01.speed / 2)
	shield_slide = int(player01.speedup_scale / 2)
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

# Ball collision signals
func _on_ball_collision(ball_collision):
	
	# Push after ball hit player
	if ball_collision.get_collider().is_in_group("players"):
		
		var collided_player = ball_collision.get_collider()
		collided_player.hitPlayer(ball_collision.get_travel() * 4)
		
	if ball_collision.get_collider().name == "Shield":
		
		var collided_player = ball_collision.get_collider().get_parent()
		
		print("Found shield! Player:" + str(collided_player.name) + " balls hit: " + str(collided_player.balls_hit_shield))
		
		collided_player.hitPlayer(ball_collision.get_travel())
		
		collided_player.balls_hit_shield += 1
		
		if collided_player.balls_hit_shield >= shield_hits:
			
			shield_down(collided_player)
			collided_player.balls_hit_shield = 0
			collided_player.set_cooldown(cooldown_shield_hit)

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
	player.get_node("Shield/ShieldCollider").disabled = false
	player.speed = shield_speed

func shield_down(player):
	player.speed = normal_speed
	player.set_shield_up(false)
	player.get_node("Shield").visible = false
	player.get_node("Shield/ShieldCollider").disabled = true