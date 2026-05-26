# 01_idea_i_abast.md

## 1. Títol provisional del joc
Esquiva la Pluja Àcida

## 2. Tipus de microvideojoc escollit
Endless Runner (Corredor Infinit)

## 3. Objectiu del joc
L'objectiu principal del jugador és sobreviure el màxim de temps possible evitant les gotes de pluja àcida que cauen, acumulant punts per cada segon de supervivència. L'objectiu secundari és superar la seva pròpia puntuació més alta.

## 4. Rol del jugador
El jugador controla un petit supervivent (un personatge simple, com un quadrat o un cercle amb ulls) en un entorn post-apocalíptic minimalista. Pot moure el personatge horitzontalment (esquerra i dreta) per esquivar els obstacles.

## 5. Regles bàsiques
*   Les gotes de pluja àcida cauen des de la part superior de la pantalla a velocitats variables i amb patrons aleatoris.
*   El personatge es mou horitzontalment per la part inferior de la pantalla.
*   Si una gota de pluja àcida impacta al personatge, el joc acaba.
*   La velocitat de caiguda de la pluja i la densitat de gotes augmenten progressivament a mesura que passa el temps, incrementant la dificultat.
*   No hi ha elements de recollida ni power-ups per mantenir la simplicitat.

## 6. Condicions de victòria i derrota
*   **Victòria:** No hi ha una condició de victòria tradicional, ja que és un endless runner. L'objectiu és aconseguir la puntuació més alta possible.
*   **Derrota:** El joc acaba instantàniament quan una gota de pluja àcida impacta directament al personatge.

## 7. Bucle principal del joc
1.  El joc comença amb el personatge a la part inferior de la pantalla i gotes de pluja àcida començant a caure.
2.  El jugador mou el personatge per esquivar les gotes.
3.  El temps de supervivència es registra i es converteix en puntuació.
4.  La dificultat (velocitat i densitat de la pluja) augmenta gradualment.
5.  Si el personatge és colpejat, el joc s'atura, es mostra la puntuació final i s'ofereix l'opció de reiniciar.

## 8. Repte principal i dificultat
*   **Repte principal:** La coordinació ull-mà i la capacitat de reacció del jugador per esquivar un patró de pluja cada vegada més dens i ràpid. El repte és purament mecànic i de reflexos.
*   **Nivell de dificultat previst:** La dificultat s'escalarà de forma progressiva i infinita, començant amb un nivell molt baix per ser accessible i augmentant ràpidament per mantenir el repte. L'objectiu és que sigui fàcil d'aprendre però difícil de dominar.

## 9. Limitacions explícites (Què NO inclourà el joc)
*   No hi haurà power-ups ni ítems col·leccionables.
*   No hi haurà diferents tipus d'enemics o obstacles més enllà de les gotes de pluja àcida.
*   No hi haurà sistema de nivells ni progressió de personatge.
*   No hi haurà multijugador ni taules de classificació en línia.
*   Els gràfics seran minimalistes (sprites 2D simples o formes geomètriques).

## 10. Riscos tècnics
1.  **Optimització del rendiment:** Assegurar que el joc funcioni fluidament en dispositius amb recursos limitats, especialment a mesura que la densitat de la pluja augmenta. La generació constant de gotes i la detecció de col·lisions podrien ser un problema si no s'optimitza correctament.
2.  **Generació de patrons de pluja:** Crear un algorisme de generació de pluja que sigui aleatori però just, i que escali la dificultat de manera progressiva sense ser previsible o impossible. Un mal disseny podria frustrar el jugador.
3.  **Detecció de col·lisions precisa:** Implementar una detecció de col·lisions eficient i precisa entre el personatge i les gotes de pluja, evitant falsos positius o negatius que afectin l'experiència de joc.

## 11. Exploració amb IA (mínim 2 prompts + resposta resumida)

**Prompt 1:** "Ideas para microvideojuegos endless runner minimalistas"

**Respuesta resumida:** La IA sugiere que los endless runner minimalistas se centran en mecánicas simples y un arte visual despojado. Algunas ideas recurrentes incluyen: esquivar obstáculos en un entorno que cambia de color, recolectar elementos para cambiar la forma del personaje, o un juego donde el personaje corre por una línea y debe saltar o agacharse para evitar segmentos de la línea que desaparecen. La clave es la simplicidad en el control y la progresión de la dificultad.

