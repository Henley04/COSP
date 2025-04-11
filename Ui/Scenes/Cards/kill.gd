extends TextureRect
@export var CardType:String = 'Kill'
## Called when player press the card.
signal card_active(CardType)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when player press the card.
func _on_active_button_pressed() -> void:
	card_active.emit()
