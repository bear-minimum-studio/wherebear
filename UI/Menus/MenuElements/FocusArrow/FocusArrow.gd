extends Label

onready var tween_x = $TweenX
onready var tween_y = $TweenY

var vertical_offset = 4
var horizontal_margin = 30


func focus(node: Control) -> void:
	# align right size of arrow rect to left side of node including margin
	var x = (  node.rect_global_position.x
			 - self.rect_size.x
			 - horizontal_margin)
	var y = node.rect_global_position.y + vertical_offset
	self._move_to(x,y)

func _move_to(x,y) -> void:
	# if arrow is at default position, works almost everytime :p
	if self.rect_global_position.x == 0:
		self._teleport_to(x,y)
	else:
		self._interpolate_to(x,y)

func _teleport_to(x,y) -> void:
	self.rect_global_position.x = x
	self.rect_global_position.y = y

func _interpolate_to(x,y) -> void:
	var transition_time = self._travel_time(x,y)
	var transition_interpolation_x = Tween.TRANS_LINEAR
	var transition_style_x = Tween.EASE_IN_OUT
	if self.rect_global_position.x > x:
		transition_interpolation_x = Tween.TRANS_EXPO
		transition_style_x = Tween.EASE_OUT
	elif self.rect_global_position.x < x:
		transition_interpolation_x = Tween.TRANS_EXPO
		transition_style_x = Tween.EASE_IN
	
	tween_x.interpolate_property(self, "rect_global_position:x",
		self.rect_global_position.x, x, transition_time,
		transition_interpolation_x, transition_style_x)
	tween_y.interpolate_property(self, "rect_global_position:y",
		self.rect_global_position.y, y, transition_time,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_x.start()
	tween_y.start()

func _travel_time(x,y) -> float:
	var distance = sqrt(  pow(self.rect_global_position.x - x,2) 
						+ pow(self.rect_global_position.y - y,2))
	return max(0.07, distance/3700) 
