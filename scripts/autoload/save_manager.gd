extends Node

const SAVE_PATH = "user://savegame.json"

var high_score: int = 0
var total_coins: int = 0
var total_xp: int = 0  # Total akumulasi score (XP)
var version: String = "0.0.1"

func _ready() -> void:
	load_game()

func save_game() -> void:
	var data = {
		"high_score": high_score,
		"total_coins": total_coins,
		"total_xp": total_xp,
		"version": version
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(content)
		if parse_result == OK:
			var data = json.get_data()
			high_score = int(data.get("high_score", 0))
			total_coins = int(data.get("total_coins", 0))
			total_xp = int(data.get("total_xp", 0))
		else:
			printerr("JSON Parse Error: ", json.get_error_message())

func update_high_score(new_score: float) -> void:
	if int(new_score) > high_score:
		high_score = int(new_score)
		save_game()

func add_coins(amount: int) -> void:
	total_coins += amount
	save_game()

func add_xp(amount: int) -> void:
	total_xp += amount
	save_game()

func get_total_coins() -> int:
	return total_coins

func get_high_score() -> int:
	return high_score

func get_total_xp() -> int:
	return total_xp
