extends VBoxContainer

func _ready():
	
	if get_node("/root/Arena/Player01") != null:
		$player_speed_edit.text = str( get_node("/root/Arena/Player01").get_speed())
		$player_speedup_edit.text = str( get_node("/root/Arena/Player01").get_speedup_scale())
	

func _on_player_speedup_edit_text_changed(new_text):
	
	get_tree().root.get_node("/root/Arena/Player01").speedup_scale = new_text.to_int()
	

func _on_player_speed_edit_text_changed(new_text):
	
	get_node("/root/Arena/Player01").set_speed(new_text.to_int())
	

func _on_player_speed_edit_focus_exited():
	
	$player_speed_edit.text = str( get_node("/root/Arena/Player01").get_speed())
	


func _on_player_speedup_edit_focus_exited():
	
	$player_speedup_edit.text = str( get_node("/root/Arena/Player01").get_speedup_scale())
	
