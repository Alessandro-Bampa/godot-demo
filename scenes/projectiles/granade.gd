extends RigidBody2D

const speed = 200
const damage_value = 10
var explosion_active: bool = false
@onready var expl_range = global_position.distance_to($Marker2D.global_position) 
func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	
func _process(_delta: float) -> void:
	if explosion_active:
		for target in get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container"):
			if (target.global_position.distance_to(global_position) < expl_range) and ("hit" in target):
				target.hit(damage_value)
