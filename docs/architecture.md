# Arquitectura del Sistema

## Visión General

El proyecto "Mensajeros de Película" es un sistema orientado a objetos que modela un servicio de mensajería con diferentes tipos de mensajeros, paquetes y destinos. El sistema está diseñado siguiendo principios de programación orientada a objetos y el paradigma de Wollok, con foco en polimorfismo, encapsulamiento y colecciones.

## Diagrama de Componentes

```
┌───────────────────────────────────────────────┐
│                   DESTINOS                    │
│  ┌──────────────┐      ┌──────────────┐       │
│  │ Puente de    │      │  La Matrix   │       │
│  │  Brooklyn    │      │              │       │
│  │ (peso≤1000)  │      │ (puedeLlamar)│       │
│  └──────────────┘      └──────────────┘       │
└───────────────────────────────────────────────┘
                         │
                         │ dejaPasarA()
                         ▼
┌───────────────────────────────────────────────┐
│                  MENSAJEROS                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐     │
│  │ Roberto  │  │  Chuck   │  │   Neo    │     │
│  │ (90kg +  │  │  Norris  │  │  (0kg)   │     │
│  │ vehículo)│  │  (80kg)  │  │          │     │
│  └──────────┘  └──────────┘  └──────────┘     │
└───────────────────────────────────────────────┘
                         │
                         │ puedeSerEntregadoPor()
                         ▼
┌───────────────────────────────────────────────┐
│                   PAQUETES                    │
│  ┌──────────┐  ┌──────────┐  ┌─────────────┐  │
│  │ Paquete  │  │Paquetito │  │  Paqueton   │  │
│  │  ($50)   │  │   ($0)   │  │   Viajero   │  │
│  └──────────┘  └──────────┘  │ ($100/dest) │  │
│                              └─────────────┘  │
└───────────────────────────────────────────────┘
                         │
                         │ enviar()
                         ▼
┌───────────────────────────────────────────────┐
│           EMPRESA DE MENSAJERÍA               │
│  - mensajeros: []                             │
│  - paquetesEnviados: []                       │
│  - paquetesPendientes: []                     │
└───────────────────────────────────────────────┘
```

## Módulos del Sistema

### 1. Destinos (`src/destinos.wlk`)

**Responsabilidad:** Modelar destinos y determinar si un mensajero puede acceder a ellos.

#### Puente de Brooklyn
**Comportamiento:**
- Deja pasar a mensajeros con peso total ≤ 1000 kg
- Método: `dejaPasarA(unMensajero)` → retorna booleano

**Ejemplo:**
```wollok
puentedebrooklyn.dejaPasarA(roberto)  // true si roberto.peso() <= 1000
```

#### La Matrix
**Comportamiento:**
- Deja entrar a mensajeros que puedan hacer llamadas
- Método: `dejaPasarA(unMensajero)` → retorna booleano

**Ejemplo:**
```wollok
lamatrix.dejaPasarA(chucknorris)  // true (Chuck siempre puede llamar)
lamatrix.dejaPasarA(roberto)      // false (Roberto no puede llamar)
```

### 2. Mensajeros (`src/mensajeros.wlk`)

**Responsabilidad:** Modelar mensajeros con diferentes características de peso y capacidad de comunicación.

#### Roberto
**Propiedades:**
- `vehiculo` - Vehículo actual (bicicleta o camión)
- Peso base: 90 kg

**Métodos:**
- `peso()` → 90 + peso del vehículo
- `puedeLlamar()` → siempre false

**Comportamiento:**
- Puede cambiar de vehículo
- Su peso total depende del vehículo

**Ejemplo:**
```wollok
roberto.vehiculo(bicicleta)
roberto.peso()  // 95 kg (90 + 5)

roberto.vehiculo(camion)
camion.cantidadDeAcoplados(2)
roberto.peso()  // 1090 kg (90 + 1000)
```

#### Chuck Norris
**Propiedades:**
- Peso fijo: 80 kg

**Métodos:**
- `peso()` → 80
- `puedeLlamar()` → siempre true

**Comportamiento:**
- Puede llamar a cualquier persona del universo
- Peso constante

**Ejemplo:**
```wollok
chucknorris.peso()         // 80
chucknorris.puedeLlamar()  // true
```

