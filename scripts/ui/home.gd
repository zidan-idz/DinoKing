extends Control
## Script untuk halaman Home

# Preload popup scenes
@onready var POPUP_ABOUT := preload("res://scenes/ui/popups/popup_about.tscn")
@onready var POPUP_LEADERBOARD := preload("res://scenes/ui/popups/popup_leaderboard.tscn")
@onready var POPUP_ATTENTION := preload("res://scenes/ui/popups/popup_attention.tscn")


@onready var coin_label: Label = $MarginTemplates/MainContainer/HeaderContainer/LeftHeader/MarginContainer/HBoxContainer/CoinContainer/HBoxContainer2/Label
@onready var xp_label: Label = $MarginTemplates/MainContainer/HeaderContainer/LeftHeader/MarginContainer/HBoxContainer/XPContainer/HBoxContainer2/Label


func _ready() -> void:
	# Tampilkan koin & xp saat masuk halaman Home
	if coin_label:
		coin_label.text = str(SaveManager.get_total_coins())
	if xp_label:
		xp_label.text = str(SaveManager.get_total_xp())


# === BUTTON HANDLERS ===
 
func _on_texture_rect_pressed() -> void:
	SceneManager.show_popup(POPUP_ABOUT)


func _on_btn_leaderboard_pressed() -> void:
	SceneManager.show_popup(POPUP_LEADERBOARD)


func _on_btn_swap_dino_pressed() -> void:
	SceneManager.show_popup(POPUP_ATTENTION)


func _on_btn_play_game_pressed() -> void:
	SceneManager.goto("menu_area")


func _on_btn_shop_pressed() -> void:
	SceneManager.goto("shop")


func _on_btn_settings_pressed() -> void:
	SceneManager.goto("settings")


func _on_btn_accounts_pressed() -> void:
	SceneManager.goto("profile")
