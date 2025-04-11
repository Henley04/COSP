extends Node2D
## Control the animation speed. AnimationBg.self_modulate=AnBgModulate=AnBgModulate-delta*AnimationSpeed.
@export var AnimationSpeed:float = 0.7
## The original modulate of AnBg. Default is 1.
@export var AnBgModulate:float = 1
## Called when animation finished.
signal AnimaBgEnd # When animationBg's modulate is 0.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/RealBg/AnimationBg.self_modulate.a = 1
	$AnimationPlayer.play('TextEffect')
	$MessagePopup.show_message('[Version:ALPHA-0.0.1]')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	AnBgModulate -= delta*AnimationSpeed
	$CanvasLayer/RealBg/AnimationBg.self_modulate.a = AnBgModulate
	if AnBgModulate <= 0:
		AnimaBgEnd.emit()
		title_char_appear()
		set_process(false)
func title_char_appear():
	print_debug('TitleBgAnimation finished.')
	


func _on_button_pressed() -> void:
	print_debug('GameStart pressed.')
	var GSAudio = AudioStreamPlayer.new()
	add_child(GSAudio)
	var GSFile = load("res://Audio/Sound/Attention.wav")
	GSAudio.stream = GSFile
	GSAudio.play()
	$AudioStreamPlayer.volume_db =- 20
	$AnimationPlayer.play('Exit')


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'Exit':
		#Change to main.
		get_tree().change_scene_to_file("res://Ui/Scenes/Main/Main.tscn")
