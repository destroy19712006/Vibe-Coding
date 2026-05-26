extends Node2D

var estat_joc: String = "jugant"
var temps_supervivencia: float = 0.0
var dificultat: float = 1.0
var puntuacio_actual: float = 0.0
var record: float = 0.0

@onready var spawner: Node2D           = $SpawnerPluja
@onready var label_punts: Label        = $HUD/LabelPunts
@onready var label_record: Label       = $HUD/LabelRecord
@onready var panell_game_over: Control = $HUD/PanellGameOver
@onready var label_final: Label        = $HUD/PanellGameOver/VBox/LabelFinal
@onready var label_record_final: Label = $HUD/PanellGameOver/VBox/LabelRecordFinal

func _ready() -> void:
	iniciar()

func iniciar() -> void:
	estat_joc = "jugant"
	temps_supervivencia = 0.0
	dificultat = 1.0
	puntuacio_actual = 0.0
	panell_game_over.visible = false
	spawner.iniciar(dificultat)

func _process(delta: float) -> void:
	if estat_joc != "jugant":
		return
	temps_supervivencia += delta
	puntuacio_actual += delta
	dificultat = clamp(dificultat + delta * 0.04, 1.0, 5.0)
	spawner.actualitzar_dificultat(dificultat)
	label_punts.text  = "Temps: %d s" % int(puntuacio_actual)
	label_record.text = "Rec: %d s"   % int(record)

func game_over() -> void:
	if estat_joc == "game_over":
		return
	estat_joc = "game_over"
	spawner.aturar()
	if puntuacio_actual > record:
		record = puntuacio_actual
	label_final.text        = "Temps: %d s" % int(puntuacio_actual)
	label_record_final.text = "Rec: %d s"   % int(record)
	panell_game_over.visible = true

func _on_boto_reiniciar_pressed() -> void:
	for gota in get_tree().get_nodes_in_group("gotes"):
		gota.queue_free()
	# Esperem un frame per assegurar que les gotes han sigut eliminades
	await get_tree().process_frame
	iniciar()
