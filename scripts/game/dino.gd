extends CharacterBody2D
## Script untuk karakter Dino

# Bounce effect settings
const BOUNCE_SPEED := 12.0  # Kecepatan bounce
const BOUNCE_HEIGHT := 4.0  # Tinggi bounce (pixel)

# Internal state
var _bounce_time := 0.0
var _sprite: TextureRect
var _default_sprite_y := 0.0


func _ready() -> void:
	# Cache referensi sprite dan posisi awalnya
	_sprite = $TextureRect
	if _sprite:
		_default_sprite_y = _sprite.position.y


func _physics_process(delta: float) -> void:
	# Terapkan gravitasi jika tidak di lantai
	if not is_on_floor():
		velocity.y += GameConfig.GRAVITY * delta
	
	# Cek input lompat (keyboard)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = GameConfig.JUMP_FORCE
	
	# Gerakkan karakter
	move_and_slide()
	
	# Update bounce effect pada sprite
	_update_bounce(delta)


func _update_bounce(delta: float) -> void:
	## Update animasi bounce pada sprite
	if not _sprite:
		return
	
	# Cek apakah game sedang berjalan
	var world = get_parent().get_parent()  # Ground -> World
	var game_running := false
	if world and "game_running" in world:
		game_running = world.game_running
	
	# Bounce hanya saat di lantai DAN game berjalan
	if is_on_floor() and game_running:
		_bounce_time += delta * BOUNCE_SPEED
		# Tambahkan bounce ke posisi DEFAULT (agar tidak menimpa offset asli)
		# Gunakan abs(sin) dan negatifkan agar sprite hanya NAIK dari posisi dasar
		_sprite.position.y = _default_sprite_y + (-abs(sin(_bounce_time)) * BOUNCE_HEIGHT)
	else:
		# Reset ke posisi default saat lompat atau game belum mulai
		_sprite.position.y = _default_sprite_y
		_bounce_time = 0.0


func _input(event: InputEvent) -> void:
	# Handle touch input untuk mobile
	if event is InputEventScreenTouch and event.pressed:
		if is_on_floor():
			velocity.y = GameConfig.JUMP_FORCE


func do_jump() -> void:
	## Dipanggil dari tombol Jump di HUD
	if is_on_floor():
		velocity.y = GameConfig.JUMP_FORCE

