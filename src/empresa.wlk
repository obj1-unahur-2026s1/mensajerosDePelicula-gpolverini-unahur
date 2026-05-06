object empresaDeMensajeria {
    const mensajeros = []
    const paquetesEnviados = []
    const paquetesPendientes = []
    
    method contratar(unMensajero) { mensajeros.add(unMensajero) }
    method despedir(unMensajero) { mensajeros.remove(unMensajero) }
    method despedirATodos() { mensajeros.clear() }    
    method esGrande() = mensajeros.size() > 2
    method elPrimerEmpleadoPuedeEntregar(unPaquete) = unPaquete.puedeSerEntregadoPor(mensajeros.first())
    method pesoDelUltimoMensajero() = mensajeros.last().peso()
    method cantidadDeMensajeros() = mensajeros.size()
    method mensajeros() = mensajeros
    
    method puedeEntregar(unPaquete) = mensajeros.any({m => unPaquete.puedeSerEntregadoPor(m)})
    method mensajerosQuePuedenLlevar(unPaquete) = mensajeros.filter({m => unPaquete.puedeSerEntregadoPor(m)})
    method tieneSobrepeso() = mensajeros.sum({m => m.peso()}) / mensajeros.size() > 500
    method enviar(unPaquete) {
        if (self.puedeEntregar(unPaquete)) {
            paquetesEnviados.add(unPaquete)
        } else {
            paquetesPendientes.add(unPaquete)
        }
    }
    
    method facturacion() = paquetesEnviados.sum({p => p.precio()})    
    method enviarTodos(paquetes) { paquetes.forEach({p => self.enviar(p)}) }
    method enviarPaquetePendienteMasCaro() {
        if (!paquetesPendientes.isEmpty()) {
            const masCaro = paquetesPendientes.max({p => p.precio()})
            paquetesPendientes.remove(masCaro)
            self.enviar(masCaro)
        }
    }
    
    method paquetesEnviados() = paquetesEnviados    
    method paquetesPendientes() = paquetesPendientes    
    method limpiarPaquetes() {
        paquetesEnviados.clear()
        paquetesPendientes.clear()
    }
}
