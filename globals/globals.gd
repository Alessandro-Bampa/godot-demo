extends Node

signal stats_change

var laser_amount: int = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stats_change.emit()
var grenade_amount: int = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stats_change.emit()
var health = 60:
	get:
		return health
	set(value):
		if value > 100:
			value = 100
		health = value
		stats_change.emit()
		
var player_position: Vector2
