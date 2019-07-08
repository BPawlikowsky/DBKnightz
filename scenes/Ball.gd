extends KinematicBody2D

export var speed = 600
var velocity = Vector2(speed, 0)

func _ready():
	
	if get_parent().name == "Player01":
		translate(Vector2(40, 0))
	elif get_parent().name == "Player02":
		translate(Vector2(-40, 0))

func _process(delta):
	
	if global_position.x > get_viewport_rect().size.x + 10:
		get_parent().get_parent().get_node("Player01").set_score(get_parent().get_parent().get_node("Player01").get_score() + 1)
		queue_free()
	elif global_position.x < -10:
		get_parent().get_parent().get_node("Player02").set_score(get_parent().get_parent().get_node("Player02").get_score() + 1)
		queue_free()

func _physics_process(delta):
	set_as_toplevel(true)
	var col = move_and_collide(velocity * delta)
	if col:
		var ref = col.remainder.bounce(col.normal)
		velocity = velocity.bounce(col.normal)
		move_and_collide(ref)