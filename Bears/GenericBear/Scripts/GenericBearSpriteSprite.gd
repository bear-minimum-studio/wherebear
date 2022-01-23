class_name GenericBearSprite
extends Sprite

const ORIENTATION_SWAP_THRESHOLD := 5.0


func set_orientation(speed: Vector2):
	if(abs(speed.x) > ORIENTATION_SWAP_THRESHOLD):
		var orientation = -sign(speed.x) * abs(self.scale.x)
		self.scale.x = orientation

func _ready():
	self.material = self.material.duplicate()
	self.material.set_shader_param("u_replacement_color", _random_color())
	self.material.set_shader_param("u_replacement_color_2", _random_color())

func _random_color():
	randomize()
	var h = randf()
	var s = rand_range(0.6, 0.9)
	var v = rand_range(0.6, 0.9)
	return Color.from_hsv(h, s, v)
