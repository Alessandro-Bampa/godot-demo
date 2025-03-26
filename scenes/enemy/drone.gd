extends CharacterBody2D

var base_speed = 200
var active: bool = false
var vulnerable: bool = true
var health: int = 15
var entities_in_explosion_range: Array[Node] = []
var explosion_damage: int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Explosion.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		movement(delta)
		

func movement(delta):
	look_at(Globals.player_position)
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * base_speed
	var collision: KinematicCollision2D = move_and_collide(velocity * delta) #quando l'oggetto ha una collisione non scivola, ma si ferma
	if collision:
		active = false
		$AnimationPlayer.play("Explosion")
		
		
func hit(damage: int):
	if vulnerable:
		health -= damage
		vulnerable = false
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$HitTimer.start()
	if health <= 0:
		active = false
		$AnimationPlayer.play("Explosion")
		

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "base_speed", 800, 5.0)
	

func _on_hit_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0)
	vulnerable = true


func _on_damage_area_body_entered(body: Node2D) -> void:
	entities_in_explosion_range.append(body)

func _on_damage_area_body_exited(body: Node2D) -> void:
	entities_in_explosion_range.erase(body)
	
func spread_explosion_damage():
	for entity in entities_in_explosion_range:
		if entity in get_tree().get_nodes_in_group("Entity"):
			if "hit" in entity: entity.hit(explosion_damage)
	
