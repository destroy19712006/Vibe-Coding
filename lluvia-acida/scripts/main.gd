extends Node2D

# Aquí arrastraremos la escena de la gota luego
@export var gota_escena: PackedScene = preload("res://scenes/gota_pluja.tscn")

func _on_timer_timeout():
	# Creamos una nueva gota
	var nueva_gota = gota_escena.instantiate()
	
	# La ponemos en una posición X aleatoria arriba
	var ancho_pantalla = get_viewport_rect().size.x
	nueva_gota.position = Vector2(randf_range(0, ancho_pantalla), -50)
	
	# La añadimos al juego
	get_parent().add_child(nueva_gota)
