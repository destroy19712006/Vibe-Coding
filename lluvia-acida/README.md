# Esquiva la Pluja Àcida — Godot 4.x

## Com obrir el projecte

1. Extreu el ZIP
2. Obre **Godot 4** → "Import" → selecciona la carpeta `lluvia-acida`
3. Prem **Play** (F5)

---

## Bugs corregits

| Bug | Causa original | Solució |
|-----|---------------|---------|
| Jugador no es movia | `script = null` a main.tscn | Script assignat correctament |
| Gotes no apareixien | Timer sense senyal connectada | `[connection]` afegit a main.tscn |
| Jugador fora de pantalla | Position(-555,-321) | Posició calculada al `_ready()` |
| Gota sense col·lisionador | Faltava CollisionShape2D | CircleShape2D afegit a gota_pluja.tscn |
| Detecció fràgil (body.name) | Comparació per nom | Ús de grups (`is_in_group`) |

---

## Arquitectura (diagrama de classes)

```
GameManager (main.gd)
 ├── estat_joc / temps_supervivencia / dificultat
 ├── iniciar() / update() / game_over()
 ├── SpawnerPluja (spawner_pluja.gd)
 │    ├── frequencia_spawn / rang_velocitat
 │    └── generar_gota() → GotaPluja
 ├── Jugador (jugador.gd)
 │    ├── posicio_x / velocitat / mida
 │    └── moure() / actualitzar() / rebre_impacte()
 └── SistemaPuntuacio (integrat a main.gd)
      ├── puntuacio_actual / record
      └── sumar_temps() / guardar_record()
```

## Bucle de joc (diagrama de comportament)

Inici → Jugador es mou → Generar gotes → Actualitzar posicions
→ Comprovar col·lisions → Col·lisió? → Sí: Game Over → Mostrar puntuació → Reiniciar
                                      → No: Augmentar dificultat → (loop)

---

## Controls
- **← →** o **A D** — moure el jugador

## Mecàniques implementades
- Dificultat progressiva (velocitat i freqüència augmenten)
- Puntuació per temps de supervivència
- Rècord de sessió
- Pantalla de Game Over amb opció de reinici
