extends Label

var vertical_offset = 4
var horizontal_margin = 30

func focus(target: Control) -> void:
	self.rect_global_position.x = target.rect_global_position.x - self.rect_size.x - horizontal_margin
	self.rect_global_position.y = target.rect_global_position.y + vertical_offset
