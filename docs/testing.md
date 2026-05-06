# Guía de Testing

## Estrategia de Testing

El proyecto utiliza el framework de testing de Wollok para garantizar la correctitud del código. Los tests están organizados por módulo, siguen el formato BDD (Given-When-Then) y aplican el principio de un solo assert por test.

**Cobertura actual:** 100% de los métodos públicos (58 tests en total)

## Estructura de Tests

```
tests/
├── destinos.wtest       # Tests de puentedebrooklyn y lamatrix (9 tests)
├── mensajeros.wtest     # Tests de roberto, chucknorris y neo (11 tests)
├── vehiculos.wtest      # Tests de bicicleta y camion (5 tests)
├── paquetes.wtest       # Tests de paquete, paquetito y paquetonviajero (23 tests)
└── empresa.wtest        # Tests de empresaDeMensajeria (19 tests)
```

**Principio:** Un archivo de test por cada archivo de implementación en `src/`.

## Ejecutar Tests

### Todos los tests
```bash
# Desde VS Code: Abre la paleta de comandos
# Ctrl+Shift+P (Windows/Linux) o Cmd+Shift+P (Mac)
# Busca: "Wollok: Run All Tests"

# O desde la terminal con Wollok CLI (si está instalado):
wollok test
```

### Test individual
```bash
# Desde VS Code: 
# - Abre el archivo .wtest
# - Click en el ícono "Run Test" que aparece sobre cada test
# - O click derecho en el archivo → "Run Wollok File"

# Desde la terminal:
wollok test tests/paquetes.wtest
```

## Formato de Tests

### Principios Fundamentales

1. **Formato BDD (Given-When-Then)**: Los nombres de los tests siguen el formato `"Given: [contexto] | When: [acción] | Then: [resultado]"`
2. **Un solo assert por test**: Cada test debe tener exactamente un assert para mantener el foco
3. **Tests independientes**: Cada test debe ser independiente y no depender del orden de ejecución
4. **Separación por responsabilidad**: Los tests están organizados en archivos separados según el objeto que prueban

### Estructura de un Test

```wollok
describe "NombreObjeto | Descripción del comportamiento" {
    test "Given: [contexto inicial] | When: [acción] | Then: [resultado esperado]" {
        // Arrange (preparar)
        objeto.configurar(parametros)
        
        // Act (actuar) - opcional, puede estar implícito
        const resultado = objeto.metodo()
        
        // Assert (verificar)
        assert.equals(valorEsperado, resultado)
    }
}
```

### Ejemplo Real

```wollok
describe "Paquete | Verificar entrega con Roberto en camión" {
    test "Given: Roberto (90kg) en camión con 1 acoplado y paquete pago al puente | When: verificamos puedeSerEntregadoPor(roberto) | Then: debería retornar true" {
        roberto.vehiculo(camion)
        camion.cantidadDeAcoplados(1)
        paquete.destino(puentedebrooklyn)
        paquete.registrarPago()
        
        assert.that(paquete.puedeSerEntregadoPor(roberto))
    }
}
```

## Tipos de Assert

### Assert.equals
Para verificar igualdad de valores:
```wollok
assert.equals(95, roberto.peso())
assert.equals(50, paquete.precio())
assert.equals(2, empresaDeMensajeria.cantidadDeMensajeros())
```

### Assert.that
Para verificar condiciones booleanas:
```wollok
assert.that(paquete.puedeSerEntregadoPor(chucknorris))
assert.that(!roberto.puedeLlamar())
assert.that(empresaDeMensajeria.esGrande())
```

Para verificar múltiples condiciones relacionadas:
```wollok
assert.that(empresaDeMensajeria.cantidadDeMensajeros() == 1 && !empresaDeMensajeria.mensajeros().contains(roberto))
```

## Cobertura de Tests

Los tests cubren todos los comportamientos del sistema:

### Tests de Destinos (9 tests)

#### Puente de Brooklyn
- Permite paso de mensajeros livianos (Roberto en bicicleta, Neo, Chuck)
- Permite paso en el límite (Roberto con 1 acoplado = 590kg)
- Rechaza mensajeros pesados (Roberto con 2 acoplados = 1090kg)

