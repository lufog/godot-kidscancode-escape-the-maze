class_name Character
extends Area2D


@export var speed := 3

var tile_size := 64
var can_move := true
var facing := "right"
var moves := {"left": Vector2(-1, 0),
	"right": Vector2(1, 0),
	"up": Vector2(0, -1),
	"down": Vector2(0, 1)}

@onready var ray_casts := {"left": $RayCastLeft,
	"right": $RayCastRight,
	"up": $RayCastUp,
	"down": $RayCastDown}
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func move(dir: String) -> bool:
	animation_player.playback_speed = speed
	facing = dir
	if ray_casts[facing].is_colliding():
		return false
	can_move = false
	animation_player.play(facing)
	var move_tween := create_tween()
	move_tween.tween_property(self, "position", position + moves[facing] * tile_size, 1.0 / speed) \
			.set_trans(Tween.TRANS_SINE) \
			.set_ease(Tween.EASE_IN_OUT)
	await move_tween.finished
	can_move = true
	return true

