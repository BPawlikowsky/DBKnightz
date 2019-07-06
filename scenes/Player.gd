extends KinematicBody2D

export var speed = 40

var packedball = load("res://scenes/Ball.tscn")

var move_left = "ui_left" setget set_move_left
var move_right = "ui_right" setget set_move_right
var move_up = "ui_up" setget set_move_up
var move_down = "ui_down" setget set_move_down
var throw_ball = "ui_accept" setget set_throw_ball
var activate_sheld = "ui_shield" setget set_shield

var cooldown = 0 setget ,get_cooldown
var shield_up = false setget set_shield_up, get_shield_up

var score = 0 setget set_score, get_score

func set_shield_up(status):
	shield_up = status

func get_shield_up():
	return shield_up

func get_cooldown():
	return cooldown

func set_shield(new_shield):
	activate_sheld = new_shield

func set_move_left(new_left):
	move_left = new_left

func set_move_right(new_right):
	move_right = new_right

func set_move_up(new_up):
	move_up = new_up

func set_move_down(new_down):
	move_down = new_down

func set_throw_ball(new_throw_ball):
	throw_ball = new_throw_ball

func set_score(new_score):
	score = new_score

func get_score():
	return score



func _process(delta):
	var velocity = Vector2()
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
		add_child(ball)
		cooldown = 60
	
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	
	if cooldown > 0:
		cooldown -= 1