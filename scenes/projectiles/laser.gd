extends Area2D

@export
var speed: int = 1000
var direction: Vector2 = Vector2.UP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta
	
func _ready() -> void:
	$DestroyAfterShoot.start()

func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit(10)
	queue_free()

func _on_destroy_after_shoot_timeout():
	queue_free()
