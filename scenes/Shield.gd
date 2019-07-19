extends StaticBody2D

var move_speed = 0.1
var new_position_v = Vector2()
var pass_delta = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass_delta = delta
	pass


func _on_ShieldArea_body_entered(body):
	if body.is_in_group("balls"):
		print("Ball! " + body.name)
		var v1 = get_angle_to(body.position.normalized() - position.normalized())
		set_rotation( v1 * move_speed * pass_delta)
	pass # Replace with function body.
	pass # Replace with function body.
