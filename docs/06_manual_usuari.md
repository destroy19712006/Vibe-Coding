# 06_manual_usuari.md

## Esquiva la Pluja Acida — Manual d'usuari

---

## 1. Descripcio del joc

Esquiva la Pluja Acida es un microvideojoc de tipus endless runner. El jugador controla un personatge que es mou horitzontalment per la part inferior de la pantalla i ha d'esquivar les gotes de pluja acida que cauen des de la part superior. L'objectiu es sobreviure el maxim de temps possible.

No hi ha condicio de victoria: el joc continua indefinidament fins que una gota impacta el personatge.

---

## 2. Requisits per executar el joc

- Godot Engine 4.6 o superior instal·lat
- Ordinador amb Windows, macOS o Linux

---

## 3. Com obrir i executar el joc

1. Extreure el contingut del fitxer ZIP del projecte
2. Obrir Godot Engine 4
3. A la pantalla del gestor de projectes, fer clic a "Import"
4. Navegar fins a la carpeta `lluvia-acida` i seleccionar-la
5. Confirmar la importacio
6. Premer el boto Play (F5) o el boto de triangle verd a la barra superior de Godot

---

## 4. Controls

| Accio | Tecla |
|-------|-------|
| Moure el personatge a l'esquerra | Fletxa esquerra o tecla A |
| Moure el personatge a la dreta | Fletxa dreta o tecla D |

El personatge no pot sortir dels limits de la pantalla. No hi ha salt ni cap altre moviment.

---

## 5. Pantalla de joc

### HUD (informacio en pantalla durant la partida)

- **Temps:** Apareix a la cantonada superior esquerra en blanc. Mostra els segons de supervivencia de la partida actual.
- **Rec:** Apareix just a sota del temps, en groc clar. Mostra el millor temps aconseguit durant la sessio actual.

### Elements visuals

- El fons mostra una imatge de pluja acida (`Fondo_lluvia.png`)
- El personatge jugador apareix a la part inferior centrada de la pantalla
- Les gotes de pluja cauen des de la part superior en posicions horitzontals aleatories

---

## 6. Mecanica de dificultat

El joc comenca en un nivell de dificultat baix i augmenta de forma progressiva i automatica a mesura que passen els segons:

- Les gotes cauen cada vegada mes rapid
- Les gotes apareixen amb mes frequencia
- La dificultat arriba al seu maxim als 5 punts interns (escala de 1.0 a 5.0)

No cal fer res per activar aquest augment: succeeix automaticament.

---

## 7. Pantalla de Game Over

Quan una gota impacta el personatge, el joc s'atura i apareix una pantalla de Game Over amb:

- El text "GAME OVER" en vermell
- El temps de supervivencia de la partida acabada
- El record de la sessio
- El boto "Tornar a jugar"

En premer "Tornar a jugar", totes les gotes desapareixen i el joc reinicia des del principi. El record de sessio es conserva entre partides mentre el joc estigui obert.

---

## 8. Puntuacio

La puntuacio es el temps de supervivencia en segons. No hi ha punts per esquivar gotes ni per cap altra accio: l'unic que compta es quant de temps el personatge es mante sense ser impactat.

El record nomes es guarda durant la sessio actual. En tancar el joc, el record es perd.