#### Neo
**Propiedades:**
- Peso: 0 kg (vuela)
- `tieneCredito` - Estado del crédito telefónico

**Métodos:**
- `peso()` → 0
- `cargarCredito()` - Activa el crédito
- `agotarCredito()` - Desactiva el crédito
- `puedeLlamar()` → depende de `tieneCredito`

**Comportamiento:**
- No pesa nada porque vuela
- Puede llamar solo si tiene crédito

**Ejemplo:**
```wollok
neo.peso()  // 0

neo.cargarCredito()
neo.puedeLlamar()  // true

neo.agotarCredito()
neo.puedeLlamar()  // false
```

### 3. Vehículos (`src/vehiculos.wlk`)

**Responsabilidad:** Modelar vehículos que afectan el peso de Roberto.

#### Bicicleta
**Métodos:**
- `peso()` → 5 kg (constante)

#### Camión
**Propiedades:**
- `cantidadDeAcoplados` - Número de acoplados

**Métodos:**
- `cantidadDeAcoplados(cantidad)` - Setter
- `peso()` → cantidadDeAcoplados × 500 kg

**Ejemplo:**
```wollok
camion.cantidadDeAcoplados(1)
camion.peso()  // 500 kg

camion.cantidadDeAcoplados(3)
camion.peso()  // 1500 kg
```

### 4. Paquetes (`src/paquetes.wlk`)

**Responsabilidad:** Modelar diferentes tipos de paquetes con distintas reglas de entrega y precios.

#### Paquete
**Propiedades:**
- `destino` - Destino del paquete
- `estaPago` - Estado de pago

**Métodos:**
- `precio()` → 50
- `registrarPago()` - Marca como pago
- `rechazarPago()` - Marca como no pago
- `estaPago()` → retorna estado de pago
- `puedeSerEntregadoPor(unMensajero)` → destino.dejaPasarA(unMensajero) && estaPago

**Ejemplo:**
```wollok
paquete.destino(lamatrix)
paquete.registrarPago()
paquete.puedeSerEntregadoPor(chucknorris)  // true
```

#### Paquetito
**Métodos:**
- `precio()` → 0 (gratis)
- `estaPago()` → siempre true
- `puedeSerEntregadoPor(unMensajero)` → siempre true

**Comportamiento:**
- Gratis y siempre está pago
- Cualquier mensajero puede llevarlo

**Ejemplo:**
```wollok
paquetito.puedeSerEntregadoPor(roberto)  // true
paquetito.precio()  // 0
```

#### Paqueton Viajero
**Propiedades:**
- `destinos` - Conjunto de destinos (Set)
- `importeAbonado` - Monto pagado hasta el momento

**Métodos:**
- `agregarDestino(unDestino)` - Agrega un destino
- `quitarDestino(unDestino)` - Quita un destino
- `limpiarDestinos()` - Vacía todos los destinos
- `precio()` → destinos.size() × 100
- `registrarPago(importe)` - Registra un pago parcial (con límite al precio total)
- `limpiarPago()` - Resetea el pago
- `estaPago()` → precio() == importeAbonado
- `puedeSerEntregadoPor(unMensajero)` → todos los destinos permiten al mensajero && estaPago()

**Comportamiento:**
- Precio dinámico: $100 por cada destino
- Permite pago parcial
- El mensajero debe poder pasar por TODOS los destinos

**Ejemplo:**
```wollok
paquetonviajero.agregarDestino(lamatrix)
paquetonviajero.agregarDestino(puentedebrooklyn)
paquetonviajero.precio()  // 200

paquetonviajero.registrarPago(100)
paquetonviajero.estaPago()  // false

paquetonviajero.registrarPago(100)
paquetonviajero.estaPago()  // true

// Chuck puede pasar por ambos destinos
paquetonviajero.puedeSerEntregadoPor(chucknorris)  // true

// Roberto no puede pasar por la Matrix
paquetonviajero.puedeSerEntregadoPor(roberto)  // false
```

### 5. Empresa de Mensajería (`src/empresa.wlk`)

**Responsabilidad:** Gestionar mensajeros, enviar paquetes y calcular facturación.

