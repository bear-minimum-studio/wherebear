tool
extends RigidBody2D

onready var _collisionShape := $CollisionShape
onready var _wallSprite := $WallSprite

func _on_Wall_item_rect_changed():
	var transform = self.get_transform()
	self.set_transform(Transform.IDENTITY)
	_collisionShape.set_transform(transform)
	_wallSprite.set_transform(transform)
	
