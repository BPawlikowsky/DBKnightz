extends Label

func _process(delta):
	self.text = str(get_parent().get_child(6).get_score())