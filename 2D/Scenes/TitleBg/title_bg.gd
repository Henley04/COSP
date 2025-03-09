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
	pass # Replace with function body.


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
	$AnimationPlayer.play('Exit')
