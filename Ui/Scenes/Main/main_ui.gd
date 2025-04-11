extends Control
var CurrentAnim
var CurrentButton
func _ready() -> void:
	$MainUiAnimationPlayer.play("Enter")
	print_debug('Ready!')
	var Audio = AudioStreamPlayer.new()
	add_child(Audio)
	var GSFile = load("res://Audio/Music/Sword and Thunder.mp3")
	Audio.stream = GSFile
	Audio.volume_db =- 19
	Audio.play()


func _on_hero_select_pressed() -> void:
	$MainUiAnimationPlayer.play('Exit')
	#get_tree().change_scene_to_file("res://Ui/Scenes/NewCards/random_select.tscn")
	CurrentButton = 'HeroSelect'

func _on_menu_pressed() -> void:
	$MainUiAnimationPlayer.play('Exit')
	get_tree().change_scene_to_file("res://Ui/Scenes/MissionControl/mission_control.tscn")


func _on_main_ui_animation_player_animation_finished(anim_name: StringName) -> void:
	CurrentAnim = anim_name
	if CurrentAnim == "Exit" and CurrentButton == "HeroSelect":
		get_tree().change_scene_to_file("res://Ui/Scenes/NewCards/random_select.tscn")
		
		
