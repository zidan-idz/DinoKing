extends "res://scripts/ui/base_screen.gd"
## Script untuk halaman Menu Area (pilih area bermain)

# Preload popup
@onready var POPUP_ATTENTION := preload("res://scenes/ui/popups/popup_attention.tscn")


func _on_btn_back_pressed() -> void:
	SceneManager.goto("home")


func _on_btn_rainy_pressed() -> void:
	SceneManager.show_popup(POPUP_ATTENTION)


func _on_btn_winter_pressed() -> void:
	SceneManager.show_popup(POPUP_ATTENTION)


func _on_btn_summer_pressed() -> void:
	SceneManager.goto("world")
