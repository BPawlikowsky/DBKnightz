extends Label

func _process(delta):
	self.text = str(get_parent().get_child(4).get_score())