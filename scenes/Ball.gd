extends KinematicBody2D

signal on_collision(ball_collision)
signal on_stage_exit(which_player)

export var speed = 600
var velocity = Vector2(0, 0)

func _ready():
	
	if get_parent().name == "Player01":
		translate(Vector2(40, 0))
		velocity = Vector2(speed, 0)
	elif get_parent().name == "Player02":
		translate(Vector2(-50, 0))
		velocity = Vector2(-speed, 0)

func _process(delta):
	
	if global_position.x > get_viewport_rect().size.x + 10:
		get_parent().get_parent().get_node("Player01").set_score(get_parent().get_parent().get_node("Player01").get_score() + 1)
		emit_signal("on_stage_exit", "Player01")
		queue_free()
	elif global_position.x < -10:
		emit_signal("on_stage_exit", "Player02")
		get_parent().get_parent().get_node("Player02").set_score(get_parent().get_parent().get_node("Player02").get_score() + 1)
		queue_free()

func _physics_process(delta):
	set_as_toplevel(true)
	var collision = move_and_collide(velocity * delta)
	if collision:
		emit_signal("on_collision", collision)
		var reflect = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)