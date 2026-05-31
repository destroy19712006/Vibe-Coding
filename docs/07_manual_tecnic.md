# 07_manual_tecnic.md

## Esquiva la Pluja Acida — Manual tecnic

---

## 1. Requisits tecnics

- **Motor:** Godot Engine 4.6 (renderer Forward Plus)
- **Llenguatge de scripting:** GDScript
- **Fisica 2D:** Gravetat per defecte desactivada (`2d/default_gravity=0`). El moviment de les gotes es gestiona manualment per script.
- **Sistema operatiu:** Windows, macOS o Linux

---

## 2. Estructura de fitxers

```
lluvia-acida/
├── assets/
│   ├── Fondo_lluvia.png          — Imatge de fons de la pantalla de joc
│   ├── gota_pluja_sprite.png     — Sprite de les gotes de pluja
│   └── player.png                — Sprite del personatge jugador
├── scenes/
│   ├── main.tscn                 — Escena principal del joc
│   ├── main.gd                   — Script de la logica principal (GameManager)
│   ├── gota_pluja.tscn           — Escena reutilitzable de la gota
│   └── jugador.tscn              — Escena del personatge jugador
├── scripts/
│   ├── jugador.gd                — Logica del jugador
│   ├── gota_pluja.gd             — Logica de cada gota
│   └── spawner_pluja.gd          — Logica de generacio de gotes
├── icon.svg                      — Icona del projecte
└── project.godot                 — Configuracio del projecte Godot
```

---

## 3. Scripts i responsabilitats

### main.gd (scenes/main.gd)

Es el GameManager del joc. Controla l'estat global i el bucle de joc.

**Variables principals:**
- `estat_joc: String` — Pot tenir els valors `"jugant"` o `"game_over"`
- `temps_supervivencia: float` — Temps acumulat en la partida actual
- `dificultat: float` — Escala de dificultat, s'inicia a 1.0 i arriba fins a 5.0
- `puntuacio_actual: float` — Equivalent a `temps_supervivencia`, usada per mostrar al HUD
- `record: float` — Millor temps de la sessio

**Metodes principals:**
- `iniciar()` — Reinicia totes les variables i activa el spawner
- `_process(delta)` — Actualitza el temps, la dificultat i el HUD cada frame mentre `estat_joc == "jugant"`
- `game_over()` — Atura el spawner, actualitza el record i mostra el PanellGameOver
- `_on_boto_reiniciar_pressed()` — Elimina totes les gotes actives i crida `iniciar()`

**Nodes referenciats via @onready:**
```gdscript
@onready var spawner: Node2D           = $SpawnerPluja
@onready var label_punts: Label        = $HUD/LabelPunts
@onready var label_record: Label       = $HUD/LabelRecord
@onready var panell_game_over: Control = $HUD/PanellGameOver
@onready var label_final: Label        = $HUD/PanellGameOver/VBox/LabelFinal
@onready var label_record_final: Label = $HUD/PanellGameOver/VBox/LabelRecordFinal
```

---

### jugador.gd (scripts/jugador.gd)

Controla el moviment i les col·lisions del personatge jugador.

**Variables:**
- `velocitat: float = 350.0` — Velocitat de desplacament horitzontal en pixels per segon. Es un `@export`, editable des de l'editor de Godot.
- `_game_manager: Node` — Referencia al node pare (Main), usat per comprovar l'estat del joc i cridar `game_over()`

**Metodes:**
- `_ready()` — Posiciona el jugador al centre inferior de la pantalla, obte la referencia al GameManager, s'afegeix al grup `"jugador"` i configura les capes de col·lisio (layer=1, mask=2)
- `_physics_process(delta)` — Comprova si el joc esta en estat `"jugant"`. Si no, atura el moviment. Si si, crida `moure()`, `move_and_slide()` i `_limitar_pantalla()`
- `moure()` — Llegeix l'eix horitzontal d'input (`ui_left`, `ui_right`) i aplica la velocitat
- `_limitar_pantalla()` — Clamp de la posicio X entre els limits de la pantalla, tenint en compte l'amplada real del sprite escalat
- `rebre_impacte()` — Crida `game_over()` al GameManager quan una gota col·lisiona amb el jugador

**Capes de col·lisio:**
- `collision_layer = 1`
- `collision_mask = 2`

---

### gota_pluja.gd (scripts/gota_pluja.gd)

Controla el comportament de cada gota individual.

**Variables:**
- `velocitat_caiguda: float = 250.0` — Velocitat vertical de caiguda en pixels per segon. S'estableix externament pel spawner en el moment de la instanciacio.

**Metodes:**
- `_ready()` — Afegeix la gota al grup `"gotes"`, configura les capes de col·lisio (layer=2, mask=1) i connecta el senyal `body_entered` al metode `_on_body_entered`
- `_process(delta)` — Desplaca la gota cap avall cada frame. Si surt 80px per sota de la pantalla, crida `queue_free()`
- `_on_body_entered(body)` — Si el cos que entra a l'Area2D pertany al grup `"jugador"`, crida `rebre_impacte()` al jugador i elimina la gota

**Capes de col·lisio:**
- `collision_layer = 2`
- `collision_mask = 1`

