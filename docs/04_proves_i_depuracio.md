# 04_proves_i_depuracio.md

## 1. Metodologia de proves

Les proves han estat funcionals i manuals, executant el joc directament des de l'editor de Godot (F5) i observant el comportament en temps real. No s'han utilitzat frameworks de testing automatitzat, ja que l'abast del projecte no ho requeria.

---

## 2. Bugs identificats i resolts

Tots els bugs que es detallen a continuacio estan documentats al `README.md` del projecte.

### Bug 1: El jugador no es movia

**Simptoma:** En executar el joc, el personatge no responia als inputs de teclat.

**Causa:** A `main.tscn`, el node Jugador tenia `script = null`, es a dir, no tenia cap script assignat, de manera que la funcio `_physics_process` de `jugador.gd` mai s'executava.

**Solucio:** Assignar correctament el script `jugador.gd` al node `Jugador` dins de l'escena `main.tscn`. Ara el node Jugador es una instancia de `jugador.tscn` que ja porta el script inclos.

---

### Bug 2: Les gotes no apareixien en pantalla

**Simptoma:** El joc s'iniciava pero no generava cap gota de pluja acida.

**Causa:** El node `Timer` dins de `SpawnerPluja` existia a l'escena pero la seva senyal `timeout` no estava connectada al metode `_on_timer_timeout` de `spawner_pluja.gd`. Per tant, el temporitzador corria pero no cridava mai la funcio de generacio de gotes.

**Solucio:** Afegir la connexio de senyal al fitxer `main.tscn`:
```
[connection signal="timeout" from="SpawnerPluja/Timer" to="SpawnerPluja" method="_on_timer_timeout"]
```

---

### Bug 3: El jugador apareixia fora de pantalla

**Simptoma:** En iniciar el joc, el personatge no era visible perque estava col·locat en una posicio negativa o molt fora dels limits de la finestra.

**Causa:** La posicio inicial del jugador estava definida de forma estatica amb valors incorrectes com `Position(-555, -321)`.

**Solucio:** Calcular la posicio inicial de forma dinamica dins del metode `_ready()` de `jugador.gd`, usant les dimensions reals de la pantalla:

```gdscript
func _ready() -> void:
    var vp: Vector2 = get_viewport_rect().size
    position = Vector2(vp.x / 2.0, vp.y - 60.0)
```

---

### Bug 4: Les gotes no tenien col·lisionador

**Simptoma:** Les gotes passaven a traves del jugador sense detectar cap col·lisio.

**Causa:** A `gota_pluja.tscn`, el node `CollisionShape2D` no existia o no tenia cap forma assignada, de manera que l'`Area2D` no podia detectar cap cos que hi entas.

**Solucio:** Afegir un `CollisionShape2D` amb una `CircleShape2D` de radi 20 com a fill del node `GotaPluja` a `gota_pluja.tscn`.

---

### Bug 5: Deteccio de col·lisions fragil per nom

**Simptoma:** La deteccio de col·lisio entre gota i jugador fallava o no funcionava de forma fiable quan es canviava el nom del node del jugador.

**Causa:** La comprovacio del cos que entrava a l'area es feia comparant `body.name` amb un string literal. Aixo es fragil perque qualsevol canvi al nom del node trencava la logica.

**Solucio:** Substituir la comparacio per nom per l'us de grups de Godot. El jugador s'afegeix al grup `"jugador"` al `_ready()` de `jugador.gd`, i la gota comprova amb `is_in_group`:

```gdscript
# jugador.gd
func _ready() -> void:
    add_to_group("jugador")

# gota_pluja.gd
func _on_body_entered(body: Node) -> void:
    if body.is_in_group("jugador"):
        body.rebre_impacte()
        queue_free()
```

---

## 3. Problemes detectats durant la Fase 3 (pendents en aquell moment)

Segons el document de la Fase 3, en el moment de l'entrega:

- La pantalla del personatge i el fons no eren visibles a l'escena del joc
- El boto "Tornar a jugar" no funcionava correctament

Ambdos problemes van ser resolts en la versio final del codi que es troba al repositori.

---

## 4. Proves de jugabilitat

Les seguents situacions van ser provades manualment:

| Situacio provada | Resultat esperat | Resultat obtingut |
|-----------------|-----------------|-------------------|
| Gota impacta al jugador | Game Over + PanellGameOver visible | Correcte |
| Gota surt per sota de la pantalla | La gota s'elimina (`queue_free`) | Correcte |
| Jugador arriba al limit esquerre | El jugador es queda al limit | Correcte |
| Jugador arriba al limit dret | El jugador es queda al limit | Correcte |
| Premsar "Tornar a jugar" | Les gotes s'eliminen i el joc reinicia | Incorrecte |
| La puntuacio supera el record | El record s'actualitza | Correcte |
| La dificultat augmenta amb el temps | La frequencia i velocitat augmenten | Correcte |
