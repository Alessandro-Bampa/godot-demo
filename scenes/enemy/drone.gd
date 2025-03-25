extends CharacterBody2D

var base_speed = 200
var active: bool = false
var vulnerable: bool = true
var health: int = 15
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Explosion.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if active:
		movement()

func movement():
	look_at(Globals.player_position)
	var direction = (Globals.player_position - position).normalized()
	velocity = direction * base_speed
	move_and_slide()
	
func hit(damage: int):
	if vulnerable:
		health -= damage
		vulnerable = false
		$HitTimer.start()
	if health <= 0:
		$AnimationPlayer.play("Explosion")

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true


func _on_hit_timer_timeout() -> void:
	vulnerable = true
