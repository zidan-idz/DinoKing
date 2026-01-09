extends Control
## Base class untuk layar UI dengan tombol back

func _ready() -> void:
	_update_global_ui()


func _update_global_ui() -> void:
	# Update Coin Label jika ditemukan
	var coin_label = _find_label_in_group(self, ["CoinContainer", "Coin", "Money"])
	if coin_label:
		coin_label.text = str(SaveManager.get_total_coins())
	
	# Update XP/Score Label jika ditemukan
	var xp_label = _find_label_in_group(self, ["XPContainer", "XP", "Score", "Highscore"])
	if xp_label:
		xp_label.text = str(SaveManager.get_total_xp())


func _find_label_in_group(root: Node, keywords: Array) -> Label:
	return _find_recursive_search_with_label_check(root, keywords)


func _find_recursive_search_with_label_check(node: Node, keywords: Array) -> Label:
	# Cek apakah node ini match keyword
	var is_match = false
	for keyword in keywords:
		if keyword in node.name:
			is_match = true
			break
	
	if is_match:
		# Jika match nama, cek apakah ada label valid di dalamnya
		# Kita gunakan helper search label.
		# Perhatikan: jika node ini sendiri adalah Label, _find_label_recursive akan return node ini.
		var label = _find_label_recursive(node)
		if label: 
			# Pastikan labelnya bukan label judul (opsional, tapi text "20" vs "Score")
			# Untuk saat ini kita return label pertama yang ketemu
			return label
	
	# Lanjut cari di children
	for child in node.get_children():
		var res = _find_recursive_search_with_label_check(child, keywords)
		if res: return res
	return null


func _find_label_recursive(node: Node) -> Label:
	if node is Label:
		return node
	for child in node.get_children():
		var res = _find_label_recursive(child)
		if res: return res
	return null


func go_home() -> void:
	## Kembali ke halaman home
	SceneManager.goto("home")


func _on_back_button_pressed() -> void:
	go_home()


func _on_button_pressed() -> void:
	## Fallback untuk tombol back dengan nama generik
	go_home()
