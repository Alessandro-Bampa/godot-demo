extends BaseItem

func hit():
	if not opened:
		$LidSprite.hide()
		var pos = $SpawnPosition.get_child(0).global_position
		open.emit(pos, current_direction)
		opened = true
