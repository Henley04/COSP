extends Control

# Signal define part
signal game_lose

# Var def
var button_scene = preload("res://Ui/Scenes/Cards/kill.tscn")
@onready var sub_skill = $Player/SubSkillView
func _ready() -> void:
	# Debug, need delete.
	# _on_kill_pressed(1, 1) # Temporarily commented out

	# IMPORTANT: Ensure randomize() is called ONCE somewhere in your game's startup code!
	# randomize()

	for i in range(4):
		var Type = randi() % 4  # 随机生成 0-3 的整数
		# Instance is the root TextureRect from kill.tscn
		var card_instance = button_scene.instantiate()

		# --- Find Child Nodes ---
		# !!! IMPORTANT: Replace "Label" with the actual name of the Label node in kill.tscn !!!
		var label_node = card_instance.get_node("Describe")
		# !!! IMPORTANT: Replace "Button" with the actual name of the Button node in kill.tscn !!!
		var button_node = card_instance.get_node("ActiveButton")

		# --- Error Checking ---
		if label_node == null:
			printerr("Could not find Label node named 'Label' in kill.tscn instance!")
			continue # Skip this instance
		if button_node == null:
			printerr("Could not find Button node named 'Button' in kill.tscn instance!")
			continue # Skip this instance

		# --- Configure Card ---
		# Set the text on the child Label node
		match Type:
			0:
				label_node.text = "来"
				card_instance.texture = preload("res://Ui/Scenes/Cards/Textures/kill.jpg")
			1:
				label_node.text = "拖"
				card_instance.texture = preload("res://Ui/Scenes/Cards/Textures/kill.jpg")
			2:
				label_node.text = "假"
				card_instance.texture = preload("res://Ui/Scenes/Cards/Textures/kill.jpg")
			3:
				label_node.text = "烟"
				card_instance.texture = preload("res://Ui/Scenes/Cards/Textures/kill.jpg")

		# Add the whole card (TextureRect root) to the container
		$HBoxContainer.add_child(card_instance)

		# --- Connect the Signal ---
		# Connect the 'pressed' signal from the CHILD BUTTON NODE
		button_node.pressed.connect(on_card_pressed.bind(Type))
	# -----SubSkill-----
	sub_skill.visible=false
	$Player/PlayerAnimation.play("skill")
	print_debug('Ready!')
	# -----


# 处理信号的方法 (Handler for the signal)
# ... (previous code remains the same)

func on_card_pressed(type):
	print("Card Type ", type, " was pressed!")
	# Determine target based on type or game logic
	var target = "enemy_a"  # Example target, adjust as needed
	var number = 1
	_on_kill_pressed(target, number)  # Call the kill method with parameters

# ... (rest of the code remains the same)


# Target should be changed to real enemy.
# Target is enemy_a/enemy_b
func _on_kill_pressed(target, number):
	number = 1
	target = "#The enemy target" # Placeholder
	# Ensure GlobalVar and kill method exist
	if GlobalVar != null and GlobalVar.has_method("kill"):
		GlobalVar.kill(target, number)
		print_debug("Killed!")
	else:
		printerr("GlobalVar or GlobalVar.kill method not found!")


func _process(delta: float) -> void:
	# Check for game lose condition (simplified check)
	if GlobalVar.current_health <= 0:
		game_lose.emit()
	# else:
		# Optional: print warning if GlobalVar or health is inaccessible