**Propiedades:**
- `mensajeros` - Lista de mensajeros contratados
- `paquetesEnviados` - Lista de paquetes enviados exitosamente
- `paquetesPendientes` - Lista de paquetes que no pudieron enviarse

**Métodos de Gestión de Mensajeros:**
- `contratar(unMensajero)` - Agrega un mensajero
- `despedir(unMensajero)` - Remueve un mensajero
- `despedirATodos()` - Vacía la lista de mensajeros
- `esGrande()` → mensajeros.size() > 2
- `cantidadDeMensajeros()` → mensajeros.size()
- `mensajeros()` → retorna la lista

**Métodos de Consulta:**
- `elPrimerEmpleadoPuedeEntregar(unPaquete)` → verifica si el primer mensajero puede entregar
- `pesoDelUltimoMensajero()` → peso del último mensajero
- `puedeEntregar(unPaquete)` → al menos un mensajero puede entregar
- `mensajerosQuePuedenLlevar(unPaquete)` → filtra mensajeros que pueden entregar
- `tieneSobrepeso()` → promedio de peso > 500 kg

**Métodos de Envío:**
- `enviar(unPaquete)` - Intenta enviar, si no puede lo agrega a pendientes
- `enviarTodos(paquetes)` - Envía una colección de paquetes
- `enviarPaquetePendienteMasCaro()` - Intenta enviar el paquete pendiente más caro

**Métodos de Facturación:**
- `facturacion()` → suma de precios de paquetes enviados
- `paquetesEnviados()` → retorna la lista
- `paquetesPendientes()` → retorna la lista
- `limpiarPaquetes()` - Vacía ambas listas

**Ejemplo:**
```wollok
empresaDeMensajeria.contratar(chucknorris)
empresaDeMensajeria.contratar(roberto)
empresaDeMensajeria.esGrande()  // false (2 mensajeros)

paquete.destino(lamatrix)
paquete.registrarPago()
empresaDeMensajeria.enviar(paquete)  // Se envía (Chuck puede)

empresaDeMensajeria.facturacion()  // 50
```

## Patrones de Diseño

### 1. Singleton Pattern

Todos los objetos son singletons (una única instancia):
- Destinos: `puentedebrooklyn`, `lamatrix`
- Mensajeros: `roberto`, `chucknorris`, `neo`
- Vehículos: `bicicleta`, `camion`
- Paquetes: `paquete`, `paquetito`, `paquetonviajero`
- Empresa: `empresaDeMensajeria`

**Ventaja:** Simplifica el modelo y evita duplicación de estado.

### 2. Polymorphism

**Destinos** responden polimórficamente a:
- `dejaPasarA(unMensajero)` - Cada destino tiene sus propias reglas

**Mensajeros** responden polimórficamente a:
- `peso()` - Cada mensajero calcula su peso de forma diferente
- `puedeLlamar()` - Cada mensajero tiene su propia capacidad

**Paquetes** responden polimórficamente a:
- `precio()` - Cada paquete tiene su propio precio
- `estaPago()` - Cada paquete determina si está pago
- `puedeSerEntregadoPor(unMensajero)` - Cada paquete tiene sus propias reglas

**Ventaja:** La empresa puede trabajar con cualquier tipo de mensajero o paquete sin modificar su lógica.

**Ejemplo:**
```wollok
// Todos los mensajeros responden a peso()
roberto.peso()      // 95 (con bicicleta)
chucknorris.peso()  // 80
neo.peso()          // 0

// Todos los paquetes responden a precio()
paquete.precio()           // 50
paquetito.precio()         // 0
paquetonviajero.precio()   // destinos.size() * 100
```

### 3. Encapsulation

**Atributos privados:**
- Estado interno de mensajeros (crédito de Neo, vehículo de Roberto)
- Estado de pago de paquetes
- Listas de la empresa

**Acceso controlado:**
- Solo a través de métodos específicos
- Getters para consulta
- Setters para modificación controlada

**Ventaja:** Control sobre cómo se modifican los atributos.

### 4. Delegation

**Paquetes delegan a destinos:**
- `paquete.puedeSerEntregadoPor()` → `destino.dejaPasarA()`

**Empresa delega a mensajeros:**
- `empresa.puedeEntregar()` → `mensajeros.any({m => paquete.puedeSerEntregadoPor(m)})`

