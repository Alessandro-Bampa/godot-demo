extends StaticBody2D
class_name BaseItem

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
signal open(position, direction)
