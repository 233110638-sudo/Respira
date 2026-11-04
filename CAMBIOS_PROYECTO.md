# Cambios respecto al proyecto original

## Resumen

El proyecto original era **Vivero+**, una app de catálogo y cuidado de plantas con autenticación y carrito. Se transformó en **Respira**, una aplicación local de acompañamiento general al bienestar emocional. La carpeta y los identificadores internos del proyecto ahora usan **Proyecto**.

## Cambios funcionales

| Área | Proyecto original | Proyecto actual |
|---|---|---|
| Propósito | Catálogo y cuidado de plantas | Bienestar emocional y ejercicios de acompañamiento |
| Inicio | Productos, favoritos y carrito | Acceso a chequeo, respiración, acompañamiento y ayuda en crisis |
| Primer uso | Autenticación y onboarding de vivero | Bienvenida → consentimiento → chequeo → recomendaciones → inicio |
| Datos | Catálogo de plantas de demostración y sesión Firebase | Flujo local; no se crea cuenta ni se envían respuestas a servicios externos |
| Recursos | Fotografías y logos de plantas | Componentes dibujados con Flutter e iconos incluidos en Material |

## Pantallas y navegación nuevas

- **Bienvenida:** presentación de Respira.
- **Consentimiento:** explica el alcance de la herramienta y permite continuar tras aceptar.
- **Chequeo de bienestar:** cuestionario de 8 preguntas (7 ítems de bienestar tipo GAD-7 adaptados + 1 ítem de seguridad) con barra de progreso y cálculo interno de puntuación sin mostrar puntajes ni etiquetas clínicas.
- **Recomendaciones:** ofrece orientación diferenciada según el puntaje interno (ejercicios de calma y psicólogo destacado para 10-21 pts; ejercicios de bienestar y artículos para 0-9 pts). En todos los casos incluye recomendación de acudir al psicólogo y acceso a ayuda inmediata.
- **Protocolo de crisis:** números de Línea de la Vida (800 911 2000) y 911 con botones directos para marcar/copiar, plantilla de mensaje para personas de confianza y recomendación de acudir a un psicólogo cuando esté a salvo.
- **Ejercicio de grounding:** técnica guiada 5-4-3-2-1 para conectar con el presente a través de los sentidos.
- **Artículos de la psicóloga:** lecturas psicoeducativas sobre sobrecarga, pausas conscientes y valor de la consulta profesional.
- **Botón de ayuda en todas las pantallas:** acceso directo a la pantalla de crisis desde las barras superiores y menús.

## Reorganización del código

- `lib/screens/` contiene las pantallas nuevas.
- `lib/widgets/` contiene componentes reutilizables para tarjetas y etiquetas.
- `lib/core_theme.dart` define la paleta y el tema de Respira.
- `lib/main.dart` inicializa la aplicación sin autenticación ni proveedores externos.
- `test/respira_flow_test.dart` recorre el flujo desde bienvenida hasta ayuda en crisis.

## Inventario de código cambiado y añadido

### Código existente modificado

- [lib/main.dart](lib/main.dart): elimina la inicialización de Firebase y Provider; inicia `RespiraApp` con `SplashScreen` y el tema de Respira.
- [lib/core_theme.dart](lib/core_theme.dart): reemplaza la paleta azul del vivero por colores suaves y define `buildRespiraTheme()`.
- [lib/splash_screen.dart](lib/splash_screen.dart): reemplaza el destino basado en sesión por la bienvenida de Respira.
- [pubspec.yaml](pubspec.yaml): cambia el paquete Flutter a `respira` y elimina las dependencias de Firebase y Provider.

### Código nuevo

- Bienvenida y consentimiento: [lib/screens/welcome_screen.dart](lib/screens/welcome_screen.dart), [lib/screens/consent_screen.dart](lib/screens/consent_screen.dart).
- Chequeo y orientación: [lib/screens/wellbeing_check_screen.dart](lib/screens/wellbeing_check_screen.dart), [lib/screens/recommendations_screen.dart](lib/screens/recommendations_screen.dart).
- Inicio y herramientas: [lib/screens/home_screen.dart](lib/screens/home_screen.dart), [lib/screens/breathing_screen.dart](lib/screens/breathing_screen.dart), [lib/screens/support_someone_screen.dart](lib/screens/support_someone_screen.dart), [lib/screens/crisis_screen.dart](lib/screens/crisis_screen.dart).
- Componentes compartidos: [lib/widgets/action_card.dart](lib/widgets/action_card.dart), [lib/widgets/section_label.dart](lib/widgets/section_label.dart).
- Prueba automatizada del recorrido: [test/respira_flow_test.dart](test/respira_flow_test.dart).

## Código y dependencias retirados

Se retiraron los módulos y símbolos antiguos siguientes:

