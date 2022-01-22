extends GenericBear

export var _untransformed_sprite : Texture
export var _transformed_sprite : Texture

var contaminated := false
var transformed := false

func _ready() -> void:
	randomize()
	_set_sprite(_untransformed_sprite)

func _update_input_vector() -> void:
	if(randf() < 0.05):
		_input_vector.x = randf() - 0.5
		_input_vector.y = randf() - 0.5

func _parse_inputs() -> void:
	._parse_inputs()
	if(randf() < 0.001):
		_roulade()

func _update() -> void:
	# TODO Implement real conditions
	if(get_position().y < 50 || get_position().y > 550):
		kill()
	if(get_position().y < 300):
		heal()
	if(get_position().y > 300):
		contaminate()
	if(get_position().x > 512):
		transform()
	if(get_position().x < 512):
		untransform()


func contaminate() -> void:
	if(contaminated):
		return
	
	contaminated = true
	Logger.debug('Contaminated')
	
func heal() -> void:
	if(!contaminated):
		return
	
	contaminated = false
	Logger.debug('Healthy')


func transform() -> void:
	if(transformed):
		return
	
	if(contaminated):
		transformed = true
		_set_sprite(_transformed_sprite)
	Logger.debug('Transformed')

func untransform() -> void:
	if(!transformed):
		return
	
	transformed = false
	_set_sprite(_untransformed_sprite)
	Logger.debug('Untransformed')
