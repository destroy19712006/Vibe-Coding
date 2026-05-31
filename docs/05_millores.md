# 05_millores.md

## 1. Millores implementades respecte al disseny inicial

### 1.1. Sistema de dificultat progressiva

El document `01_idea_i_abast.md` establia que la velocitat de caiguda i la densitat de gotes havien d'augmentar progressivament. Aquesta millora s'ha implementat completament a `main.gd` i `spawner_pluja.gd`.

A `main.gd`, la dificultat s'incrementa cada frame de forma gradual, amb un maxim de 5.0:

```gdscript
dificultat = clamp(dificultat + delta * 0.04, 1.0, 5.0)
spawner.actualitzar_dificultat(dificultat)
```

A `spawner_pluja.gd`, la dificultat afecta dos parametres alhora: la frequencia d'aparicio de gotes i la seva velocitat de caiguda:

```gdscript
func actualitzar_dificultat(dificultat: float) -> void:
    var nova_freq: float = clamp(frequencia_spawn / dificultat, 0.15, 1.5)
    if abs(timer.wait_time - nova_freq) > 0.05:
        timer.wait_time = nova_freq
```

La velocitat de cada gota generada s'escala tambe amb la dificultat:

```gdscript
var vel_max: float = clamp(
    rang_velocitat.y * (_dificultat_actual * 0.4 + 0.6),
    rang_velocitat.x,
    rang_velocitat.y * 2.0
)
gota.set("velocitat_caiguda", randf_range(rang_velocitat.x, vel_max))
```

---

### 1.2. Sistema de record de sessio

El disseny inicial preveia que el jugador pogue superar la seva propia puntuacio. S'ha implementat un record de sessio (no persistent entre sessions) a `main.gd`:

```gdscript
if puntuacio_actual > record:
    record = puntuacio_actual
```

El record es mostra en tot moment al HUD amb `LabelRecord` i tambe es mostra a la pantalla de Game Over amb `LabelRecordFinal`.

---

### 1.3. Limitacio del jugador als bordes de pantalla

El disseny inicial especificava que el personatge es mou horitzontalment pero no detallava el comportament als limits. S'ha implementat a `jugador.gd` una limitacio dinamica que te en compte la mida real del sprite del jugador:

```gdscript
func _limitar_pantalla() -> void:
    var vp: Vector2 = get_viewport_rect().size
    var sprite: Sprite2D = $Sprite2D
    var meitat: float = 40.0
    if sprite and sprite.texture:
        var tex_w: float = sprite.texture.get_width() * abs(sprite.scale.x)
        meitat = tex_w / 2.0
    position.x = clamp(position.x, meitat, vp.x - meitat)
```

---

### 1.4. Eliminacio de gotes en sortir de pantalla

Per evitar l'acumulacio d'objectes a memoria a mesura que el joc avanca, cada gota s'autoelimina quan surt per la part inferior de la pantalla:

```gdscript
func _process(delta: float) -> void:
    position.y += velocitat_caiguda * delta
    if position.y > get_viewport_rect().size.y + 80.0:
        queue_free()
```

---

### 1.5. Neteja de gotes en reiniciar

Quan el jugador prem "Tornar a jugar", totes les gotes actives a l'escena s'eliminen abans de reiniciar, evitant que quedin gotes residuals de la partida anterior:

```gdscript
func _on_boto_reiniciar_pressed() -> void:
    for gota in get_tree().get_nodes_in_group("gotes"):
        gota.queue_free()
    await get_tree().process_frame
    iniciar()
```

L'espera d'un frame (`await get_tree().process_frame`) assegura que Godot processa les eliminacions abans de reiniciar l'estat del joc.

---

### 1.6. Panell de Game Over amb informacio completa

En lloc de simplement aturar el joc, s'ha creat un panell de Game Over (`PanellGameOver`) que mostra:

- El text "GAME OVER" en vermell (font 48px)
- El temps de supervivencia de la partida acabada
- El record de la sessio
- El boto "Tornar a jugar"

---

## 2. Millores previstes pero no implementades

Les seguents millores estaven fora de l'abast definit al document `01_idea_i_abast.md` i no s'han implementat:

- **Persistencia del record:** El record actual es perd en tancar el joc. Amb `FileAccess` de Godot es podria guardar i carregar el record entre sessions.
- **Sons i efectes d'audio:** Es va plantejar com a opcio si el temps ho permetia. No s'ha implementat.
- **Power-ups o items:** Exclosos explicitament al disseny inicial.
- **Multijugador o classificacio en linia:** Exclosos explicitament al disseny inicial.
