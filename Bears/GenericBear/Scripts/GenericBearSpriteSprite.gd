class_name GenericBearSprite
extends Sprite

const ORIENTATION_SWAP_THRESHOLD := 5.0

var SKIN_COLOR_VARIANTS = [
	{ 1: Color("#000000") , 2: Color("#000000"), 3: Color("#000000") }, # default colors - mid brown
	{ 1: Color("#502a10") , 2: Color("#7e4216"), 3: Color("#372110") }, # dark brown
	{ 1: Color("#767370") , 2: Color("#524a45"), 3: Color("#3a3836") }, # grey
]

func set_orientation(speed: Vector2):
	if(abs(speed.x) > ORIENTATION_SWAP_THRESHOLD):
		var orientation = -sign(speed.x) * abs(self.scale.x)
		self.scale.x = orientation

func _ready():
	self.material = self.material.duplicate()
	self.material.set_shader_param("u_replacement_color", _random_color())
	self.material.set_shader_param("u_replacement_color_2", _random_color())

	var random_color_variant = randi() % SKIN_COLOR_VARIANTS.size()
	self.material.set_shader_param("u_skin_color_replacement_1", SKIN_COLOR_VARIANTS[random_color_variant][1])
	self.material.set_shader_param("u_skin_color_replacement_2", SKIN_COLOR_VARIANTS[random_color_variant][2])
	self.material.set_shader_param("u_skin_color_replacement_3", SKIN_COLOR_VARIANTS[random_color_variant][3])

func _random_color():
	randomize()
	var h = randf()
	var s = rand_range(0.6, 0.9)
	var v = rand_range(0.6, 0.9)
	return Color.from_hsv(h, s, v)
