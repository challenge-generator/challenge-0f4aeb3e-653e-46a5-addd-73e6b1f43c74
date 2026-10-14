# Optimización de rendimiento en aplicaciones móviles

Como desarrollador de aplicaciones móviles, debes identificar y solucionar problemas de rendimiento en una aplicación Flutter existente. La aplicación, utilizada por un minorista en línea, experimenta problemas de rendimiento como bloqueos de desplazamiento, latencias de inicio y transiciones, e ineficiencias energéticas. Tu objetivo es evaluar y mejorar el uso de CPU, memoria, red y almacenamiento para garantizar un rendimiento óptimo.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | técnicas básicas de medición de performance en apps |
| **Nivel** | advanced-l1 |
| **Tipo** | practical |
| **Tiempo estimado** | 1 semana |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Identificación de problemas de rendimiento

**Objetivo:** Detectar y documentar los principales problemas de rendimiento en la aplicación.

**Tiempo estimado:** 2 días

**Instrucciones:**

- Analiza la aplicación para identificar bloqueos de desplazamiento, latencias de inicio y transiciones, e ineficiencias energéticas.
- Documenta cada problema detectado, incluyendo su impacto en el rendimiento y posibles causas.

**Entregable:** Documento que detalla los problemas de rendimiento detectados.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de herramientas de profiling para identificar cuellos de botella.
- Evalúa el impacto de cada problema en la experiencia del usuario.

</details>

### Fase 2: Optimización del rendimiento

**Objetivo:** Implementar mejoras para solucionar los problemas de rendimiento identificados.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Propón y aplica soluciones para cada problema de rendimiento documentado en la fase anterior.
- Verifica que las mejoras implementadas no introduzcan nuevos problemas de rendimiento.

**Entregable:** Aplicación optimizada con mejoras de rendimiento implementadas.

<details>
<summary>Pistas de conocimiento</summary>

- Considera técnicas como la optimización de imágenes, la reducción de llamadas a la red y la mejora de la gestión de memoria.
- Evalúa el impacto de las mejoras en el rendimiento general de la aplicación.

</details>

### Fase 3: Validación del rendimiento mejorado

**Objetivo:** Verificar que las mejoras implementadas han resuelto los problemas de rendimiento y no han introducido nuevos problemas.

**Tiempo estimado:** 2 días

**Instrucciones:**

- Realiza pruebas de rendimiento para validar que las mejoras implementadas han resuelto los problemas de rendimiento identificados.
- Documenta los resultados de las pruebas y cualquier problema adicional detectado.

**Entregable:** Reporte de pruebas de rendimiento que valida las mejoras implementadas.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de benchmarking para medir el rendimiento antes y después de las mejoras.
- Evalúa el impacto de las mejoras en la experiencia del usuario.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Cuáles son las principales métricas de rendimiento en aplicaciones móviles?
- **paraQueSirve**: ¿Por qué es importante medir y optimizar el rendimiento en aplicaciones móviles?
- **comoSeUsa**: ¿Cómo se pueden utilizar herramientas de profiling para identificar problemas de rendimiento?
- **erroresComunes**: ¿Cuáles son los errores comunes al optimizar el rendimiento en aplicaciones móviles?
- **queDecisionesImplica**: ¿Qué decisiones debes tomar al priorizar y solucionar problemas de rendimiento en aplicaciones móviles?

## Criterios de Evaluacion

- Identificar correctamente los problemas de rendimiento en la aplicación.
- Implementar mejoras efectivas para solucionar los problemas de rendimiento.
- Validar que las mejoras implementadas han resuelto los problemas de rendimiento y no han introducido nuevos problemas.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
flutter pub get && flutter analyze
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
