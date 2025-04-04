extends CharacterBody2D

var can_laser: bool = true
var can_granade: bool = true
var can_be_hitted: bool = true
var sparks: GPUParticles2D

@export
var max_speed: int = 500
var speed: int = max_speed
#signals
signal player_shoot(pos: Vector2, dir: Vector2)
signal player_throw_granade(pos: Vector2, dir: Vector2)
	
func player_primary_action(dir: Vector2):
	#shooting
	if(Input.is_action_pressed("primary_action")) and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		#random select a marker for start of the laser
		var laser_marker: Marker2D = $LaserStartPosition.get_children().pick_random();
		can_laser = false
		$Timers/LaserTimer.start()
		player_shoot.emit(laser_marker.global_position, dir)
		sparks.emitting = true
		
		

func player_secondary_action(dir: Vector2):
	#throw granade
	if(Input.is_action_just_pressed("secondary_action")) and can_granade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		can_granade = false
		$Timers/GranadeTimer.start()
		var granade_marker_position = $GranadeStartPosition/GranadeMarker.global_position
		player_throw_granade.emit(granade_marker_position, dir)
		
func _ready() -> void:
	sparks = $ShootingSparks
		
func _process(_delta: float) -> void:
	var player_direction = (get_global_mouse_position() - position).normalized()
	#input
	player_movements()
	player_rotation()
	player_primary_action(player_direction)
	player_secondary_action(player_direction)

func player_movements():
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity =  direction * speed
	move_and_slide()
	Globals.player_position = global_position
	
func player_rotation():
	look_at(get_global_mouse_position())

func _on_laser_timer_timeout() -> void:
	can_laser = true


func _on_granade_timer_timeout() -> void:
	can_granade = true
	
func hit(damage: int = 0):
	if can_be_hitted:
		can_be_hitted = false
		$Timers/HitTimer.start()
		Globals.health -= damage


func _on_hit_timer_timeout() -> void:
	can_be_hitted = true
