class_name GenericBearSprite
extends Sprite

const ORIENTATION_SWAP_THRESHOLD := 5.0

func _ready():
	pass

func set_orientation(horizontal_speed: float):
	if(abs(horizontal_speed) > ORIENTATION_SWAP_THRESHOLD):
		var orientation = -sign(horizontal_speed) * abs(self.scale.x)
		self.scale.x = orientation