#### La Matrix
- Permite entrada a Chuck Norris (puede llamar)
- Permite entrada a Neo con crédito
- Rechaza a Neo sin crédito
- Rechaza a Roberto (no puede llamar)

### Tests de Mensajeros (11 tests)

#### Roberto
- Peso en bicicleta: 95 kg
- Peso en camión con 1 acoplado: 590 kg
- Peso en camión con 2 acoplados: 1090 kg
- No puede llamar
- Cambio de vehículo

#### Chuck Norris
- Peso: 80 kg
- Puede llamar

#### Neo
- Peso: 0 kg
- Puede llamar con crédito
- No puede llamar sin crédito
- Cambio de estado de crédito

### Tests de Vehículos (5 tests)

#### Bicicleta
- Peso: 5 kg

#### Camión
- Peso con 1 acoplado: 500 kg
- Peso con 2 acoplados: 1000 kg
- Peso con 3 acoplados: 1500 kg
- Cambio de cantidad de acoplados

### Tests de Paquetes (23 tests)

#### Paquete
- Entrega con diferentes mensajeros y destinos
- Restricciones de peso y llamada
- Restricción de pago
- Método precio()
- Método estaPago()

#### Paquetito
- Precio: $0
- Siempre está pago
- Cualquier mensajero puede llevarlo

#### Paqueton Viajero
- Precio con múltiples destinos
- Pago parcial no permite envío
- Mensajero debe pasar por todos los destinos
- Entrega exitosa con todos los requisitos
- Método estaPago()
- Método quitarDestino()
- Pago con límite de precio

### Tests de Empresa (19 tests)

#### Gestión de Mensajeros
- Contratar mensajero
- Despedir mensajero
- Despedir a todos
- Verificar si es grande (>2 mensajeros)
- Peso del último mensajero

#### Consultas
- Primer empleado puede entregar
- Puede entregar (al menos uno)
- Mensajeros que pueden llevar un paquete
- Tiene sobrepeso (promedio >500kg)

#### Envío y Facturación
- Envío exitoso
- Paquete pendiente cuando no se puede enviar
- Facturación
- Enviar múltiples paquetes
- Enviar paquete pendiente más caro
- Limpiar paquetes

## Buenas Prácticas de Testing

### 1. Nombres Descriptivos

Los nombres de los tests deben describir claramente qué se está probando usando formato BDD:

✓ **Bueno:**
```wollok
test "Given: Roberto en bicicleta | When: consultamos peso() | Then: debería retornar 95" {
    roberto.vehiculo(bicicleta)
    assert.equals(95, roberto.peso())
}
```

✗ **Malo:**
```wollok
test "test1" {
    assert.equals(95, roberto.peso())
}
```

**Razón:** Los nombres descriptivos facilitan entender qué falla cuando un test no pasa.

### 2. Arrange-Act-Assert (AAA)

Organiza tus tests en tres secciones:

```wollok
test "Given: Empresa con Chuck, paquete pago a la Matrix | When: ejecutamos enviar(paquete) | Then: paquete debería estar en paquetesEnviados" {
    // Arrange (preparar)
    empresaDeMensajeria.despedirATodos()
    empresaDeMensajeria.limpiarPaquetes()
    empresaDeMensajeria.contratar(chucknorris)
    paquete.destino(lamatrix)
    paquete.registrarPago()
    
    // Act (actuar)
    empresaDeMensajeria.enviar(paquete)
    
    // Assert (verificar)
    assert.that(empresaDeMensajeria.paquetesEnviados().contains(paquete))
}
```

**Razón:** Esta estructura hace que los tests sean más legibles y fáciles de mantener.

### 3. Tests Independientes

Cada test debe ser independiente y restaurar el estado si es necesario:

✓ **Bueno:**
```wollok
describe "EmpresaDeMensajeria | Verificar contratación" {
    fixture {
        empresaDeMensajeria.despedirATodos()
    }
    
    test "Given: Empresa vacía | When: contratamos a Roberto | Then: cantidadDeMensajeros() debería retornar 1" {
        empresaDeMensajeria.contratar(roberto)
        assert.equals(1, empresaDeMensajeria.cantidadDeMensajeros())
    }
}
```

✗ **Malo:**
```wollok
// Test que depende del estado de otro test
test "test que asume estado previo" {
    // Asume que ya hay mensajeros contratados
    assert.that(empresaDeMensajeria.cantidadDeMensajeros() > 0)
}
```