**Roberto delega a vehículo:**
- `roberto.peso()` → `90 + vehiculo.peso()`

**Ventaja:** Separación de responsabilidades.

### 5. Collection Operations

**Uso de operaciones de alto nivel:**
- `any()` - Verificar si al menos uno cumple
- `all()` - Verificar si todos cumplen
- `filter()` - Obtener elementos que cumplen condición
- `sum()` - Sumar valores
- `max()` - Obtener máximo

**Ejemplo:**
```wollok
// any: al menos un mensajero puede entregar
empresa.puedeEntregar(paquete) = 
    mensajeros.any({m => paquete.puedeSerEntregadoPor(m)})

// all: el mensajero debe poder pasar por todos los destinos
paquetonviajero.puedeSerEntregadoPor(mensajero) = 
    destinos.all({d => d.dejaPasarA(mensajero)})

// filter: obtener mensajeros que pueden llevar el paquete
empresa.mensajerosQuePuedenLlevar(paquete) = 
    mensajeros.filter({m => paquete.puedeSerEntregadoPor(m)})

// sum: calcular facturación
empresa.facturacion() = 
    paquetesEnviados.sum({p => p.precio()})
```

## Decisiones de Diseño

### ¿Por qué usar un conjunto (Set) para destinos en paquetonviajero?

**Razón:** Un conjunto no permite duplicados, lo cual tiene sentido para destinos (no tiene sentido ir dos veces al mismo lugar).

**Alternativas:** Usar una lista permitiría duplicados.

**Tradeoffs:**
- ✓ Ventaja: No hay destinos duplicados
- ✓ Ventaja: Operaciones de conjunto (add, remove) son semánticamente correctas
- ✗ Desventaja: No se puede tener el mismo destino múltiples veces (pero esto es deseable)

### ¿Por qué paquetonviajero usa `all()` en lugar de `any()`?

**Razón:** El enunciado especifica que "el mensajero debe poder pasar por **todos** los destinos", no solo por uno.

**Ejemplo:**
```wollok
// Roberto puede pasar por el puente pero no por la Matrix
paquetonviajero.agregarDestino(puentedebrooklyn)
paquetonviajero.agregarDestino(lamatrix)
paquetonviajero.puedeSerEntregadoPor(roberto)  // false
```

### ¿Por qué registrarPago() en paquetonviajero limita el pago al precio total?

**Razón:** Evita que se pague más del precio total. El método usa `.min(self.precio())` para limitar el importe abonado.

**Ejemplo:**
```wollok
paquetonviajero.agregarDestino(lamatrix)  // precio = 100
paquetonviajero.registrarPago(200)  // solo se registran 100
paquetonviajero.estaPago()  // true
```

### ¿Por qué la empresa agrega a pendientes si no puede enviar?

**Razón:** Permite llevar un registro de paquetes que no pudieron enviarse para intentar enviarlos más tarde (por ejemplo, cuando se contrate un nuevo mensajero).

## Extensibilidad

El sistema está diseñado para ser fácilmente extensible:

### Agregar nuevos mensajeros
```wollok
object maria {
    method peso() = 65
    method puedeLlamar() = true
}

// Uso
empresaDeMensajeria.contratar(maria)
```

### Agregar nuevos destinos
```wollok
object aeropuerto {
    method dejaPasarA(unMensajero) = 
        unMensajero.puedeLlamar() && unMensajero.peso() <= 500
}

// Uso
paquete.destino(aeropuerto)
```

### Agregar nuevos tipos de paquetes
```wollok
object paqueteFragil {
    method precio() = 100
    method estaPago() = true
    method puedeSerEntregadoPor(unMensajero) = 
        unMensajero.peso() < 100  // Solo mensajeros livianos
}

// Uso
empresaDeMensajeria.enviar(paqueteFragil)
```

### Agregar nuevos vehículos
```wollok
object moto {
    method peso() = 150
}

// Uso
roberto.vehiculo(moto)
```

## Flujo de Interacción Típico

### Escenario 1: Envío Exitoso

1. **Configuración inicial:**
   ```wollok
   empresaDeMensajeria.contratar(chucknorris)
   paquete.destino(lamatrix)
   paquete.registrarPago()
   ```

