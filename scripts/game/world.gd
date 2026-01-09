extends Node2D
## Script utama game world

# Daftar scene rintangan
var obstacle_scenes: Array[PackedScene] = [
	preload("res://scenes/game/cactus_small.tscn"),
	preload("res://scenes/game/cactus_tall.tscn"),
	preload("res://scenes/game/cactus_wide.tscn"),
]

# Daftar scene awan
var cloud_scenes: Array[PackedScene] = [
	preload("res://scenes/game/cloud.tscn"),
	preload("res://scenes/game/cloud2.tscn"),
	preload("res://scenes/game/cloud3.tscn"),
]

# State game
var game_speed := 0.0
var score := 0.0
var game_running := false


func _ready() -> void:
	_setup_initial_state()
	_connect_signals()


func _setup_initial_state() -> void:
	## Setup state awal game
	game_running = false
	game_speed = 0.0
	
	$Timer.stop()
	$CloudTimer.stop()
	
	$HUD/StartButton.visible = true
	$HUD/GameOverLabel.visible = false
	$HUD/RestartButton.visible = false
	$HUD/HomeButton.visible = false


func _connect_signals() -> void:
	## Hubungkan sinyal (dengan pengecekan agar tidak dobel)
	if not $Timer.timeout.is_connected(_on_timer_timeout):
		$Timer.timeout.connect(_on_timer_timeout)
	
	if not $CloudTimer.timeout.is_connected(_on_cloud_timer_timeout):
		$CloudTimer.timeout.connect(_on_cloud_timer_timeout)
	
	if not $HUD/RestartButton.pressed.is_connected(_on_restart_button_pressed):
		$HUD/RestartButton.pressed.connect(_on_restart_button_pressed)
	
	if not $HUD/StartButton.pressed.is_connected(_on_start_button_pressed):
		$HUD/StartButton.pressed.connect(_on_start_button_pressed)


func _process(delta: float) -> void:
	if not game_running:
		return
	
	# Update score
	score += delta * 10
	$HUD/ScoreLabel.text = "SCORE: " + str(floor(score))
	
	# Tingkatkan kecepatan berdasarkan score
	game_speed = GameConfig.INITIAL_SPEED + (score * GameConfig.SPEED_MODIFIER)


func start_game() -> void:
	## Mulai game
	game_running = true
	game_speed = GameConfig.INITIAL_SPEED
	
	$Timer.start()
	$CloudTimer.start()
	$HUD/StartButton.visible = false


func game_over() -> void:
	## Akhiri game
	game_running = false
	get_tree().paused = true
	
	# Simpan data
	SaveManager.update_high_score(score)
	
	# Konversi Score ke Koin (10 Score = 1 Koin)
	var coins_earned = floor(score / 10)
	SaveManager.add_coins(coins_earned)
	
	# Tambah XP (Total Score)
	SaveManager.add_xp(int(score))
	
	$HUD/RestartButton.visible = true
	$HUD/HomeButton.visible = true
	$HUD/GameOverLabel.visible = true
	$HUD/StartButton.visible = false


func _spawn_obstacle() -> void:
	## Spawn rintangan acak
	var scene = obstacle_scenes.pick_random()
	var obstacle = scene.instantiate()
	obstacle.position = Vector2(GameConfig.SPAWN_X, GameConfig.GROUND_Y)
	add_child(obstacle)


func _spawn_cloud() -> void:
	## Spawn awan acak
	var scene = cloud_scenes.pick_random()
	var cloud = scene.instantiate()
	var random_y = randf_range(GameConfig.CLOUD_Y_MIN, GameConfig.CLOUD_Y_MAX)
	cloud.position = Vector2(GameConfig.SPAWN_X, random_y)
	add_child(cloud)
	
	# Timer variatif untuk awan berikutnya
	$CloudTimer.wait_time = randf_range(2.0, 4.0)


# === SIGNAL HANDLERS ===

func _on_start_button_pressed() -> void:
	start_game()


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.reload_current()


func _on_home_button_pressed() -> void:
	get_tree().paused = false
	SceneManager.goto("home")


func _on_timer_timeout() -> void:
	_spawn_obstacle()


func _on_cloud_timer_timeout() -> void:
	_spawn_cloud()


func _on_jump_button_pressed() -> void:
	if game_running:
		var dino = $Ground/Dino
		if dino:
			dino.do_jump()


func _on_skill_button_pressed() -> void:
	# TODO: Implementasi skill khusus (saat ini nonaktif)
	pass
