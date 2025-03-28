extends BaseItem

func hit(_damage: int = 0):
	if not opened:
		$AudioStreamPlayer2D.play()
		$LidSprite.hide()
		var pos = $SpawnPosition.get_child(0).global_position
		open.emit(pos, current_direction)
		opened = true
