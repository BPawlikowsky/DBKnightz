extends RigidBody2D

var direction = Vector2()
export var speed = 6000

func _ready():
	position = get_parent().get_position()
	direction = position - get_parent().get_node("Anchor").global_position

func _physics_process(delta):
	
	#var velocity = direction.normalized() * speed * delta
	#set_linear_velocity(velocity)
	pass