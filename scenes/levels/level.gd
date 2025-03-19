extends Node2D
var player: Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")

#from gate default signal
func _on_gate_player_entered_gate(body) -> void:
	print(body)
	print("player entered on gate at level")

#from player custom signlas
func _on_player_player_shoot(pos: Vector2, direction: Vector2) -> void:
	print("before instantiate")
	var laser: Node2D = laser_scene.instantiate()
	print("after instantiate")
	laser.position = pos
	laser.direction = direction
	laser.rotation = direction.angle()
	print("before add to child")
	$Projectiles.add_child(laser)
	print("after add to child")
	
func _on_player_player_throw_granade(pos: Vector2, direction: Vector2) -> void:
	#istanza oggetto granata
	var grenade_instance: RigidBody2D = granade_scene.instantiate()
	grenade_instance.position = pos
	grenade_instance.linear_velocity = direction * grenade_instance.speed
	$Projectiles.add_child(grenade_instance)
	
