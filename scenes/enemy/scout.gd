extends CharacterBody2D

var player_nearby: bool = false

func _process(_delta: float) -> void:
	look_at(Globals.player_position)


func _on_attack_area_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