- Autenticación: `AuthRepository`, `AuthScreen` y la configuración Firebase usada por el inicio de sesión.
- Tienda y plantas: `CatalogoScreen`, `PlantCard`, `PlantDetailsScreen`, `Plant`, `PlantRepository` y `plantasDemo`.
- Carrito e inicio anterior: `CartProvider` y el `HomeScreen` que mostraba favoritos, catálogo y acciones de compra.
- Bienvenida anterior y botón genérico: `OnboardingScreen` y `CustomButton`.
- Archivos de configuración y ejemplo: configuración Firebase de Android/web y el ejemplo de código de Vivero+.
- Recursos: imágenes y logos de plantas.

También se quitaron las dependencias de Firebase y Provider. La app usa Flutter y sus widgets integrados, sin añadir paquetes externos.

## Archivos de configuración renombrados o actualizados

- Android: [android/app/build.gradle.kts](android/app/build.gradle.kts) y [MainActivity.kt](android/app/src/main/kotlin/com/example/proyecto/MainActivity.kt).
- iOS: [ios/Runner.xcodeproj/project.pbxproj](ios/Runner.xcodeproj/project.pbxproj).
- Linux: [linux/CMakeLists.txt](linux/CMakeLists.txt).
- macOS: [macOS AppInfo.xcconfig](macos/Runner/Configs/AppInfo.xcconfig), [proyecto Xcode](macos/Runner.xcodeproj/project.pbxproj) y [esquema Runner](macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme).
- Web: [web/index.html](web/index.html) y [web/manifest.json](web/manifest.json).
- IntelliJ: [módulos del proyecto](.idea/modules.xml); los archivos de módulo ahora se llaman `Proyecto.iml` y `Proyecto_android.iml`.

## Nombres y configuración de plataformas

- Carpeta raíz del proyecto: `Proyecto`.
- Nombre del paquete Flutter: `respira`.
- Nombre visible de la aplicación: `Respira`.
- Identificadores nativos actualizados a `com.example.proyecto` en Android, iOS, macOS y Linux.
- Paquete Kotlin de Android y módulos de IntelliJ renombrados a `Proyecto`.
- Metadatos de web y nombres de producto de escritorio actualizados.

## Validación realizada

- `flutter analyze`: sin errores.
- `flutter test`: prueba del flujo principal aprobada.
- `flutter build apk --debug`: compilación Android exitosa.
- `flutter build linux`: compilación Linux exitosa.

## Comparación detallada: original vs. actual

### Arranque y navegación

| Elemento | Contenido original | Contenido actual |
|---|---|---|
| Inicialización | `main()` era asíncrono, esperaba `Firebase.initializeApp()` y envolvía la app con `ChangeNotifierProvider<CartProvider>`. | `main()` inicializa Flutter y ejecuta `RespiraApp` directamente. No abre conexiones ni construye estado de carrito. Ver [lib/main.dart](lib/main.dart). |
| Aplicación raíz | `ViveroApp`, título “Vivero+”, tema de vivero y pantalla de splash. | `RespiraApp`, título “Respira”, tema actualizado y splash de bienvenida. |
| Splash | Esperaba dos segundos, consultaba el estado de sesión Firebase y enviaba a inicio, autenticación u onboarding; mostraba un PNG. | Muestra marca y un icono de Flutter; tras una breve pausa navega a bienvenida. No consulta sesión ni depende de imágenes. Ver [lib/splash_screen.dart](lib/splash_screen.dart). |
| Navegación principal | Rutas directas entre autenticación, catálogo, detalles de plantas y hogar. | Flujo inicial bienvenida → consentimiento → chequeo → recomendaciones → inicio. Desde inicio se accede a respiración, acompañamiento y ayuda en crisis. |

### Pantallas originales sustituidas

| Pantalla o módulo original | Qué hacía | Sustitución o destino actual |
|---|---|---|
| Onboarding del vivero | Mostraba el logo de plantas, el lema “cultiva, aprende y crece” y abría autenticación. | Bienvenida de Respira con mensaje de bienestar y botón para empezar. Ver [lib/screens/welcome_screen.dart](lib/screens/welcome_screen.dart). |
| Autenticación | Permitía iniciar sesión y registrar usuarios con correo y contraseña; mostraba errores de Firebase. | Se eliminó. No hay registro ni inicio de sesión. El consentimiento explica el alcance local del prototipo. Ver [lib/screens/consent_screen.dart](lib/screens/consent_screen.dart). |
| Hogar de Vivero+ | Enseñaba correo de usuario, favoritos, cantidad de carrito, botones de agregar/eliminar, catálogo y tarjetas de plantas. | El nuevo inicio ofrece tarjetas de chequeo, respiración y acompañamiento, además de acceso destacado a crisis. Ver [lib/screens/home_screen.dart](lib/screens/home_screen.dart). |
| Catálogo | Buscaba plantas por texto, filtraba por categoría y las mostraba en una cuadrícula. | Se eliminó; Respira no tiene productos, buscador ni categorías comerciales. |
| Detalle de planta | Mostraba foto, precio, descripción, luz, riego y botones para modificar el carrito. | Se eliminó; no hay fichas de productos ni cuidados de plantas. |