**Razón:** Tests independientes pueden ejecutarse en cualquier orden sin afectarse entre sí.

### 4. Un Solo Assert por Test

Cada test debe tener **exactamente un assert** para mantener el foco:

✓ **Bueno:**
```wollok
test "Given: Empresa con Roberto y Chuck | When: despedimos a Roberto | Then: cantidadDeMensajeros() debería retornar 1 y no contener a Roberto" {
    empresaDeMensajeria.contratar(roberto)
    empresaDeMensajeria.contratar(chucknorris)
    empresaDeMensajeria.despedir(roberto)
    
    assert.that(empresaDeMensajeria.cantidadDeMensajeros() == 1 && !empresaDeMensajeria.mensajeros().contains(roberto))
}
```

✗ **Malo:**
```wollok
test "Given: Empresa con Roberto y Chuck | When: despedimos a Roberto | Then: debería actualizar estado" {
    empresaDeMensajeria.contratar(roberto)
    empresaDeMensajeria.contratar(chucknorris)
    empresaDeMensajeria.despedir(roberto)
    
    assert.equals(1, empresaDeMensajeria.cantidadDeMensajeros())  // ❌ Primer assert
    assert.that(!empresaDeMensajeria.mensajeros().contains(roberto))  // ❌ Segundo assert
}
```

**Excepción:** Usar `assert.that` con `&&` para condiciones relacionadas que deben verificarse juntas.

**Razón:** Un solo assert por test facilita identificar exactamente qué falló.

### 5. Casos Límite

Siempre prueba casos límite:

✓ **Bueno:**
```wollok
test "Given: Roberto en camión con 2 acoplados (1090kg) | When: consultamos puentedebrooklyn.dejaPasarA(roberto) | Then: debería retornar false" {
    roberto.vehiculo(camion)
    camion.cantidadDeAcoplados(2)
    
    assert.that(!puentedebrooklyn.dejaPasarA(roberto))
}

test "Given: Neo (0kg) | When: consultamos puentedebrooklyn.dejaPasarA(neo) | Then: debería retornar true" {
    assert.that(puentedebrooklyn.dejaPasarA(neo))
}
```

**Razón:** Los casos límite suelen revelar bugs que no aparecen en casos normales.

## Debugging de Tests

### Test Falla Inesperadamente

1. **Lee el mensaje de error:**
   ```
   Expected: true
   But was: false
   ```

2. **Verifica el estado:**
   ```wollok
   test "debug ejemplo" {
       console.println("Peso de Roberto: " + roberto.peso())
       console.println("Puede llamar: " + roberto.puedeLlamar())
       console.println("Destino: " + paquete.destino())
       console.println("Está pago: " + paquete.estaPago())
       assert.that(paquete.puedeSerEntregadoPor(roberto))
   }
   ```

3. **Simplifica el test:**
   - Reduce el test al mínimo necesario
   - Verifica una cosa a la vez
   - Aísla el problema

### Test Pasa Pero No Debería

- Verifica que estás usando `assert.equals()` o `assert.that()` correctamente
- Asegúrate de que el test realmente ejecuta la lógica esperada
- Revisa que no haya typos en los nombres de métodos

## Agregar Nuevos Tests

Cuando agregues nueva funcionalidad, sigue estos pasos:

1. **Escribe el test primero (TDD):**
   ```wollok
   test "Given: nuevo mensajero | When: consultamos peso() | Then: debería retornar peso esperado" {
       assert.equals(pesoEsperado, nuevoMensajero.peso())
   }
   ```

2. **Implementa la funcionalidad mínima:**
   - Haz que el test pase

3. **Refactoriza:**
   - Mejora el código manteniendo los tests en verde

4. **Agrega más tests:**
   - Casos límite
   - Casos de error
   - Diferentes escenarios

## Verificación de Polimorfismo

Los tests deben verificar que todos los objetos responden al mismo mensaje:

```wollok
// Todos los mensajeros responden a peso()
test "Given: Roberto en bicicleta | When: consultamos peso() | Then: debería retornar 95" {
    roberto.vehiculo(bicicleta)
    assert.equals(95, roberto.peso())
}

test "Given: Chuck Norris | When: consultamos peso() | Then: debería retornar 80" {
    assert.equals(80, chucknorris.peso())
}

test "Given: Neo | When: consultamos peso() | Then: debería retornar 0" {
    assert.equals(0, neo.peso())
}
```

