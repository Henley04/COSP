extends Node2D
func _ready():
	$MainAnimationPlayer.play('Enter')
	print_debug('SceneReady!')
