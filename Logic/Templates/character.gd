extends Sprite2D

# Texture variable with initial load based on global hero selection
var new_texture: Texture2D = load('res://2D/CharacterRes/' + GlobalVar.current_hero + '.jpg')

func _ready() -> void:
	# Verify if global variable exists and texture loaded successfully
	#if not GlobalVar.has("current_hero"):
		#push_error("GlobalVar.current_hero is not defined!")
		#return
		
	if new_texture != null:
		texture = new_texture
		print("Sprite texture updated successfully to: ", GlobalVar.current_hero)
	else:
		push_warning("Failed to load texture for: ", GlobalVar.current_hero)
		# Optional: Set a default/fallback texture
		# texture = preload("res://2D/CharacterRes/default.jpg")

# Function to dynamically change sprite texture
func change_sprite_texture(new_texture_path: String) -> bool:
	# Attempt to load new texture
	var loaded_texture: Texture2D = load(new_texture_path)
	
	if loaded_texture != null:
		texture = loaded_texture
		print("Sprite texture dynamically updated to: ", new_texture_path)
		return true
	else:
		push_error("Failed to load texture at path: ", new_texture_path)
		return false

# Optional: Function to update based on current hero
func update_hero_texture() -> void:
	var texture_path = 'res://2D/CharacterRes/' + GlobalVar.current_hero + '.jpg'
	change_sprite_texture(texture_path)
