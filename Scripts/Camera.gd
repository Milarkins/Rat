extends Camera2D

export(NodePath) var player
onready var scr = get_viewport_rect().size.x

func _physics_process(delta):
	var player_pos = get_node(player).global_position
	offset = Vector2(player_pos.x / (scr / 50), 0)
	
	if player_pos.x > scr:
		move()

func move():
	global_position.x += get_viewport_rect().size.x
	scr = global_position.x + get_viewport_rect().size.x
