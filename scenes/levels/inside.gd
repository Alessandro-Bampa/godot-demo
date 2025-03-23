extends LevelParent


func _on_exit_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player as CharacterBody2D, "speed", 0, 0.5)
