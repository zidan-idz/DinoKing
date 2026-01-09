extends Area2D
class_name Obstacle
## Base class untuk semua rintangan (kaktus)

func _process(delta: float) -> void:
	# Ambil referensi world
	var world = get_parent()
	if not world or not world.has_method("game_over"):
		return
	
	# Gerakkan ke kiri sesuai kecepatan game
	position.x -= world.game_speed * delta
	
	# Hapus jika sudah keluar layar
	if position.x < GameConfig.DESTROY_X:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	## Dipanggil saat ada body masuk area collision
	if body.name == "Dino":
		var world = get_parent()
		if world and world.has_method("game_over"):
			world.game_over()
