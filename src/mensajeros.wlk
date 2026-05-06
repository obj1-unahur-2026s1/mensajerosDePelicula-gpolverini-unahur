import src.vehiculos.*

object roberto {
    var property vehiculo = bicicleta
    method peso() = 90 + vehiculo.peso() 
    method puedeLlamar() = false
}

object chucknorris {
    method peso() = 80
    method puedeLlamar() = true
}

object neo {
    method peso() = 0
    var tieneCredito = false
    method cargarCredito() { tieneCredito = true }
    method agotarCredito() { tieneCredito = false }
    method puedeLlamar() = tieneCredito
}