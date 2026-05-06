object bicicleta {
    method peso() = 5
}

object camion {
    var cantidadDeAcoplados = 1
    method cantidadDeAcoplados(cantidad) { cantidadDeAcoplados = cantidad }
    method peso() = cantidadDeAcoplados * 500
}