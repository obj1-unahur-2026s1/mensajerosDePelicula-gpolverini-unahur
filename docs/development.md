# Guía para Desarrolladores

## Introducción

Esta guía está diseñada para ayudar a desarrolladores que quieran contribuir o extender el proyecto "Mensajeros de Película". Aquí encontrarás información sobre el flujo de trabajo, convenciones de código y mejores prácticas.

## Configuración del Entorno de Desarrollo

### Requisitos
- Visual Studio Code con extensión de Wollok
- Wollok 4.2.3+
- Git

### Configuración Inicial
```bash
# Clonar el repositorio
git clone <url-del-repositorio>
cd mensajeros-de-pelicula

# Abrir en VS Code
code .
```

Ver [setup.md](setup.md) para instrucciones detalladas.

## Flujo de Trabajo

### 1. Antes de Empezar

1. **Actualiza tu rama local:**
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Crea una nueva rama:**
   ```bash
   git checkout -b feature/nombre-descriptivo
   # o
   git checkout -b fix/nombre-del-bug
   ```

### 2. Durante el Desarrollo

1. **Escribe tests primero (TDD):**
   ```wollok
   describe "Paquete | Nueva funcionalidad" {
       test "Given: [contexto] | When: [acción] | Then: [resultado]" {
           // Test que falla
           assert.equals(valorEsperado, paquete.nuevoMetodo())
       }
   }
   ```

2. **Implementa la funcionalidad:**
   ```wollok
   object paquete {
       method nuevoMetodo() {
           // Implementación mínima para pasar el test
       }
   }
   ```

3. **Ejecuta los tests frecuentemente:**
   - Después de cada cambio significativo
   - Antes de hacer commit

4. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde
   - Elimina duplicación
   - Mejora nombres de variables/métodos

### 3. Antes de Hacer Commit

1. **Ejecuta TODOS los tests:**
   - Desde VS Code: Ctrl+Shift+P → "Wollok: Run All Tests"
   - O desde terminal: `wollok test` (si tienes Wollok CLI)

2. **Verifica que no haya errores de compilación:**
   - Revisa el panel "Problems" en VS Code (Ctrl+Shift+M)

3. **Revisa tus cambios:**
   ```bash
   git status
   git diff
   ```

### 4. Hacer Commit

```bash
# Agrega los archivos modificados
git add src/archivo.wlk tests/archivo.wtest

# Commit con mensaje descriptivo
git commit -m "Agrega nuevo mensajero Deadpool

- Implementa objeto deadpool con peso y capacidad de llamar
- Agrega tests para diferentes escenarios
- Fixes #123"
```

### 5. Push y Pull Request

```bash
# Push a tu rama
git push origin feature/nombre-descriptivo

# Crea un Pull Request en GitHub/GitLab
# Describe los cambios y referencia issues relacionados
```

## Convenciones de Código

### Nomenclatura

#### Objetos
```wollok
// Objetos singleton: camelCase
object roberto { }
object chucknorris { }
object neo { }
object paquete { }
object empresaDeMensajeria { }
```

#### Métodos
```wollok
// Métodos: camelCase
method peso() { }
method puedeLlamar() { }
method puedeSerEntregadoPor(unMensajero) { }
method dejaPasarA(unMensajero) { }
```

#### Variables
```wollok
// Variables: camelCase
var tieneCredito = false
var importeAbonado = 0
const mensajeros = []
const destinos = #{}
```

### Estilo de Código

#### Indentación
- Usa **4 espacios** (no tabs)
- VS Code con la extensión de Wollok lo configura automáticamente

#### Llaves
```wollok
// ✓ Bueno: llave de apertura en la misma línea
method ejemplo() {
    // código
}

// ✗ Malo: llave de apertura en nueva línea
method ejemplo()
{
    // código
}
```

#### Espacios
```wollok
// ✓ Bueno: espacios alrededor de operadores
method peso() = 90 + vehiculo.peso()

// ✗ Malo: sin espacios
method peso()=90+vehiculo.peso()

// ✓ Bueno: espacio después de comas
method enviar(unPaquete)

// ✗ Malo: sin espacios
method enviar(unPaquete)
```

#### Líneas en Blanco
```wollok
object roberto {
    // Una línea en blanco entre métodos
    method peso() {
        // código
    }
    
    method puedeLlamar() {
        // código
    }
}
```

### Comentarios

#### Cuándo Comentar
```wollok
// ✓ Bueno: comentar lógica compleja o no obvia
// Limita el pago al precio total
method registrarPago(importe) {
    importeAbonado = (importeAbonado + importe).min(self.precio())
}

// ✗ Malo: comentar lo obvio
method peso() {
    return 80  // retorna 80
}
```

#### Comentarios TODO
```wollok
// TODO: Implementar validación de peso negativo
// FIXME: Este método no maneja el caso de lista vacía
// HACK: Solución temporal hasta refactorizar
```

## Mejores Prácticas

### 1. Principio de Responsabilidad Única
Cada objeto debe tener una sola responsabilidad:

