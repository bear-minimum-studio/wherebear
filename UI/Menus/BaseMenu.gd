extends Control
class_name BaseMenu

var _calling_scene = null

func _ready():
	self.connect("visibility_changed", self, "_on_visibility_changed")

func show_from(calling_scene):
	self._calling_scene = calling_scene
	_calling_scene.hide()
	self.show()

func _show_calling_menu() -> void:
	self.hide()
	if _calling_scene != null:
		_calling_scene.show_from(self)

# grab focus on the desired button when scene is set visible
func _default_focus() -> void:
	var msg = "_default_focus method not implemented in {}".format(self.name) # formating should work properly in godot 3.5
	assert(false, msg)

func _on_visibility_changed() -> void:
	if visible:
		_default_focus()
