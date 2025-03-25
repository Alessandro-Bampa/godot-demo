extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var last_cannon_used: bool = true
var can_be_hitted: bool = true
var health = 30
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
			$Timers/LaserCooldown.start()


func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_laser_cooldown_timeout() -> void:
	can_laser = true
	
func hit(damage: int = 0):
	if can_be_hitted:
		can_be_hitted = false
		$Timers/HitCooldown.start()
		#var tween = get_tree().create_tween()
		#tween.tween_property($Sprite2D,"material.progress", 1, 0.3)
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= damage
		if health <= 0:
			queue_free()
	


func _on_hit_cooldown_timeout() -> void:
	can_be_hitted = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
