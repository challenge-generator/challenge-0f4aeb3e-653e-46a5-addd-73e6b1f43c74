# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Optimización de rendimiento en aplicaciones móviles**.

| | |
|---|---|
| Tema | técnicas básicas de medición de performance en apps |
| Nivel | advanced-l1 |
| Chapter | Móvil |
| Especialidad | Flutter |
| Stack | Dart 3.6 / Flutter 3.27 |
| Patron arquitectonico | clean_architecture_mvvm |
| Tiempo estimado | 1 semana |

## Receta del stack

Esqueleto obligatorio:

- `pubspec.yaml en la raiz`
- `lib/main.dart con runApp`
- `lib/domain con entidades y repositorios abstractos`
- `lib/data con las implementaciones y el cliente Dio`
- `lib/presentation con screens y blocs/notifiers`

Dependencias:

- flutter 3.27.0
- provider 6.1.2
- dio 5.7.0
- cached_network_image 3.4.1
- shared_preferences 2.3.3
- flutter_test n/a
- mockito 5.4.4
- build_runner 2.4.13

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `flutter pub get && flutter analyze` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `flutter pub get && flutter analyze` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Identificación de problemas de rendimiento**: Documento que detalla los problemas de rendimiento detectados.
- **Fase 2 — Optimización del rendimiento**: Aplicación optimizada con mejoras de rendimiento implementadas.
- **Fase 3 — Validación del rendimiento mejorado**: Reporte de pruebas de rendimiento que valida las mejoras implementadas.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

### 1. Referencias colgando (4)

Salieron de un analisis estatico del codigo que SI esta en el repo. Cada una rompe la compilacion:

- [ ] `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.updateCartItem`
      Se invoca `updateCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.addCartItem`
      Se invoca `addCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/domain/usecases/add_to_cart_usecase.dart` — `CartRepository.removeCartItem`
      Se invoca `removeCartItem` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- [ ] `lib/presentation/viewmodels/cart_viewmodel.dart` — `CartRepository.updateQuantity`
      Se invoca `updateQuantity` sobre `CartRepository`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

### Presentes (26)

- `pubspec.yaml`
- `lib/main.dart`
- `lib/core/constants/app_constants.dart`
- `lib/core/utils/performance_monitor.dart`
- `lib/domain/entities/product.dart`
- `lib/domain/entities/cart_item.dart`
- `lib/domain/repositories/product_repository.dart`
- `lib/domain/repositories/cart_repository.dart`
- `lib/domain/usecases/get_products_usecase.dart`
- `lib/domain/usecases/add_to_cart_usecase.dart`
- `lib/data/models/product_model.dart`
- `lib/data/datasources/product_remote_datasource.dart`
- `lib/data/datasources/local_cache_datasource.dart`
- `lib/data/repositories/product_repository_impl.dart`
- `lib/data/repositories/cart_repository_impl.dart`
- `android/app/src/main/AndroidManifest.xml`
- `lib/presentation/screens/product_list_screen.dart`
- `lib/presentation/screens/product_detail_screen.dart`
- `lib/presentation/screens/cart_screen.dart`
- `lib/presentation/viewmodels/product_viewmodel.dart`
- `lib/presentation/viewmodels/cart_viewmodel.dart`
- `lib/presentation/widgets/product_card.dart`
- `lib/presentation/widgets/optimized_image.dart`
- `test/performance/performance_baseline_test.dart`
- `test/performance/memory_test.dart`
- `test/performance/rendering_test.dart`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `lib/domain/entities`
- `lib/domain/repositories`
- `lib/domain/usecases`
- `lib/data/datasources`
- `lib/data/repositories`
- `lib/data/models`
- `lib/presentation/screens`
- `lib/presentation/viewmodels`
- `lib/presentation/widgets`
- `lib/core/constants`
- `lib/core/utils`
- `test/performance`

## Verificacion

```bash
flutter pub get && flutter analyze
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **clean_architecture_mvvm**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Advanced
- Brecha que el reto ataca: Interpreta las herramientas para optimización de rendimiento: uso de cpu, memoria, red, almacenamiento. Evalúa las causas principales de problemas de performance: bloqueos de desplazamiento, latencias de inicio y transiciones, ineficiencias energéticas
- Mision: Desarrollador experimentado trabajando en aplicaciones mobile de alto rendimiento

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
