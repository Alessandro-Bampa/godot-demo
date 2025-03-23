extends CanvasLayer

@onready var animation: AnimationPlayer = $Animation

func _ready() -> void:
	$ColorRect.modulate = Color(0,0,0,0)

func change_scene(target: String) -> void:
	animation.play("fade_to_black")
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("fade_to_black")
