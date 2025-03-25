extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var last_cannon_used: bool = true
var health = 60
signal laser(pos, direction)

func _process(_delta: float) -> void:
	if player_nearby:
		look_at(Globals.player_position)
		if can_laser:
			var pos: Vector2 = $LaserSpawnPositions.get_child(last_cannon_used).global_position
			last_cannon_used = not last_cannon_used
			var direction: Vector2 = (Globals.player_position - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
	
func hit(damage: int = 0):
	print("scout hitted")
	health -= damage
	if health <= 0:
		queue_free()
	
