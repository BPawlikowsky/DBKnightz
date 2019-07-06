extends KinematicBody2D

export var speed = 40

var packedball = preload("res://scenes/Ball.tscn")

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_just_pressed("ui_accept"):
		var ball = packedball.instance()
		add_child(ball)
	
	
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	print(position)