extends CharacterBody2D

@export var velocitat: float = 350.0

var _game_manager: Node = null

func _ready() -> void:
	var vp: Vector2 = get_viewport_rect().size
	position = Vector2(vp.x / 2.0, vp.y - 60.0)
	_game_manager = get_parent()
	add_to_group("jugador")
	collision_layer = 1
	collision_mask  = 2

func _physics_process(_delta: float) -> void:
	if _game_manager and _game_manager.estat_joc != "jugant":
		velocity = Vector2.ZERO
		return
	moure()
	move_and_slide()
	_limitar_pantalla()

func moure() -> void:
	var dir: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * velocitat
	velocity.y = 0.0

func _limitar_pantalla() -> void:
	var vp: Vector2 = get_viewport_rect().size
	# Usem la mida del Sprite per limitar correctament
	var sprite: Sprite2D = $Sprite2D
	var meitat: float = 40.0
	if sprite and sprite.texture:
		var tex_w: float = sprite.texture.get_width() * abs(sprite.scale.x)
		meitat = tex_w / 2.0
	position.x = clamp(position.x, meitat, vp.x - meitat)

func rebre_impacte() -> void:
	if _game_manager:
		_game_manager.game_over()
