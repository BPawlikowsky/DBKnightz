extends VBoxContainer

func _on_player_ready():
	
	$player_speed_edit.text = str( get_node("/root/Arena/Player01").speed)
	$player_speedup_edit.text = str( get_node("/root/Arena/Player01").speedup_scale)
	$player_countdown_edit.text = str( get_node("/root/Arena/Player01").cooldown)
	$ball_speed_edit.text = str( get_node("/root/Arena/Player01").ball_speed)
	$player_speeddown_edit.text = str( get_node("/root/Arena/Player01").inertia_factor)

func _on_player_speedup_edit_text_changed(new_text):
	
	get_tree().root.get_node("/root/Arena/Player01").speedup_scale = new_text.to_int()
	

func _on_player_speed_edit_text_changed(new_text):
	
	get_node("/root/Arena/Player01").set_speed(new_text.to_int())

func _on_player_countdown_edit_text_changed(new_text):
	get_node("/root/Arena/Player01").set_cooldown(new_text.to_int())

func _on_player_speed_edit_focus_exited():
	
	$player_speed_edit.text = str( get_node("/root/Arena/Player01").get_speed())
	

func _on_player_speedup_edit_focus_exited():
	
	$player_speedup_edit.text = str( get_node("/root/Arena/Player01").get_speedup_scale())
	

func _on_ball_speed_edit_text_changed(new_text):
	var bodies = get_tree().get_nodes_in_group("balls")
	for body in bodies:
		body.set_speed(new_text.to_int())

func _on_ball_speed_edit_focus_exited():
	var bodies = get_tree().get_nodes_in_group("balls")
	for body in bodies:
		$ball_speed_edit.text = body.get_speed()


func _on_player_countdown_edit_focus_exited():
	$player_countdown_edit.text = str( get_node("/root/Arena/Player01").get_cooldown())
	pass # Replace with function body.


func _on_player_speeddown_edit_text_changed(new_text):
	get_node("/root/Arena/Player01").inertia_factor = new_text.to_float()
	pass # Replace with function body.
