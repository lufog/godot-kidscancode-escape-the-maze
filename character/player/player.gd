class_name Player
extends Character


signal dead
signal win
signal moved
signal grabbed_key


func _process(delta: float) -> void:
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if await move(dir):
					moved.emit()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		dead.emit()
	if area.has_method("pickup"):
		area.pickup()
		if area.type == "key_red":
			grabbed_key.emit()
		if area.type == "star":
			win.emit()
