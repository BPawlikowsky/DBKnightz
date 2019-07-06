extends Label

func _process(delta):
	self.text = str(get_parent().get_child(3).get_score())