**Prompt 2:** "Ideas para microvideojuegos endless runner minimalistas con un giro único"

**Respuesta resumida:** La IA, al buscar un "giro único", propone ideas como: un endless runner donde el jugador controla dos personajes simultáneamente, un juego donde el entorno se construye o destruye a medida que avanzas, o un runner rítmico donde los obstáculos aparecen al compás de la música. También se mencionan ideas donde el personaje puede invertir la gravedad o cambiar de plano (2D a 3D) para esquivar. Estas ideas buscan añadir una capa extra de complejidad o novedad a la mecánica básica del endless runner.

## 12. Proposta final escollida

La proposta final escollida és **Esquiva la Pluja Àcida**.

## 13. Justificació de viabilitat

"Esquiva la Pluja Àcida" és una idea viable i coherent amb el temps disponible (aproximadament 10 hores) per les següents raons:

*   **Simplicitat de mecàniques:** El control es limita a moviment horitzontal, i la mecànica principal és esquivar. Això redueix dràsticament el temps de desenvolupament i la complexitat de la programació.
*   **Art minimalista:** La decisió d'utilitzar gràfics minimalistes (formes geomètriques o sprites simples) elimina la necessitat de crear o adquirir assets complexos, permetent centrar-se en la jugabilitat.
*   **Bucle de joc clar:** El bucle de joc és fàcil d'implementar i de provar, ja que es basa en la generació de gotes i la detecció de col·lisions. La progressió de la dificultat és paramètrica i es pot ajustar fàcilment.
*   **Requisits de rendiment baixos:** Al ser un joc 2D amb pocs elements en pantalla, els requisits de rendiment són baixos, la qual cosa facilita l'optimització.
*   **Abast ben delimitat:** Les limitacions explícites (no power-ups, no multijugador, etc.) asseguren que el projecte no s'expandeixi més enllà del temps assignat, mantenint el focus en el core gameplay.
*   **Experiència de joc immediata:** Els endless runner són coneguts per la seva accessibilitat i la seva capacitat d'oferir una experiència de joc ràpida i addictiva, la qual cosa és ideal per a un microvideojoc.

## 14. Mini pla de treball

1.  **Fase 1: Disseny i Planificació (1.5 hores)**
    *   Definició de la idea, mecàniques, regles i abast (completada amb aquest document).
    *   Creació del document de disseny (`01_idea_i_abast.md`).

2.  **Fase 2: Prototipat i Mecàniques Bàsiques (3 hores)**
    *   Configuració del projecte en el motor de joc.
    *   Implementació del moviment del jugador.
    *   Generació bàsica de gotes de pluja.
    *   Detecció de col·lisions i final del joc.
    *   Visualització de la puntuació.

3.  **Fase 3: Millora i Escalabilitat (3 hores)**
    *   Implementació de l'escalada de dificultat (velocitat i densitat de la pluja).
    *   Refinament de la generació de patrons de pluja.
    *   Ajustaments visuals minimalistes (colors, formes).
    *   Implementació de la puntuació més alta.

4.  **Fase 4: Poliment i Proves (2.5 hores)**
    *   Proves de jugabilitat i ajustaments de dificultat.
    *   Correcció de bugs.
    *   Implementació de sons bàsics (opcional, si el temps ho permet).
    *   Preparació per a l'exportació.

## 15. Eines previstes i justificació

*   **Motor de joc:** **Godot Engine**
    *   **Justificació:** És un motor de joc lleuger, de codi obert i gratuït, ideal per a projectes petits i amb una corba d'aprenentatge accessible. Permet desenvolupament 2D de manera eficient i és adequat per a la creació ràpida de prototips. El seu llenguatge de scripting (GDScript) és similar a Python, facilitant la programació.

*   **Editor de text/IDE:** **Visual Studio Code**
    *   **Justificació:** Un editor de codi versàtil i lleuger amb extensions per a GDScript i altres llenguatges, que facilita la programació i la gestió del projecte.

*   **Eina de disseny gràfic (minimalista):** **Inkscape o GIMP** (per a sprites molt bàsics si cal)
    *   **Justificació:** Per a la creació de formes geomètriques simples o sprites minimalistes, aquestes eines de codi obert són suficients i no requereixen una gran inversió de temps en aprenentatge o ús per a aquest tipus de projecte.
