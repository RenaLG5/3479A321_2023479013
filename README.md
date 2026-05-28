# Buscaminas en Flutter

Proyecto desarrollado en Flutter como parte de una serie de laboratorios enfocados en el desarrollo móvil multiplataforma. La aplicación implementa una versión funcional del clásico juego Buscaminas utilizando arquitectura MVVM, Provider para gestión de estado y diversas características de hardware e interacción móvil.

---

# Características Implementadas

## Interfaz gráfica del juego

* Tablero dinámico generado con `GridView.builder`
* Diseño responsive adaptable
* Barra de estado con:

  * Temporizador
  * Cantidad de minas
  * Cantidad de cuadros
* Pantalla de victoria y derrota
* Botón de reinicio de partida
* Pantalla About
* Pantalla de configuración

---

## Lógica del juego

* Generación aleatoria de minas
* Cálculo de bombas adyacentes
* Revelado de celdas
* Expansión automática de áreas vacías (Flood Fill)
* Detección de derrota
* Detección de victoria
* Reinicio de partida

---

## Persistencia de configuración

Uso de `SharedPreferences` para guardar:

* Tamaño del tablero
* Cantidad de minas

---

## Audio e interacción multimedia

Integración de sonidos utilizando `audioplayers`:

* Sonido al revelar celda
* Sonido de explosión
* Sonido de victoria

---

## Sensores del dispositivo

Uso de acelerómetro mediante `sensors_plus`:

* Agitar el teléfono reinicia la partida automáticamente

---

## Compartir resultados

Uso de `share_plus`:

* Compartir resultados de victoria o derrota
* Compatible con WhatsApp, Discord, Gmail, etc.

---

## Identidad digital

* Cambio de package name
* Cambio de icono de aplicación
* Personalización visual de la app

---

# Tecnologías Utilizadas

* Flutter
* Dart
* Provider
* MVVM
* SharedPreferences
* Audioplayers
* Sensors Plus
* Share Plus
* Logger

---

# Estructura del Proyecto

```text
lib/
├── models/
├── ui/
├── views/
├   ├── screens/
├   ├── widgets/
├   └── viewmodels/
├
└── main.dart
```

---

# Cómo ejecutar el proyecto

## 1. Clonar repositorio

```bash
git clone <URL_DEL_REPOSITORIO>
```

---

## 2. Instalar dependencias

```bash
flutter pub get
```

---

## 3. Ejecutar aplicación

```bash
flutter run
```

---

# Dependencias principales

```yaml
provider:
shared_preferences:
audioplayers:
sensors_plus:
share_plus:
logger:
```

---

# 🎮 Funcionalidades del Juego

| Función                       | Estado |
| ----------------------------- | ------ |
| Generación de tablero         | ✅      |
| Minas aleatorias              | ✅      |
| Temporizador                  | ✅      |
| Reinicio                      | ✅      |
| Detección de victoria         | ✅      |
| Detección de derrota          | ✅      |
| Sonidos                       | ✅      |
| Compartir resultados          | ✅      |
| Acelerómetro                  | ✅      |
| Persistencia de configuración | ✅      |

---

## Capturas
# 📸 Capturas

## Pantalla Principal

![Juego](capturas/Juego.png)

---

## Pantalla de Victoria

![Victoria](capturas/Win.png)

---

## Pantalla de Derrota

![Derrota](capturas/Derrota.png)

---

## Configuración

![Configuración](capturas/Configuración.png)

---

## Compartir Resultado

![Compartir](capturas/Compartir.png)

![Compartir](capturas/CompartirWin.png)

---
## Pantalla Principal

* Tablero del juego
* Barra de estado
* Botones de acción

## Pantalla de Victoria

* Mensaje de victoria
* Compartir resultado

## Pantalla de Derrota

* Mensaje de derrota
* Reinicio rápido

---

# Trabajos Futuros

* Implementación de banderas
* Diferentes niveles de dificultad
* Ranking online
* Animaciones
* Multijugador
* Temas visuales
* Guardado de partidas
* Música de fondo
* Estadísticas del jugador

---

# Autor

Proyecto desarrollado por 
Renato León

---