2. **Envío:**
   ```wollok
   empresaDeMensajeria.enviar(paquete)
   // Chuck puede llamar y el paquete está pago → se envía
   ```

3. **Resultado:**
   ```wollok
   empresaDeMensajeria.paquetesEnviados().contains(paquete)  // true
   empresaDeMensajeria.facturacion()  // 50
   ```

### Escenario 2: Paquete Pendiente

1. **Configuración:**
   ```wollok
   empresaDeMensajeria.contratar(roberto)
   paquete.destino(lamatrix)
   paquete.registrarPago()
   ```

2. **Intento de envío:**
   ```wollok
   empresaDeMensajeria.enviar(paquete)
   // Roberto no puede llamar → no se envía
   ```

3. **Resultado:**
   ```wollok
   empresaDeMensajeria.paquetesPendientes().contains(paquete)  // true
   empresaDeMensajeria.facturacion()  // 0
   ```

4. **Resolución:**
   ```wollok
   empresaDeMensajeria.contratar(chucknorris)
   empresaDeMensajeria.enviarPaquetePendienteMasCaro()
   // Ahora se puede enviar con Chuck
   empresaDeMensajeria.facturacion()  // 50
   ```

## Diagrama de Secuencia: Envío de Paquete

```
Empresa          Paquete          Mensajero        Destino
   │                │                 │               │
   ├─ enviar(paq)   │                 │               │
   │                │                 │               │
   ├─ puedeEntregar(paq)              │               │
   │                │                 │               │
   │                ├─ puedeSerEntregadoPor(mens)     │
   │                │                 │               │
   │                │                 ├─ dejaPasarA(mens)
   │                │                 │               │
   │                │                 │◄──────────────┤
   │                │                 │  true/false   │
   │                │◄────────────────┤               │
   │                │  true/false     │               │
   │◄───────────────┤                 │               │
   │  true/false    │                 │               │
   │                │                 │               │
   ├─ [si true] paquetesEnviados.add(paq)            │
   │  [si false] paquetesPendientes.add(paq)         │
   │                │                 │               │
```

## Polimorfismo en Acción

### Mensajeros
```wollok
// La empresa puede trabajar con cualquier mensajero
empresaDeMensajeria.contratar(roberto)
empresaDeMensajeria.contratar(chucknorris)
empresaDeMensajeria.contratar(neo)

// Todos responden a peso() y puedeLlamar()
empresaDeMensajeria.tieneSobrepeso()  // Usa peso() de cada uno
```

### Paquetes
```wollok
// La empresa puede enviar cualquier tipo de paquete
empresaDeMensajeria.enviar(paquete)
empresaDeMensajeria.enviar(paquetito)
empresaDeMensajeria.enviar(paquetonviajero)

// Todos responden a precio() y puedeSerEntregadoPor()
empresaDeMensajeria.facturacion()  // Usa precio() de cada uno
```

### Destinos
```wollok
// Los paquetes pueden tener cualquier destino
paquete.destino(puentedebrooklyn)
paquete.destino(lamatrix)

// Todos responden a dejaPasarA()
paquete.puedeSerEntregadoPor(mensajero)  // Usa dejaPasarA() del destino
```

## Cálculos de Ejemplo

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
Paqueton con 3 destinos: $300
```

### Sobrepeso de Empresa
```
Empresa con Chuck (80kg) y Neo (0kg):
Promedio: (80 + 0) / 2 = 40 kg → NO tiene sobrepeso

Empresa con Roberto en camión (1090kg):
Promedio: 1090 / 1 = 1090 kg → SÍ tiene sobrepeso
```

## Consideraciones de Testing

Cada módulo tiene su propia suite de tests:
- `tests/destinos.wtest` - Tests de destinos
- `tests/mensajeros.wtest` - Tests de mensajeros
- `tests/vehiculos.wtest` - Tests de vehículos
- `tests/paquetes.wtest` - Tests de paquetes
- `tests/empresa.wtest` - Tests de empresa

**Cobertura:** 100% de los métodos públicos

Ver [testing.md](testing.md) para más detalles sobre estrategias de testing.

## Recursos Adicionales

- Ver [testing.md](testing.md) para guías de testing
- Ver [development.md](development.md) para flujo de desarrollo
- Ver [README.md](../README.md) para la especificación completa del problema
