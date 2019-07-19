extends KinematicBody2D

signal on_collision(ball_collision)
signal on_stage_exit(which_player)

export var speed = 600 setget set_speed, get_speed
var velocity = Vector2(0, 0)

var ball_dur = 10 setget set_ball_dur, get_ball_dur

func set_ball_dur(new_dur): ball_dur = new_dur
func get_ball_dur(): return ball_dur 

func set_speed(new_speed): speed = new_speed
func get_speed(): return speed

################# _READY #####################

func _ready():
	"""
	if get_parent().name == "Player01":
		translate(Vector2(40, 0))
		velocity = Vector2(speed, 0)
	elif get_parent().name == "Player02":
		translate(Vector2(-50, 0))
		velocity = Vector2(-speed, 0)"""

################# _PROCESS ####################

func _process(delta):
	
	if global_position.x > get_viewport_rect().size.x + 10:
		get_parent().get_parent().get_node("Player01").set_score(get_parent().get_parent().get_node("Player01").get_score() + 1)
		emit_signal("on_stage_exit", "Player01")
		queue_free()
	elif global_position.x < -10:
		emit_signal("on_stage_exit", "Player02")
		get_parent().get_parent().get_node("Player02").set_score(get_parent().get_parent().get_node("Player02").get_score() + 1)
		queue_free()
	if ball_dur == 0:
		queue_free()

func _physics_process(delta):
	set_as_toplevel(true)
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		emit_signal("on_collision", collision)
		var reflect = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)