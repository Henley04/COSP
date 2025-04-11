extends Node
var current_hero:String = 'cym'
var current_health:int = 5
var minimum_health:int = 0
var enemy_a_health:int
var enemy_b_health:int
func get_hero():
	if current_hero == null:
		current_hero = 'cym'
	return current_hero
func _ready() -> void:
	if current_hero == null:
		current_hero = 'cym'
func health_minus(minus_number:int):
	current_health=-minus_number
	print_debug('health-',minus_number)
func health_min(minimum_hp:int):
	minimum_health = minimum_hp
## Set health to health_new
func set_health(health_new:int):
	current_health = health_new
	print_debug('health set ', current_health)
	
func kill(target:String, number:int):
	if target=='self':
		current_health=-number
	if target=='enemy_a':
		pass
	
