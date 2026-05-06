# Guía de Instalación y Configuración

## Requisitos Previos

- **Visual Studio Code** con la extensión de Wollok instalada
- **Wollok** versión 4.2.3 o superior
- **Git** (opcional, para clonar el repositorio)

## Instalación

### 1. Instalar Visual Studio Code y Wollok

1. **Descarga e instala Visual Studio Code:**
   - [https://code.visualstudio.com/](https://code.visualstudio.com/)

2. **Instala la extensión de Wollok:**
   - Abre VS Code
   - Ve a Extensions (Ctrl+Shift+X o Cmd+Shift+X)
   - Busca "Wollok"
   - Instala la extensión oficial de Wollok

### 2. Clonar o Descargar el Proyecto

**Opción A: Con Git**
```bash
git clone <url-del-repositorio>
cd mensajeros-de-pelicula
```

**Opción B: Descarga directa**
- Descarga el archivo ZIP del proyecto
- Extrae el contenido en tu carpeta de trabajo

### 3. Abrir en VS Code

1. Abre Visual Studio Code
2. Ve a `File` → `Open Folder...`
3. Selecciona la carpeta del proyecto "mensajeros-de-pelicula"
4. VS Code detectará automáticamente los archivos de Wollok

## Estructura del Proyecto

```
mensajeros-de-pelicula/
├── src/                    # Código fuente
│   ├── destinos.wlk       # Puente de Brooklyn y La Matrix
│   ├── mensajeros.wlk     # Roberto, Chuck Norris y Neo
│   ├── vehiculos.wlk      # Bicicleta y Camión
│   ├── paquetes.wlk       # Paquete, Paquetito y Paqueton Viajero
│   └── empresa.wlk        # Empresa de Mensajería
├── tests/                  # Tests unitarios
│   ├── destinos.wtest     # Tests de destinos
│   ├── mensajeros.wtest   # Tests de mensajeros
│   ├── vehiculos.wtest    # Tests de vehículos
│   ├── paquetes.wtest     # Tests de paquetes
│   └── empresa.wtest      # Tests de empresa
├── docs/                   # Documentación
│   ├── index.md           # Índice de documentación
│   ├── setup.md           # Esta guía
│   ├── architecture.md    # Arquitectura del sistema
│   ├── development.md     # Guía de desarrollo
│   └── testing.md         # Guía de testing
├── log/                    # Archivos de log (ignorados)
├── README.md              # Especificación del ejercicio
├── CONTRIBUTING.md        # Guía de contribución
├── CODE_OF_CONDUCT.md     # Código de conducta
├── LICENSE                # Licencia del proyecto
├── CHANGELOG.md           # Registro de cambios
└── package.json           # Configuración del proyecto
```

## Ejecutar el Proyecto

### Ejecutar Tests Individuales

1. Abre cualquier archivo `.wtest` en el editor
2. Haz clic en el ícono "Run Test" que aparece sobre cada test
3. O click derecho en el archivo → "Run Wollok File"

### Ejecutar Todos los Tests

**Desde VS Code:**
- Abre la paleta de comandos (Ctrl+Shift+P o Cmd+Shift+P)
- Busca "Wollok: Run All Tests"
- Ejecuta el comando

**Desde la terminal (si tienes Wollok CLI instalado):**
```bash
wollok test
```

## Verificar la Instalación

Para verificar que todo está correctamente instalado:

1. Abre `tests/destinos.wtest`
2. Ejecuta los tests
3. Deberías ver todos los tests en verde ✓

**Resultado esperado:**
```
✓ Puentedebrooklyn | Verificar restricción de peso con mensajero liviano
✓ Puentedebrooklyn | Verificar restricción de peso en el límite
✓ Puentedebrooklyn | Verificar restricción de peso excedido
✓ Puentedebrooklyn | Verificar que Neo puede pasar
✓ Puentedebrooklyn | Verificar que Chuck puede pasar
✓ Lamatrix | Verificar que Chuck puede entrar
✓ Lamatrix | Verificar que Neo con crédito puede entrar
✓ Lamatrix | Verificar que Neo sin crédito no puede entrar
✓ Lamatrix | Verificar que Roberto no puede entrar

9 tests passed
```

## Troubleshooting

### Error: "Project not found" o "Cannot resolve dependencies"

**Solución:**
1. Asegúrate de tener la extensión de Wollok instalada en VS Code
2. Recarga la ventana de VS Code (Ctrl+Shift+P → "Reload Window")
3. Verifica que el archivo `package.json` esté presente
4. Intenta ejecutar los tests nuevamente

### Los tests no se ejecutan

**Solución:**
1. Verifica que los archivos `.wtest` estén en la carpeta `tests/`
2. Asegúrate de que la extensión de Wollok esté activa
3. Revisa la consola de salida de VS Code para ver errores
4. Recarga la ventana de VS Code

### Errores de sintaxis o compilación

**Solución:**
- Revisa que todos los archivos `.wlk` estén en la carpeta `src/`
- Verifica que no haya errores de sintaxis en el código
- Asegúrate de que las importaciones sean correctas
- Revisa el panel "Problems" de VS Code (Ctrl+Shift+M)

### Error: "Cannot find module" o problemas de importación

**Solución:**
```wollok
// ✓ Bueno: importación correcta
import src.destinos.*
import src.mensajeros.*

// ✗ Malo: importación incorrecta
import destinos.*
import mensajeros.*
```

### Tests fallan inesperadamente

**Solución:**
1. Verifica que los objetos singleton estén en el estado correcto
2. Algunos tests usan fixtures para limpiar el estado
3. Ejecuta los tests individualmente para aislar el problema
4. Revisa la documentación de [testing.md](testing.md)

## Explorar el Código

### Archivos Principales

**src/destinos.wlk**
- `puentedebrooklyn` - Verifica peso ≤ 1000 kg
- `lamatrix` - Verifica capacidad de llamar

**src/mensajeros.wlk**
- `roberto` - Peso variable según vehículo, no puede llamar
- `chucknorris` - Peso 80 kg, puede llamar
- `neo` - Peso 0 kg, puede llamar si tiene crédito

**src/vehiculos.wlk**
- `bicicleta` - Peso 5 kg
- `camion` - Peso 500 kg por acoplado

**src/paquetes.wlk**
- `paquete` - Precio $50, debe estar pago
- `paquetito` - Precio $0, siempre pago
- `paquetonviajero` - Precio $100 por destino, pago parcial

**src/empresa.wlk**
- `empresaDeMensajeria` - Gestiona mensajeros y envíos

### Ejecutar Ejemplos

Puedes crear un archivo `example.wlk` para probar el código:

```wollok
import src.mensajeros.*
import src.destinos.*
import src.paquetes.*
import src.vehiculos.*
import src.empresa.*

program ejemploMensajeros {
    // Configurar mensajeros
    roberto.vehiculo(bicicleta)
    neo.cargarCredito()
    
    // Configurar empresa
    empresaDeMensajeria.contratar(roberto)
    empresaDeMensajeria.contratar(chucknorris)
    empresaDeMensajeria.contratar(neo)
    
    // Configurar paquete
    paquete.destino(lamatrix)
    paquete.registrarPago()
    
    // Enviar paquete
    empresaDeMensajeria.enviar(paquete)
    
    // Ver resultados
    console.println("Facturación: $" + empresaDeMensajeria.facturacion())
    console.println("Paquetes enviados: " + empresaDeMensajeria.paquetesEnviados().size())
}
```

## Próximos Pasos

- Lee el [README.md](../README.md) para entender la especificación del ejercicio
- Revisa [CONTRIBUTING.md](../CONTRIBUTING.md) si quieres contribuir
- Consulta [architecture.md](architecture.md) para entender el diseño del sistema
- Lee [testing.md](testing.md) para aprender sobre las estrategias de testing
- Explora [development.md](development.md) para mejores prácticas de desarrollo

## Recursos Adicionales

- [Documentación oficial de Wollok](https://www.wollok.org/)
- [Tour de Wollok](https://www.wollok.org/tour/)
- [Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Wollok Colecciones](https://www.wollok.org/documentacion/colecciones/)
