extends LevelParent

#from gate default signal
func _on_gate_player_entered_gate(_body) -> void:
	var tween = create_tween()
	tween.tween_property($Player as CharacterBody2D, "speed", 0, 0.5)
	LevelTransition.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # esegui le animazioni in parallelo e non una dopo l'altra
	tween.tween_property($Player/Camera2D as Camera2D, "zoom", Vector2(1,1), 1)
	


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D as Camera2D, "zoom", Vector2(0.6,0.6), 1)
	
