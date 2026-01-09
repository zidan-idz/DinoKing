extends Node2D
## Script untuk awan dengan efek parallax

func _process(delta: float) -> void:
	# Ambil referensi world
	var world = get_parent()
	if not world or not "game_speed" in world:
		return
	
	# Awan bergerak lebih lambat (efek parallax)
	var speed = world.game_speed * GameConfig.CLOUD_SPEED_MULTIPLIER
	position.x -= speed * delta
	
	# Hapus jika sudah keluar layar
	if position.x < GameConfig.DESTROY_X:
		queue_free()
