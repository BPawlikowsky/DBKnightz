extends Label

func _process(delta):
	self.text = str(get_parent().get_child(5).get_score())