```wollok
// ✓ Bueno: cada objeto tiene una responsabilidad clara
object paquete {
    // Responsabilidad: gestionar estado de pago y verificar entrega
}

object puentedebrooklyn {
    // Responsabilidad: verificar si un mensajero puede pasar
}

// ✗ Malo: objeto con múltiples responsabilidades
object sistema {
    // Gestiona paquetes, mensajeros, destinos y empresa
}
```

### 2. Encapsulamiento
No expongas detalles de implementación:

```wollok
// ✓ Bueno: encapsula el estado interno
object neo {
    var tieneCredito = false  // privado
    
    method cargarCredito() {
        tieneCredito = true
    }
    
    method puedeLlamar() = tieneCredito
}

// ✗ Malo: expone todo con property
object neo {
    var property tieneCredito = false  // No debería ser público
}
```

### 3. Polimorfismo
Aprovecha el polimorfismo de Wollok:

```wollok
// ✓ Bueno: todos los mensajeros responden a la misma interfaz
empresaDeMensajeria.contratar(roberto)
empresaDeMensajeria.contratar(chucknorris)
empresaDeMensajeria.contratar(neo)

// Todos responden a peso() y puedeLlamar()
empresaDeMensajeria.tieneSobrepeso()

// ✗ Malo: usar condicionales para tipos
method tieneSobrepeso() {
    if (mensajero == roberto) return roberto.peso() > 500
    else if (mensajero == chucknorris) return chucknorris.peso() > 500
    // ...
}
```

### 4. Uso de Colecciones
Usa operaciones de alto nivel:

```wollok
// ✓ Bueno: usa operaciones de colecciones
method puedeEntregar(unPaquete) = 
    mensajeros.any({m => unPaquete.puedeSerEntregadoPor(m)})

method mensajerosQuePuedenLlevar(unPaquete) = 
    mensajeros.filter({m => unPaquete.puedeSerEntregadoPor(m)})

// ✗ Malo: usar loops manuales
method puedeEntregar(unPaquete) {
    var puede = false
    mensajeros.forEach({m => 
        if (unPaquete.puedeSerEntregadoPor(m)) {
            puede = true
        }
    })
    return puede
}
```

### 5. Nombres Descriptivos
```wollok
// ✓ Bueno: nombres que expresan intención
method puedeSerEntregadoPor(unMensajero) = 
    destino.dejaPasarA(unMensajero) && estaPago

// ✗ Malo: nombres crípticos
method check(m) = d.ok(m) && p
```

## Patrones Comunes

### Pattern: Métodos de Consulta
```wollok
// Métodos que retornan información sin cambiar estado
method peso() = 80
method precio() = destinos.size() * 100
method cantidadDeMensajeros() = mensajeros.size()
method facturacion() = paquetesEnviados.sum({p => p.precio()})
```

### Pattern: Métodos de Acción
```wollok
// Métodos que cambian el estado del objeto
method contratar(unMensajero) { 
    mensajeros.add(unMensajero)
}

method registrarPago(importe) {
    importeAbonado = (importeAbonado + importe).min(self.precio())
}
```

### Pattern: Delegation
```wollok
// Delegar a componentes
object paquete {
    method puedeSerEntregadoPor(unMensajero) = 
        destino.dejaPasarA(unMensajero) && estaPago
        // Delega la verificación de acceso al destino
}

object roberto {
    method peso() = 90 + vehiculo.peso()
        // Delega el cálculo de peso al vehículo
}
```

### Pattern: Collection Operations
```wollok
// Usar operaciones de alto nivel
method puedeEntregar(unPaquete) = 
    mensajeros.any({m => unPaquete.puedeSerEntregadoPor(m)})

method tieneSobrepeso() = 
    mensajeros.sum({m => m.peso()}) / mensajeros.size() > 500

method mensajerosQuePuedenLlevar(unPaquete) = 
    mensajeros.filter({m => unPaquete.puedeSerEntregadoPor(m)})
```

## Flujo del Sistema

El flujo típico del sistema es:

1. **Configuración inicial:**
   - La empresa contrata mensajeros
   - Los paquetes se configuran con destinos y pagos

2. **Envío de paquetes:**
   - La empresa intenta enviar un paquete
   - Verifica si algún mensajero puede entregarlo
   - Si puede, lo agrega a paquetesEnviados
   - Si no puede, lo agrega a paquetesPendientes

3. **Consultas:**
   - Facturación: suma de precios de paquetes enviados
   - Sobrepeso: promedio de peso de mensajeros
   - Mensajeros disponibles: filtro de mensajeros que pueden llevar un paquete

4. **Gestión:**
   - Contratar/despedir mensajeros
   - Enviar paquetes pendientes
   - Limpiar listas

## Testing

### Test-Driven Development (TDD)

1. **Red:** Escribe un test que falle
2. **Green:** Implementa lo mínimo para que pase
3. **Refactor:** Mejora el código

```wollok
// 1. RED: Test que falla
describe "Paquete | Nueva funcionalidad" {
    test "Given: [contexto] | When: [acción] | Then: [resultado]" {
        assert.equals(valorEsperado, paquete.nuevoMetodo())
    }
}

// 2. GREEN: Implementación mínima
object paquete {
    method nuevoMetodo() = valorEsperado
}

// 3. REFACTOR: (si es necesario)
```

