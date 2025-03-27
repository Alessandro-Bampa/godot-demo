extends PathFollow2D

var player_near: bool = false
@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D

func fire():
	Globals.health -= 20

func _ready() -> void:
	print("ready")
	
func _process(delta: float) -> void:
	progress_ratio += 0.03 * delta
	if player_near:
		$Turret.look_at(Globals.player_position)

func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimationPlayer.play("load_laser")

func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimationPlayer.stop()
