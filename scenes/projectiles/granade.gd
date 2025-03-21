extends RigidBody2D

const speed = 200

func explode():
	$AnimationPlayer.play("Explosion")
