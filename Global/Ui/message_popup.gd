extends CanvasLayer

@onready var background: ColorRect = $Background
@onready var message_text: Label = $Background/MessageText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal popup_closed

var default_fade_in_duration = 0.2
var default_fade_out_duration = 0.2
var default_display_duration = 2.0 # 消息显示时长（秒）
var default_text_color = Color(1, 1, 1) # 默认白色
var default_blink_color = Color(1, 1, 1, 0.5) # 默认半透明白色
var default_blink_duration = 0.1 # 默认闪烁持续时间

var min_box_size = Vector2(100, 50) # 最小框体尺寸
var padding = 20 # 文本与边框的内边距

func _ready():
	# 初始时隐藏节点
	visible = false
	show_message('Test')

## 显示消息提示框。
##
## 参数：
##   text: String - 要显示的消息文本。
##   fade_in_duration: float (可选) - 淡入动画的持续时间（秒）。如果为负值或不提供，则使用默认值。
##   fade_out_duration: float (可选) - 淡出动画的持续时间（秒）。如果为负值或不提供，则使用默认值。
##   text_color: Color (可选) - 消息文本的颜色。如果不提供（默认值为 Color(0,0,0,0)），则使用默认值。
func show_message(text: String,
				  fade_in_duration: float = -1,
				  fade_out_duration: float = 1,
				  text_color: Color = Color(0,0,0,0)):
	message_text.text = text

	# 使用提供的参数或默认值
	var actual_fade_in_duration = default_fade_in_duration
	if fade_in_duration > 0:
		actual_fade_in_duration = fade_in_duration

	var actual_fade_out_duration = default_fade_out_duration
	if fade_out_duration > 0:
		actual_fade_out_duration = fade_out_duration

	var actual_text_color = default_text_color
	if text_color != Color(0,0,0,0):
		actual_text_color = text_color

	message_text.add_theme_color_override("font_color", actual_text_color)

	# 根据文本内容调整背景框大小
	var text_size = message_text.get_minimum_size()
	var target_size = text_size + Vector2(padding * 2, padding * 2)
	target_size = target_size.max(min_box_size) # 确保不小于最小尺寸
	background.size = target_size

	# 设置 Background 的中心作为缩放的轴心点
	background.pivot_offset = background.size / 2

	# 居中文本
	message_text.position = (background.size - text_size) / 2

	visible = true

	# 播放显示动画，包括文字闪烁
	animation_player.play("show", -1, 1, false)

	# 在显示一段时间后自动隐藏
	await get_tree().create_timer(default_display_duration).timeout
	hide_popup(actual_fade_out_duration)

func hide_popup(fade_out_duration: float):
	# 反向播放 "show" 动画实现淡出
	animation_player.play_backwards("show")
	await get_tree().create_timer(fade_out_duration).timeout
	visible = false
	popup_closed.emit() # 发出关闭信号，如果需要的话

# 你可以在这里添加一个直接隐藏的方法，如果不需要淡出动画
func hide_immediately():
	visible = false
	popup_closed.emit()
#---Global Notice Area---
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("controller"):
		show_message('Controller not supported.')
