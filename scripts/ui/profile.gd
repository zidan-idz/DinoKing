extends "res://scripts/ui/base_screen.gd"

func _update_global_ui() -> void:
	super._update_global_ui()
	
	# Logic manual untuk mencari label Score History karena struktur nodenya generik
	# Kita cari semua Label, dan label score biasanya ada di urutan terakhir (berdasarkan struktur tscn)
	var labels = find_children("*", "Label", true, false)
	if labels.size() > 0:
		# Label Score History value adalah label terakhir "0"
		var score_val_label = labels[labels.size() - 1]
		if score_val_label:
			score_val_label.text = str(SaveManager.get_total_xp())
			
	# Update Coin (jika tidak ditemukan oleh BaseScreen)
	# Biasanya coin label juga label angka, tapi di profile mungkin tidak ada coin container yang jelas?
	# Di Profile Tscn ada Coin Container di Header. BaseScreen harusnya nemu.
