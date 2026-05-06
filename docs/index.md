# Documentación del Proyecto Mensajeros de Película

Bienvenido a la documentación del proyecto "Mensajeros de Película". Esta guía te ayudará a navegar por toda la documentación disponible.

## 📚 Índice de Documentación

### Para Empezar

- **[Guía de Instalación y Configuración](setup.md)** - Comienza aquí
  - Requisitos previos (VS Code + extensión Wollok)
  - Instalación de Visual Studio Code y Wollok
  - Abrir el proyecto
  - Verificar la instalación
  - Troubleshooting

### Entender el Proyecto

- **[Especificación del Ejercicio](../README.md)** - Descripción completa del problema
  - Primera parte: Destinos y mensajeros
  - Segunda parte: Empresa de mensajería
  - Tercera parte: Mensajería recargada
  - Concepto de polimorfismo y colecciones

- **[Arquitectura del Sistema](architecture.md)** - Diseño y estructura
  - Visión general con diagramas
  - Módulos del sistema (destinos, mensajeros, vehículos, paquetes, empresa)
  - Patrones de diseño utilizados
  - Decisiones de diseño
  - Extensibilidad

### Desarrollo

- **[Guía para Desarrolladores](development.md)** - Cómo contribuir al proyecto
  - Flujo de trabajo
  - Convenciones de código
  - Mejores prácticas
  - Patrones comunes
  - Debugging
  - Errores comunes

- **[Guía de Testing](testing.md)** - Estrategias de prueba
  - Estructura de tests
  - Cobertura de tests (100% - 58 tests)
  - Buenas prácticas
  - Debugging de tests
  - TDD (Test-Driven Development)

### Contribución

- **[Guía de Contribución](../CONTRIBUTING.md)** - Cómo contribuir
  - Reportar bugs
  - Sugerir mejoras
  - Pull requests
  - Convenciones de código

- **[Código de Conducta](../CODE_OF_CONDUCT.md)** - Normas de la comunidad
  - Estándares de comportamiento
  - Responsabilidades
  - Aplicación

### Otros

- **[Registro de Cambios](../CHANGELOG.md)** - Historia del proyecto
  - Versiones
  - Cambios notables
  - Nuevas funcionalidades

## 🗂️ Estructura del Proyecto

```
mensajeros-de-pelicula/
├── src/                    # Código fuente
│   ├── destinos.wlk       # Puente de Brooklyn y La Matrix
│   ├── mensajeros.wlk     # Roberto, Chuck Norris y Neo
│   ├── vehiculos.wlk      # Bicicleta y Camión
│   ├── paquetes.wlk       # Paquete, Paquetito y Paqueton Viajero
│   └── empresa.wlk        # Empresa de Mensajería
├── tests/                  # Tests unitarios (100% cobertura)
│   ├── destinos.wtest     # Tests de destinos (9 tests)
│   ├── mensajeros.wtest   # Tests de mensajeros (11 tests)
│   ├── vehiculos.wtest    # Tests de vehículos (5 tests)
│   ├── paquetes.wtest     # Tests de paquetes (23 tests)
│   └── empresa.wtest      # Tests de empresa (19 tests)
├── docs/                   # Documentación (estás aquí)
│   ├── index.md           # Este archivo
│   ├── setup.md           # Guía de instalación
│   ├── architecture.md    # Arquitectura del sistema
│   ├── development.md     # Guía de desarrollo
│   └── testing.md         # Guía de testing
├── log/                    # Archivos de log (ignorados)
├── README.md              # Especificación del ejercicio
├── CONTRIBUTING.md        # Guía de contribución
├── CODE_OF_CONDUCT.md     # Código de conducta
├── LICENSE                # Licencia ISC
├── CHANGELOG.md           # Registro de cambios
└── package.json           # Configuración del proyecto
```

## 🚀 Inicio Rápido

1. **Instalar VS Code y extensión Wollok** → Ver [setup.md](setup.md)
2. **Abrir el proyecto** → Ver [setup.md](setup.md#abrir-en-vs-code)
3. **Ejecutar tests** → Ver [testing.md](testing.md#ejecutar-tests)
4. **Entender la arquitectura** → Ver [architecture.md](architecture.md)
5. **Entender el flujo del sistema** → Ver [development.md](development.md#flujo-del-sistema)

## 📖 Rutas de Aprendizaje

### Soy nuevo en el proyecto
1. Lee la [Especificación del Ejercicio](../README.md)
2. Sigue la [Guía de Instalación](setup.md)
3. Revisa la [Arquitectura](architecture.md)
4. Ejecuta los tests siguiendo [testing.md](testing.md)

### Quiero contribuir
1. Lee el [Código de Conducta](../CODE_OF_CONDUCT.md)
2. Revisa la [Guía de Contribución](../CONTRIBUTING.md)
3. Estudia la [Guía para Desarrolladores](development.md)
4. Familiarízate con [Testing](testing.md)

### Quiero extender el proyecto
1. Entiende la [Arquitectura](architecture.md)
2. Revisa los [Patrones de Diseño](architecture.md#patrones-de-diseño)
3. Lee sobre [Extensibilidad](architecture.md#extensibilidad)
4. Sigue las [Mejores Prácticas](development.md#mejores-prácticas)

## 🎯 Conceptos Clave

### Polimorfismo
- **Mensajeros**: Todos responden a `peso()` y `puedeLlamar()`
- **Destinos**: Todos responden a `dejaPasarA(unMensajero)`
- **Paquetes**: Todos responden a `precio()`, `estaPago()` y `puedeSerEntregadoPor(unMensajero)`

### Colecciones
- **Operaciones de alto nivel**: `any()`, `all()`, `filter()`, `sum()`, `max()`
- **Conjuntos vs Listas**: Uso de `#{}` para evitar duplicados en destinos

### Delegación
- Paquetes delegan a destinos la verificación de acceso
- Roberto delega a vehículos el cálculo de peso
- Empresa delega a mensajeros y paquetes las verificaciones

## 🔗 Enlaces Útiles

- [Documentación oficial de Wollok](https://www.wollok.org/)
- [Tour de Wollok](https://www.wollok.org/tour/)
- [Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Wollok Colecciones](https://www.wollok.org/documentacion/colecciones/)

## ❓ ¿Necesitas Ayuda?

- Revisa la sección de [Troubleshooting](setup.md#troubleshooting)
- Consulta los [Errores Comunes](development.md#errores-comunes)
- Lee las [Preguntas Frecuentes](development.md#preguntas-frecuentes)
- Crea un issue con la etiqueta "question"

## 📊 Estado del Proyecto

- **Cobertura de Tests**: 100% (58 tests)
- **Archivos de Código**: 5 módulos
- **Archivos de Tests**: 5 suites
- **Documentación**: Completa y actualizada

## 📝 Licencia

Este proyecto está licenciado bajo la Licencia ISC. Ver el archivo [LICENSE](../LICENSE) para más detalles.
