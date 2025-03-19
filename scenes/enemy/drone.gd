extends CharacterBody2D

var base_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	movement()

func movement():
	var direction = Vector2.RIGHT
	velocity = direction * base_speed
	move_and_slide()
