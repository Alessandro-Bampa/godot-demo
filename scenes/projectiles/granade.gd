extends RigidBody2D

const speed = 200
const damage_value = 10
@onready var explosion_range = global_position.distance_to($Marker2D.global_position)
signal explosion_damage(pos: Vector2, damage: int)
func explode():
	$AnimationPlayer.play("Explosion")
	
func damage():
	explosion_damage.emit(global_position, explosion_range, damage_value)