Ver [testing.md](testing.md) para más detalles.

## Debugging

### Técnicas de Debugging

#### 1. Console.println()
```wollok
method enviar(unPaquete) {
    console.println("Intentando enviar: " + unPaquete)
    console.println("Puede entregar: " + self.puedeEntregar(unPaquete))
    
    if (self.puedeEntregar(unPaquete)) {
        paquetesEnviados.add(unPaquete)
    } else {
        paquetesPendientes.add(unPaquete)
    }
}
```

#### 2. Breakpoints
- Click en el margen izquierdo del editor en VS Code
- Ejecuta en modo Debug (F5)
- Inspecciona variables en el panel de Debug

#### 3. Tests Específicos
```wollok
test "debug: verificar envío de paquete" {
    empresaDeMensajeria.contratar(chucknorris)
    paquete.destino(lamatrix)
    paquete.registrarPago()
    
    console.println("Chuck puede llamar: " + chucknorris.puedeLlamar())
    console.println("Paquete está pago: " + paquete.estaPago())
    console.println("Puede entregar: " + empresaDeMensajeria.puedeEntregar(paquete))
    
    empresaDeMensajeria.enviar(paquete)
    assert.that(empresaDeMensajeria.paquetesEnviados().contains(paquete))
}
```

## Errores Comunes

### 1. Olvidar el `self`
```wollok
// ✓ Bueno (cuando se necesita)
object paquetonviajero {
    method puedeSerEntregadoPor(unMensajero) {
        return destinos.all({d => d.dejaPasarA(unMensajero)}) && self.estaPago()
        // Necesita self para llamar a otro método
    }
}

// ✗ Malo: olvidar self cuando se necesita
method puedeSerEntregadoPor(unMensajero) {
    return destinos.all({d => d.dejaPasarA(unMensajero)}) && estaPago()
    // Error: estaPago no está definido
}
```

### 2. No Inicializar Variables
```wollok
// ✗ Malo
object paquete {
    var estaPago  // Error: no inicializada
}

// ✓ Bueno
object paquete {
    var estaPago = false
}
```

### 3. Confundir any() y all()
```wollok
// ✗ Malo: usa any() cuando debería ser all()
method puedeSerEntregadoPor(unMensajero) = 
    destinos.any({d => d.dejaPasarA(unMensajero)})
    // Solo necesita pasar por uno

// ✓ Bueno: usa all() para verificar todos
method puedeSerEntregadoPor(unMensajero) = 
    destinos.all({d => d.dejaPasarA(unMensajero)})
    // Debe pasar por todos
```

### 4. Usar listas en lugar de conjuntos
```wollok
// ✗ Malo: permite duplicados
const destinos = []

// ✓ Bueno: no permite duplicados
const destinos = #{}
```

## Preguntas Frecuentes

### ¿Cómo agrego un nuevo mensajero?

1. Crea un nuevo objeto en `src/mensajeros.wlk`
2. Implementa los métodos `peso()` y `puedeLlamar()`
3. Agrega tests en `tests/mensajeros.wtest`
4. Úsalo en `empresaDeMensajeria.contratar(nuevoMensajero)`

Ejemplo:
```wollok
object deadpool {
    method peso() = 90
    method puedeLlamar() = true
}
```

### ¿Cómo agrego un nuevo destino?

1. Crea un nuevo objeto en `src/destinos.wlk`
2. Implementa el método `dejaPasarA(unMensajero)`
3. Agrega tests en `tests/destinos.wtest`
4. Úsalo en `paquete.destino(nuevoDestino)`

Ejemplo:
```wollok
object aeropuerto {
    method dejaPasarA(unMensajero) = 
        unMensajero.puedeLlamar() && unMensajero.peso() <= 500
}
```

### ¿Cómo agrego un nuevo tipo de paquete?

1. Crea un nuevo objeto en `src/paquetes.wlk`
2. Implementa los métodos `precio()`, `estaPago()` y `puedeSerEntregadoPor(unMensajero)`
3. Agrega tests en `tests/paquetes.wtest`
4. Úsalo en `empresaDeMensajeria.enviar(nuevoPaquete)`

### ¿Puedo modificar el README.md?

No, el README.md contiene la especificación del ejercicio y no debe modificarse.

### ¿Dónde reporto bugs?

Crea un issue en el repositorio con:
- Descripción del bug
- Pasos para reproducir
- Comportamiento esperado vs actual
- Versión de Wollok

## Contacto

Si tienes preguntas o necesitas ayuda:
- Crea un issue con la etiqueta "question"
- Revisa la [Guía de Contribución](../CONTRIBUTING.md)
- Consulta el [Código de Conducta](../CODE_OF_CONDUCT.md)

## Recursos Adicionales

- Ver [architecture.md](architecture.md) para entender el diseño del sistema
- Ver [testing.md](testing.md) para estrategias de testing
- Ver [setup.md](setup.md) para instrucciones de instalación
- Ver [README.md](../README.md) para la especificación completa
