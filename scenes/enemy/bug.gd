extends CharacterBody2D


var is_player_nearby: bool = false
var is_player_in_attack_range: bool = false
var is_attacking: bool = false
var can_attack: bool = true
var can_be_hitted: bool = true
var speed = 300
var damage = 10
var health = 30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_player_in_attack_range and can_attack and not is_attacking:
		_attack_target()
	if is_player_nearby and not is_player_in_attack_range and not is_attacking:
		_walk_to_target()
	if not is_player_nearby:
		$AnimatedSprite2D.pause()


func _on_notice_area_body_entered(_body: Node2D) -> void:
	is_player_nearby = true


func _on_notice_area_body_exited(_body: Node2D) -> void:
	is_player_nearby = false


func _on_attack_area_body_entered(_body: Node2D) -> void:
	is_player_in_attack_range = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	is_player_in_attack_range = false

func _walk_to_target():
	look_at(Globals.player_position)
	$AnimatedSprite2D.play("Walk")
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * speed
	move_and_slide()
	
func _attack_target():
	is_attacking = true
	$AnimatedSprite2D.play("Attack")


func _on_animated_sprite_2d_animation_finished() -> void:
	is_attacking = false
	if is_player_in_attack_range:
		Globals.health -= damage
	$Timers/AttackTimer.start()
	can_attack = false

func hit(hitDamage: int = 0):
	if can_be_hitted:
		can_be_hitted = false
		$AudioStreamPlayer2D.play()
		$Timers/HitTimer.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
		health -= hitDamage
		if health <= 0:
			await get_tree().create_timer(0.5).timeout
			queue_free()


func _on_hit_timer_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	can_be_hitted = true


func _on_attack_timer_timeout() -> void:
	can_attack = true
