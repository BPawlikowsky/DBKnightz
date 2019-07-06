extends RigidBody2D

export var speed = 600

func _ready():
	if get_parent().name == "Player01":
		linear_velocity = Vector2(speed, 0)
	elif get_parent().name == "Player02":
		linear_velocity = Vector2(-speed, 0)



func _process(delta):
	
	if global_position.x > get_viewport_rect().size.x + 10:
		get_parent().get_parent().get_node("Player01").set_score(get_parent().get_parent().get_node("Player01").get_score() + 1)
		queue_free()
	elif global_position.x < -10:
		get_parent().get_parent().get_node("Player02").set_score(get_parent().get_parent().get_node("Player02").get_score() + 1)
		queue_free()

func _physics_process(delta):
	linear_velocity = linear_velocity.normalized() * speed * delta