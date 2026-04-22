# 02_model_del_joc.md

## 1. Components principals del joc
- GameManager
- Jugador
- GotaPluja
- SpawnerPluja
- SistemaPuntuacio

---

## 2. Entitats identificades
- GameManager
- Jugador
- GotaPluja
- SpawnerPluja
- SistemaPuntuacio

---

## 3. Atributs clau

### GameManager
- estat_joc
- temps_supervivencia
- dificultat

### Jugador
- posicio_x
- velocitat
- mida

### GotaPluja
- posicio_x, posicio_y
- velocitat_caiguda

### SpawnerPluja
- frequencia_spawn
- rang_velocitat

### SistemaPuntuacio
- puntuacio_actual
- record

---

## 4. Mètodes principals

### GameManager
- iniciar()
- update()
- game_over()

### Jugador
- moure()
- actualitzar()

### GotaPluja
- caure()
- detectar_sortida()

### SpawnerPluja
- generar_gota()

### SistemaPuntuacio
- sumar_temps()
- guardar_record()

---

## 5. Explicació diagrama de classes

El sistema està organitzat al voltant del GameManager, que controla tota la lògica.

- El Jugador interactua amb les gotes.
- El Spawner genera obstacles.
- El Sistema de puntuació mesura supervivència.

Separació clara de responsabilitats i disseny modular.

---

## 6. Explicació diagrama de comportament

Representa el bucle del joc:

- Inici
- Input jugador
- Moviment
- Spawn de gotes
- Actualització
- Col·lisions
- Increment dificultat
- Game Over

---

## 7. Correspondència amb el codi

- GameManager → main.gd
- Jugador → jugador.gd
- GotaPluja → escena reutilitzable
- Spawner → node controlador
- Puntuació → script global

---

## 8. Estructura del repositori

```
projecte/
├── scenes/
├── scripts/
├── assets/
├── diagrames/
│   ├── diagrama_classes.png
│   ├── diagrama_comportament.png
├── README.md
```

---

## 9. Primer commit

Initial commit: estructura base + documentació fase 2

