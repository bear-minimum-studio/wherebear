extends Control
class_name BaseMenu

var _calling_scene = null


func show_from(calling_scene):
	self._calling_scene = calling_scene
	self.show()

func _show_calling_menu() -> void:
	self.hide()
	if _calling_scene != null:
		_calling_scene.show_from(self)

# set button that grab focus when scene is set visible
func _default_focus() -> void:
	assert(false,"This method has to be implemented by children")