---

### spawner_pluja.gd (scripts/spawner_pluja.gd)

Genera les gotes de pluja a intervals regulars i gestiona la dificultat.

**Variables exportades:**
- `frequencia_spawn: float = 0.8` — Temps en segons entre generacions de gotes (valor inicial)
- `rang_velocitat: Vector2 = Vector2(180, 320)` — Rang de velocitats possibles per a les gotes (min, max) en pixels per segon

**Variables internes:**
- `gota_escena: PackedScene` — Precarrega `res://scenes/gota_pluja.tscn`
- `_dificultat_actual: float = 1.0` — Valor de dificultat actual rebut del GameManager

**Metodes:**
- `iniciar(dificultat)` — Estableix la dificultat inicial i arrenca el Timer
- `aturar()` — Atura el Timer (usat en game_over)
- `actualitzar_dificultat(dificultat)` — Recalcula el `wait_time` del Timer. La nova frequencia es `clamp(frequencia_spawn / dificultat, 0.15, 1.5)`. Nomes actualitza si la diferencia es major de 0.05 per evitar canvis innecessaris.
- `_on_timer_timeout()` — Crida `generar_gota()` cada vegada que el Timer arriba a zero
- `generar_gota()` — Instancia una nova gota, la posiciona en una X aleatoria entre 40 i `viewport_width - 40` a -60px de Y, calcula la seva velocitat en funcio de la dificultat i l'afegeix a l'escena pare

**Formula de velocitat maxima per gota:**
```gdscript
var vel_max: float = clamp(
    rang_velocitat.y * (_dificultat_actual * 0.4 + 0.6),
    rang_velocitat.x,
    rang_velocitat.y * 2.0
)
gota.set("velocitat_caiguda", randf_range(rang_velocitat.x, vel_max))
```

---

## 4. Jerarquia de nodes de main.tscn

```
Main (Node2D) [main.gd]
├── Fondo (TextureRect) — Fondo_lluvia.png, pantalla completa
├── Jugador (instancia de jugador.tscn) [jugador.gd]
│   ├── CollisionShape2D (RectangleShape2D 80x80)
│   └── Sprite2D (player.png, scale 0.065)
├── SpawnerPluja (Node2D) [spawner_pluja.gd]
│   └── Timer (wait_time=0.8)
└── HUD (CanvasLayer)
    ├── LabelPunts (Label) — font 26px, blanc
    ├── LabelRecord (Label) — font 20px, groc clar
    └── PanellGameOver (Control) [visible=false per defecte]
        ├── Fons (ColorRect) — negre semitransparent (alpha 0.78)
        └── VBox (VBoxContainer)
            ├── LabelGameOver (Label) — "GAME OVER", 48px, vermell
            ├── LabelFinal (Label) — temps de la partida, 28px, blanc
            ├── LabelRecordFinal (Label) — record de sessio, 22px, groc clar
            └── BotoReiniciar (Button) — "Tornar a jugar", 24px, mida minima 260x52
```

---

## 5. Sistema de col·lisions

El projecte utilitza el sistema de fisica de Godot 4 amb capes diferenciades:

- El jugador es un `CharacterBody2D` amb `CollisionShape2D` rectangular
- Les gotes son `Area2D` amb `CollisionShape2D` circular (radi 20)
- Les gotes detecten l'entrada d'un cos via el senyal `body_entered` de l'Area2D
- La comprovacio es fa amb `is_in_group("jugador")` per evitar dependencies fràgils de nom de node

---

## 6. Flux de joc (bucle principal)

```
_ready() → iniciar()
    ↓
_process(delta) [cada frame]
    ├── Incrementa temps_supervivencia i puntuacio_actual
    ├── Incrementa dificultat (+ delta * 0.04, max 5.0)
    ├── spawner.actualitzar_dificultat(dificultat)
    └── Actualitza LabelPunts i LabelRecord

spawner Timer → generar_gota()
    └── Nova GotaPluja afegida a l'escena

GotaPluja._process(delta)
    ├── Mou la gota cap avall
    └── Si surt de pantalla → queue_free()

GotaPluja._on_body_entered(body)
    └── Si body es "jugador" → body.rebre_impacte() + queue_free()

jugador.rebre_impacte()
    └── game_over()
            ├── estat_joc = "game_over"
            ├── spawner.aturar()
            ├── Actualitza record si cal
            └── Mostra PanellGameOver

BotoReiniciar.pressed → _on_boto_reiniciar_pressed()
    ├── Elimina totes les gotes del grup "gotes"
    ├── await get_tree().process_frame
    └── iniciar()
```

---

## 7. Parametres ajustables

Els seguents parametres son `@export` i es poden modificar des de l'inspector de Godot sense editar el codi:

| Parametre | Script | Valor per defecte | Efecte |
|-----------|--------|-------------------|--------|
| `velocitat` | jugador.gd | 350.0 | Velocitat de desplacament horitzontal del jugador |
| `frequencia_spawn` | spawner_pluja.gd | 0.8 | Interval inicial entre gotes (en segons) |
| `rang_velocitat` | spawner_pluja.gd | Vector2(180, 320) | Rang de velocitats de caiguda de les gotes |
