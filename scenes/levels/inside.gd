extends LevelParent

@export
var outside_level: PackedScene

func _on_exit_body_entered(_body: Node2D) -> void:
	var tween = create_tween()
	tween.tween_property($Player as CharacterBody2D, "speed", 0, 0.5)
	#get_tree().change_scene_to_file("res://scenes/levels/outside.tscn") #carica da file
	#get_tree().change_scene_to_packed(outside_level) #precaricato all'avvio dello script
	LevelTransition.change_scene(outside_level.resource_path)
