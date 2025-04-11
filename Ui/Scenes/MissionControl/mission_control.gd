extends Control
func _on_play_ai_pressed() -> void:
	get_tree().change_scene_to_file('res://Ui/Scenes/InBattle/Battle.tscn')
	print_debug('Play With Ai Pressed')
