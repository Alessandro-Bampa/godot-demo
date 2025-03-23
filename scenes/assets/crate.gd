extends BaseItem

func hit():
	if not opened:
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPosition.get_children().pick_random().global_position
			open.emit(pos, current_direction)
		opened = true
	