### Datos, servicios y lógica

| Área | Código original | Código actual |
|---|---|---|
| Autenticación | `AuthRepository` encapsulaba registro, inicio/cierre de sesión y traducción de errores de Firebase Authentication. | No existe repositorio de autenticación ni llamadas de red. |
| Datos de catálogo | `Plant`, `plantasDemo` y `PlantRepository` representaban una lista estática de plantas y su consulta. | No hay modelos ni repositorios de plantas. Las opciones del chequeo son locales a la pantalla. |
| Carrito | `CartProvider` mantenía un contador con métodos para agregar y quitar elementos. | Se eliminó el proveedor. No hay compras ni estado global de carrito. |
| Estado emocional | No existía. | El chequeo permite seleccionar entre cinco estados; la elección se pasa a recomendaciones durante la navegación y no se persiste. Ver [lib/screens/wellbeing_check_screen.dart](lib/screens/wellbeing_check_screen.dart) y [lib/screens/recommendations_screen.dart](lib/screens/recommendations_screen.dart). |
| Respiración | No existía. | Un temporizador local alterna inhalar, sostener, exhalar y descansar; ofrece pausa y salida. Ver [lib/screens/breathing_screen.dart](lib/screens/breathing_screen.dart). |
| Ayuda y acompañamiento | No existían. | Se añadieron orientación para acompañar a una persona y pasos generales para buscar emergencias locales. Ver [lib/screens/support_someone_screen.dart](lib/screens/support_someone_screen.dart) y [lib/screens/crisis_screen.dart](lib/screens/crisis_screen.dart). |

### Diseño, recursos y dependencias

- El tema azul de tienda fue reemplazado por una paleta verde suave, fondos claros, tarjetas redondeadas y tipografía del tema de Material. La definición actual está en [lib/core_theme.dart](lib/core_theme.dart).
- Las tarjetas de catálogo y detalles fueron sustituidas por componentes de acciones reutilizables en [lib/widgets/action_card.dart](lib/widgets/action_card.dart) y una etiqueta de sección en [lib/widgets/section_label.dart](lib/widgets/section_label.dart).
- Se retiraron las fotografías y logos de plantas; las pantallas nuevas usan iconos Material incluidos con Flutter. No se agregaron imágenes ni paquetes externos.
- Se retiraron `firebase_core`, `firebase_auth`, `provider` y la configuración correspondiente. Se conservan Flutter, `flutter_test` y `flutter_lints`.
- El documento y los comentarios de consentimiento aclaran que el prototipo no guarda respuestas ni sustituye atención profesional. La pantalla de crisis no llama a emergencias por el usuario.

### Código original retirado, identificado por sus símbolos

Se eliminaron las implementaciones de `AuthRepository`, `AuthScreen`, `DefaultFirebaseOptions`, `CartProvider`, `CatalogoScreen`, `PlantCard`, `PlantDetailsScreen`, `Plant`, `plantasDemo`, `PlantRepository`, `OnboardingScreen` y el botón genérico `CustomButton`. También se quitó la implementación anterior de `HomeScreen`, que estaba dedicada al vivero; la nueva pantalla homónima está en [lib/screens/home_screen.dart](lib/screens/home_screen.dart).

El archivo de ejemplo de Vivero+ y los archivos de configuración Firebase fueron retirados, junto con la carpeta de imágenes del vivero. Los módulos de autenticación, catálogo, carrito y detalles de plantas no tienen equivalentes en Respira.

### Renombrado técnico

- La carpeta del proyecto y los módulos de IntelliJ ahora usan `Proyecto`; el nombre de paquete Flutter continúa siendo `respira` y la marca visible continúa siendo Respira.
- Android usa el identificador `com.example.proyecto` y el paquete Kotlin correspondiente.
- iOS, macOS y Linux usan el identificador `com.example.proyecto`; macOS también actualiza el nombre de producto y sus referencias de esquema.
- Web mantiene el título y nombre visibles Respira; los metadatos de instalación y colores se actualizaron.
- Se regeneraron los archivos Flutter luego de mover la carpeta para evitar rutas absolutas generadas con el nombre anterior.

### Alcance de las pruebas

La prueba automatizada cubre bienvenida, aceptación del consentimiento, elección “Abrumado/a”, recomendaciones y acceso a la pantalla de crisis. No valida persistencia, cuentas, llamadas telefónicas ni servicios externos porque esas funciones no forman parte del prototipo.
