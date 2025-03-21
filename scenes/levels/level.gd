extends Node2D
class_name LevelParent
var player: Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")



#from player custom signlas
func _on_player_player_shoot(pos: Vector2, direction: Vector2) -> void:
	var laser: Node2D = laser_scene.instantiate()
	laser.position = pos
	laser.direction = direction
	laser.rotation = direction.angle()
	$Projectiles.add_child(laser)
	
func _on_player_player_throw_granade(pos: Vector2, direction: Vector2) -> void:
	#istanza oggetto granata
	var grenade_instance: RigidBody2D = granade_scene.instantiate()
	grenade_instance.position = pos
	grenade_instance.linear_velocity = direction * grenade_instance.speed
	$Projectiles.add_child(grenade_instance)
	


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true) # esegui le animazioni in parallelo e non una dopo l'altra
	tween.tween_property($Player/Camera2D as Camera2D, "zoom", Vector2(1,1), 1)
	


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D as Camera2D, "zoom", Vector2(0.6,0.6), 1)
