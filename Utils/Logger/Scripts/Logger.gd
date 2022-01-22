class_name Logger
const LOGGER_LEVEL := 3

static func info(message) -> void:
	if(LOGGER_LEVEL > 2):
		print('INFO: ', message)

static func debug(message) -> void:
	if(LOGGER_LEVEL > 1):
		print('DEBUG: ', message)

static func warn(message) -> void:
	if(LOGGER_LEVEL > 0):
		print('WRAN: ', message)

static func err(message) -> void:
	printerr('ERROR: ', message)
