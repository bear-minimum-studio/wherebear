class_name GenericBearSprite
extends Sprite

const ORIENTATION_SWAP_THRESHOLD := 5.0

func _ready():
	pass

func set_orientation(speed: Vector2):
	if(abs(speed.x) > ORIENTATION_SWAP_THRESHOLD):
		var orientation = -sign(speed.x) * abs(self.scale.x)
		self.scale.x = orientation
