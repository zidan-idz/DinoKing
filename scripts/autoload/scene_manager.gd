extends Node
## Singleton untuk navigasi antar scene

# Daftar path scene
const SCENES := {
	"home": "res://scenes/ui/home.tscn",
	"menu_area": "res://scenes/ui/screens/menu_area.tscn",
	"world": "res://scenes/game/world.tscn",
	"shop": "res://scenes/ui/screens/shop.tscn",
	"settings": "res://scenes/ui/screens/settings.tscn",
	"profile": "res://scenes/ui/screens/profile.tscn",
}


func goto(scene_name: String) -> void:
	## Navigasi ke scene berdasarkan nama
	if SCENES.has(scene_name):
		get_tree().change_scene_to_file(SCENES[scene_name])
	else:
		push_warning("Scene tidak ditemukan: " + scene_name)


func goto_path(path: String) -> void:
	## Navigasi langsung ke path scene
	get_tree().change_scene_to_file(path)


func show_popup(popup_scene: PackedScene) -> void:
	## Tampilkan popup di atas scene saat ini
	var popup = popup_scene.instantiate()
	get_tree().root.add_child(popup)


func reload_current() -> void:
	## Reload scene saat ini
	get_tree().reload_current_scene()
