class_name Enemy
extends Character


func _ready() -> void:
	can_move = false
	facing = moves.keys()[randi() % 4]
	await get_tree().create_timer(0.5).timeout
	can_move = true


func _process(_delta: float) -> void:
	if can_move:
		if not await move(facing) or randi() % 10 > 5:
			facing = moves.keys()[randi() % 4]
