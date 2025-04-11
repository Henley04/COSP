# 文件名: bomb.gd
extends Sprite2D

signal bomb_boom

# ----- 可配置参数 -----
@export var horizontal_speed: float = 600.0       # 水平移动速度 (像素/秒)
@export var gravity: float = 1200.0               # 向下的加速度 (像素/秒^2)
@export var pause_duration: float = 0.6           # 在屏幕中心的停留时间 (秒)
@export var rotation_speed: float = 360.0         # 自转速度 (度/秒)  <-- 新增的自转参数
# ----------------------

# 内部状态变量
var velocity: Vector2 = Vector2.ZERO
var screen_size: Vector2 = Vector2.ZERO
var target_pos: Vector2 = Vector2.ZERO
var has_reached_center: bool = false
var is_paused: bool = false
var calculated_initial_vy: float = 0.0

var pause_timer: Timer

func _ready():
	$DirectionalLight2D.visible=false
	screen_size = get_viewport_rect().size
	target_pos = screen_size / 2.0
	global_position = Vector2(0, target_pos.y)

	if horizontal_speed != 0:
		var time_to_center = target_pos.x / horizontal_speed
		calculated_initial_vy = -0.5 * gravity * time_to_center
	else:
		push_error("Horizontal speed cannot be zero!")
		calculated_initial_vy = 0 

	velocity = Vector2(horizontal_speed, calculated_initial_vy)

	pause_timer = Timer.new()
	pause_timer.wait_time = pause_duration
	pause_timer.one_shot = true
	pause_timer.timeout.connect(_on_pause_timer_timeout)
	add_child(pause_timer)

func _process(delta: float):
	# 新增的自转逻辑（无论是否暂停都会旋转）
	rotation += deg_to_rad(rotation_speed) * delta  # 将角度转换为弧度后累加
	
	if is_paused:
		return

	velocity.y += gravity * delta
	position += velocity * delta

	if not has_reached_center and global_position.x >= target_pos.x:
		global_position = target_pos
		_handle_reached_center()

	if has_reached_center and global_position.x > screen_size.x:
		queue_free()

func _handle_reached_center():
	has_reached_center = true
	is_paused = true
	emit_signal("bomb_boom")
	pause_timer.start()

func _on_pause_timer_timeout():
	is_paused = false
	velocity.y = calculated_initial_vy

func _on_bomb_boom() -> void:
	bomb_light_effect()

func bomb_light_effect():
	$DirectionalLight2D.visible=true
	await 0.06
	$DirectionalLight2D.visible=false
