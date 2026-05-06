import src.destinos.*

object paquete {
    var property destino = puentedebrooklyn
    method precio() = 50
    var estaPago = false
    method registrarPago() { estaPago = true }
    method rechazarPago() { estaPago = false }
    method estaPago() = estaPago
    method puedeSerEntregadoPor(unMensajero) = destino.dejaPasarA(unMensajero) && estaPago
}

object paquetito {
    method precio() = 0
    method estaPago() = true
    method puedeSerEntregadoPor(unMensajero) = true
}

object paquetonviajero {
    const destinos = #{}
    method agregarDestino(unDestino) { destinos.add(unDestino) }
    method quitarDestino(unDestino) { destinos.remove(unDestino) }
    method limpiarDestinos() { destinos.clear() }
    method precio() = destinos.size() * 100
    var importeAbonado = 0
    method registrarPago(importe) { importeAbonado = (importeAbonado + importe).min(self.precio()) }
    method limpiarPago() { importeAbonado = 0 }
    method estaPago() = self.precio() == importeAbonado
    method puedeSerEntregadoPor(unMensajero) = destinos.all({d => d.dejaPasarA(unMensajero)}) && self.estaPago()
}