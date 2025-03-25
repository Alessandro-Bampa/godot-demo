extends Node2D
class_name LevelParent
var player: Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var granade_scene: PackedScene = preload("res://scenes/projectiles/granade.tscn")
var item_scene: PackedScene = preload("res://scenes/assets/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group("Container"):
		container.connect("open", _on_container_opened)
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect("laser", _on_scout_laser)
			

func _on_container_opened(pos, direction):
	var item: Node2D  = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred("add_child",item)
	
#from player custom signlas
func _on_player_player_shoot(pos: Vector2, direction: Vector2) -> void:
	create_laser(pos, direction)

func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func create_laser(pos: Vector2, direction: Vector2):
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

	
