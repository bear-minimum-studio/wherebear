extends Label

onready var dialog_timer := $DialogTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(true)

func display_text(text: String, duration: float) -> void:
	self.set_text(text)
	self.set_visible(true)
	dialog_timer.start(duration)

func _on_DialogTimer_timeout():
	self.set_visible(false)
