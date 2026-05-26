extends Node2D

@export var frequencia_spawn: float = 0.8
@export var rang_velocitat: Vector2 = Vector2(180, 320)

var gota_escena: PackedScene = preload("res://scenes/gota_pluja.tscn")
var _dificultat_actual: float = 1.0

@onready var timer: Timer = $Timer

func iniciar(dificultat: float) -> void:
	_dificultat_actual = dificultat
	actualitzar_dificultat(dificultat)
	timer.start()

func aturar() -> void:
	timer.stop()

func actualitzar_dificultat(dificultat: float) -> void:
	_dificultat_actual = dificultat
	var nova_freq: float = clamp(frequencia_spawn / dificultat, 0.15, 1.5)
	if abs(timer.wait_time - nova_freq) > 0.05:
		timer.wait_time = nova_freq

func _on_timer_timeout() -> void:
	generar_gota()

func generar_gota() -> void:
	var gota = gota_escena.instantiate()
	var vp_w: float = get_viewport_rect().size.x
	gota.position = Vector2(randf_range(40.0, vp_w - 40.0), -60.0)
	var vel_max: float = clamp(
		rang_velocitat.y * (_dificultat_actual * 0.4 + 0.6),
		rang_velocitat.x,
		rang_velocitat.y * 2.0
	)
	gota.set("velocitat_caiguda", randf_range(rang_velocitat.x, vel_max))
	get_parent().add_child(gota)
