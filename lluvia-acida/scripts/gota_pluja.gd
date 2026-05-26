extends Area2D

var velocitat_caiguda: float = 250.0

func _ready() -> void:
	add_to_group("gotes")
	collision_layer = 2
	collision_mask  = 1
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position.y += velocitat_caiguda * delta
	if position.y > get_viewport_rect().size.y + 80.0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("jugador"):
		body.rebre_impacte()
		queue_free()