**Propósito:** Verificar que todos los objetos implementan la misma interfaz polimórfica.

## Cálculos de Referencia

Para verificar tests, usa estos valores de referencia:

### Peso de Mensajeros
```
Roberto en bicicleta: 90 + 5 = 95 kg
Roberto en camión (1 acoplado): 90 + 500 = 590 kg
Roberto en camión (2 acoplados): 90 + 1000 = 1090 kg
Chuck Norris: 80 kg
Neo: 0 kg
```

### Precios de Paquetes
```
Paquete: $50
Paquetito: $0
Paqueton con 1 destino: $100
Paqueton con 2 destinos: $200
```

### Límites de Destinos
```
Puente de Brooklyn: peso <= 1000 kg
La Matrix: puedeLlamar() == true
```

### Sobrepeso de Empresa
```
Promedio > 500 kg → tiene sobrepeso

Ejemplo:
Chuck (80kg) + Neo (0kg) + Roberto en bici (95kg)
Promedio: (80 + 0 + 95) / 3 = 58.33 kg → NO tiene sobrepeso

Roberto en camión con 2 acoplados (1090kg)
Promedio: 1090 / 1 = 1090 kg → SÍ tiene sobrepeso
```

## Ejemplos Completos

### Ejemplo 1: Test Simple

```wollok
describe "Bicicleta | Verificar peso" {
    test "Given: Bicicleta | When: consultamos peso() | Then: debería retornar 5" {
        assert.equals(5, bicicleta.peso())
    }
}
```

### Ejemplo 2: Test con Setup

```wollok
describe "Paquetonviajero | Verificar precio con múltiples destinos" {
    test "Given: Paquetonviajero con 2 destinos distintos | When: consultamos precio() | Then: debería retornar 200" {
        paquetonviajero.limpiarDestinos()
        paquetonviajero.limpiarPago()
        paquetonviajero.agregarDestino(lamatrix)
        paquetonviajero.agregarDestino(puentedebrooklyn)
        
        assert.equals(200, paquetonviajero.precio())
    }
}
```

### Ejemplo 3: Test con Fixture

```wollok
describe "EmpresaDeMensajeria | Verificar contratación de mensajero" {
    fixture {
        empresaDeMensajeria.despedirATodos()
    }
    
    test "Given: Empresa vacía | When: contratamos a Roberto | Then: cantidadDeMensajeros() debería retornar 1" {
        empresaDeMensajeria.contratar(roberto)
        
        assert.equals(1, empresaDeMensajeria.cantidadDeMensajeros())
    }
}
```

## Casos Límite Importantes

### Peso Cero
```wollok
test "Given: Neo (0kg) | When: consultamos peso() | Then: debería retornar 0" {
    assert.equals(0, neo.peso())
}
```

### Colecciones Vacías
```wollok
test "Given: Empresa sin paquetes pendientes | When: ejecutamos enviarPaquetePendienteMasCaro() | Then: no debería generar error" {
    empresaDeMensajeria.despedirATodos()
    empresaDeMensajeria.limpiarPaquetes()
    empresaDeMensajeria.contratar(chucknorris)
    empresaDeMensajeria.enviarPaquetePendienteMasCaro()
    
    assert.that(empresaDeMensajeria.paquetesPendientes().isEmpty())
}
```

### Valores en el Límite
```wollok
test "Given: Roberto en camión con 1 acoplado (590kg) | When: consultamos dejaPasarA(roberto) | Then: debería retornar true" {
    roberto.vehiculo(camion)
    camion.cantidadDeAcoplados(1)
    
    assert.that(puentedebrooklyn.dejaPasarA(roberto))
}
```

## Recursos Adicionales

- [Documentación oficial de Wollok Testing](https://www.wollok.org/documentacion/testing/)
- [Guía de TDD](https://www.wollok.org/documentacion/tdd/)
- Ver [architecture.md](architecture.md) para entender la estructura del código
- Ver [setup.md](setup.md) para instrucciones de instalación
- Ver [README.md](../README.md) para la especificación completa del problema
