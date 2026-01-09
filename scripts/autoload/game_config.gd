extends Node
## Konfigurasi global game

# Fisika karakter
const GRAVITY := 1000.0
const JUMP_FORCE := -550.0

# Kecepatan game
const INITIAL_SPEED := 300.0
const SPEED_MODIFIER := 2.0

# Posisi spawn objek
const SPAWN_X := 2500
const GROUND_Y := 600
const CLOUD_Y_MIN := 100
const CLOUD_Y_MAX := 400

# Batas penghapusan objek
const DESTROY_X := -200

# Parallax awan
const CLOUD_SPEED_MULTIPLIER := 0.2
