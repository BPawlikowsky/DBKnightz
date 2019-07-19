extends KinematicBody2D

signal player_ready

export var speed = 400 setget set_speed, get_speed

var packedball = load("res://scenes/Ball.tscn")

var move_left = "ui_left" setget set_move_left
var move_right = "ui_right" setget set_move_right
var move_up = "ui_up" setget set_move_up
var move_down = "ui_down" setget set_move_down
var throw_ball = "ui_accept" setget set_throw_ball
var activate_sheld = "ui_shield" setget set_shield

var cooldown = 0 
export var cooldown_time = 60 setget set_cooldown, get_cooldown

var shield_up = false setget set_shield_up, get_shield_up

var score = 0 setget set_score, get_score

export var speedup_scale = 100 setget set_speedup_scale, get_speedup_scale
var speedup = 0 

var inertia_factor = 0.95 setget set_inertia_factor, get_inertia_factor
var inertia = Vector2()

var signal_emitted = false

var ball_speed = 600 setget set_ball_speed, get_ball_speed

var balls_hit_shield = 0 setget set_balls_hit_shield, get_balls_hit_shield

var pass_delta

var lives = 30 setget set_lives, get_lives

var ball_pos = 50 setget set_ball_pos, get_ball_pos

######################## GETTERS | SETTERS #############################

func set_ball_pos(new_pos): ball_pos = new_pos
func get_ball_pos(): return ball_pos

func set_lives(new_lives): lives = new_lives
func get_lives(): return lives

func set_balls_hit_shield(new_set): balls_hit_shield = new_set
func get_balls_hit_shield(): return balls_hit_shield

func set_inertia_factor(new_factor): inertia_factor = new_factor
func get_inertia_factor(): return inertia_factor

func set_ball_speed(new_speed): ball_speed = new_speed
func get_ball_speed(): return ball_speed

func set_speed(new_speed): speed = new_speed
func get_speed(): return speed

func set_speedup_scale(new_speedup): speedup_scale = new_speedup
func get_speedup_scale(): return speedup_scale

func set_shield_up(status): shield_up = status
func get_shield_up(): return shield_up

func set_cooldown(new_cooldown): cooldown = new_cooldown
func get_cooldown(): return cooldown

func set_shield(new_shield): activate_sheld = new_shield
func set_move_left(new_left): move_left = new_left

func set_move_right(new_right): move_right = new_right
func set_move_up(new_up): move_up = new_up

func set_move_down(new_down): move_down = new_down
func set_throw_ball(new_throw_ball): throw_ball = new_throw_ball

func set_score(new_score): score = new_score
func get_score(): return score

func _ready():
	connect("player_ready", get_node("/root/Arena/Editor"), "_on_player_ready")
	

################ _PROCESS ####################

func _process(delta):
	pass_delta = delta
	if !signal_emitted:
		emit_signal("player_ready")
		signal_emitted = true
	
	movePlayer(delta, Vector2());
	
	if cooldown > 0:
		cooldown -= 1

################ Custom Funcs ##################

func hitPlayer(dir):
	movePlayer(pass_delta, dir)
	

func movePlayer(delta, velocity):
	
	#==# Push logic
	if velocity != Vector2():
		velocity = (velocity * delta * speed)
		inertia = move_and_slide(velocity + inertia)
		inertia = inertia * inertia_factor
	
	#==# Speedup meter
	if speedup < speed: speedup += speedup_scale
	
	if name == "Player01" and get_parent().get_node("Player02") != null:
		if position.dot(get_parent().get_node("Player02").position) != -1:
			print(str(rotation))
			var v1 =  get_angle_to(get_parent().get_node("Player02").position) + rotation 
			
			
			set_rotation(v1)
			
	if name == "Player02" and get_parent().get_node("Player01") != null:
		if position.dot(get_parent().get_node("Player01").position) != -1:
			print(str(rotation))
			var v1 =  get_angle_to(get_parent().get_node("Player01").position) + rotation 
			
			
			set_rotation(v1)
	
	#==# Controls
	if Input.is_action_pressed(move_left):
		velocity.x -= 1
	if Input.is_action_pressed(move_right):
		velocity.x += 1
	if Input.is_action_pressed(move_up):
		velocity.y -= 1
	if Input.is_action_pressed(move_down):
		velocity.y += 1
	if Input.is_action_just_pressed(throw_ball) and cooldown == 0 and !shield_up:
		var ball = packedball.instance()
		ball.connect("on_collision", get_parent(), "_on_ball_collision")
		ball.connect("on_stage_exit", get_parent(), "_reset_arena")
		ball.set_speed(ball_speed)
		var v1 =  get_parent().get_node("Player02").position - position
		var v2 = get_angle_to(get_parent().get_node("Player02").position.normalized() - position.normalized())
		ball.position += Vector2(ball_pos, 0)
		ball.velocity = v1*0.7
		ball.set_rotation(v2)
		add_child(ball)
		cooldown = cooldown_time
	
	#==# Stay still
	if velocity.x == 0 and velocity.y == 0:
		speedup = 0
	
	#==# actual movement
	velocity = (velocity.normalized() * delta * speed)
	
	inertia = move_and_slide(velocity + inertia)
	
	inertia = inertia * inertia_factor