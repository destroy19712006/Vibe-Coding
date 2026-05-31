# 03_entorn_i_prototip.md

## 1. Eines i versions utilitzades

| Eina | Versio | Justificacio |
|------|--------|--------------|
| Godot Engine | 4.6 | Motor 2D lleuger, de codi obert i amb GDScript integrat. Configurat al project.godot amb `config/features=PackedStringArray("4.6", "Forward Plus")` |
| GDScript | integrat a Godot 4.x | Llenguatge de scripting natiu del motor, similar a Python. Usat en tots els scripts del projecte |
| Visual Studio Code | - | Editor de text extern per editar scripts .gd fora de l'editor de Godot |
| Git | - | Control de versions. El repositori conta amb 12 commits des de l'inici del projecte |

---

## 2. Estructura del projecte

```
lluvia-acida/
├── assets/
│   ├── Fondo_lluvia.png
│   ├── gota_pluja_sprite.png
│   └── player.png
├── scenes/
│   ├── main.tscn
│   ├── main.gd
│   ├── gota_pluja.tscn
│   └── jugador.tscn
├── scripts/
│   ├── main.gd
│   ├── jugador.gd
│   ├── gota_pluja.gd
│   └── spawner_pluja.gd
├── icon.svg
└── project.godot
```

---

## 3. Configuracio del projecte Godot

El fitxer `project.godot` defineix els parametres principals:

- **Nom del projecte:** `Esquiva la Pluja Acida`
- **Escena principal:** `res://scenes/main.tscn`
- **Versio del motor:** 4.6, renderer Forward Plus
- **Gravetat 2D per defecte:** 0 (les gotes no usen fisica de gravetat del motor, sino desplacament manual per script)
- **Filtre de textures:** `default_texture_filter=0` (filtre nearest, adequat per a sprites pixelats)

---

## 4. Configuracio del sistema de collisions

El projecte fa servir dos capes de col·lisions diferenciades:

- **Capa 1 (collision_layer = 1):** Jugador (`CharacterBody2D`)
- **Capa 2 (collision_layer = 2):** Gotes de pluja (`Area2D`)

El jugador te `collision_mask = 2` i les gotes tenen `collision_mask = 1`, de manera que les gotes detecten el jugador pero no interaccionen amb altres elements.

---

## 5. Prototip inicial i estat al final de la Fase 3

Segons el document de la Fase 3, en el moment de l'entrega inicial:

- Els scripts funcionaven correctament
- La pantalla del personatge i el fons no eren visibles encara a l'escena
- El boto "Tornar a jugar" no funcionava encara
- L'estructura de nodes de `main.tscn` estava creada i visible al panel de Godot

Els bugs identificats i resolts posteriorment estan documentats al README del projecte.

---

## 6. Escenes creades

### main.tscn
Escena arrel del joc. Conté els nodes:
- `Main` (Node2D) — arrel amb `main.gd` assignat
- `Fondo` (TextureRect) — imatge de fons a pantalla completa (`Fondo_lluvia.png`)
- `Jugador` — instancia de `jugador.tscn`
- `SpawnerPluja` (Node2D) — amb `spawner_pluja.gd` i un node `Timer` (wait_time inicial = 0.8 s)
- `HUD` (CanvasLayer) — interficie d'usuari amb:
  - `LabelPunts` — mostra el temps actual (font 26px, blanc)
  - `LabelRecord` — mostra el record de sessio (font 20px, groc clar)
  - `PanellGameOver` — panel ocult que apareix en morir, amb `LabelGameOver`, `LabelFinal`, `LabelRecordFinal` i `BotoReiniciar`

### jugador.tscn
- Node arrel: `CharacterBody2D`
- `CollisionShape2D` amb `RectangleShape2D` de mida 80x80
- `Sprite2D` amb `player.png` escalat a 0.065

### gota_pluja.tscn
- Node arrel: `Area2D`
- `CollisionShape2D` amb `CircleShape2D` de radi 20
- `Sprite2D` amb `gota_pluja_sprite.png` escalat a 0.05

---

## 7. Primer commit i evolucio del repositori

El repositori va comencar amb un `Initial commit` i ha evolucionat en 12 commits fins a l'estat actual (`Joc Pujat`). Els commits principals inclouen la pujada dels diagrames, la documentacio de les fases 1 i 2, i l'entrega de la Fase 3 amb el joc funcional.
