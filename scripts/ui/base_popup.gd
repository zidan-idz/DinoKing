extends CanvasLayer
class_name BasePopup
## Base class untuk semua popup

func _ready() -> void:
	layer = 10


func close() -> void:
	## Tutup popup ini
	queue_free()


func _on_close_button_pressed() -> void:
	close()


func _on_bu_tombol_closetton_pressed() -> void:
	## Handler untuk tombol close (nama dari scene asli)
	close()
