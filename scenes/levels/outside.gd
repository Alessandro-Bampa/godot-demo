extends LevelParent

#from gate default signal
func _on_gate_player_entered_gate(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player as CharacterBody2D, "speed", 0, 0.5)
