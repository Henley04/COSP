extends Node2D

func _ready() -> void:
	$Background/StartUpAnimation.play('Bg')


func _on_start_up_animation_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file('res://2D/Scenes/TitleBg/title_bg.tscn')
