import cosas.*

object camion {

	const property cosas = [] //ladrillos pesan 0 y bateria pesa=300
	const tara = 1000
	const pesoMax = 2500
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
		unaCosa.cambio()
	}
	method descargar(unaCosa){
		cosas.remove(unaCosa)
	}
	method todoPesoPar(){
		return cosas.all({cosa => cosa.peso().even()})
	}
	method hayAlgunoQuePesa(peso){
		return cosas.any({cosa => cosa.peso() == peso})
	}
	method elDeNivel(nivel) {
		return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	method pesoTotal() {
		return tara + cosas.sum({cosa => cosa.peso()})
	}
	method excedidoDePeso(){
		return self.pesoTotal() > pesoMax 
	}

	method objetosQueSuperanPeligrosidad(nivel){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivel})
	}
	method objetosMasPeligrososQue(cosa){
		return self.objetosQueSuperanPeligrosidad(cosa.nivelPeligrosidad())
	}
	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		return not self.excedidoDePeso() and self.noExistenCosasQueSuperenElMaxDePeligrosidad(nivelMaximoPeligrosidad)
	}
	method noExistenCosasQueSuperenElMaxDePeligrosidad(nivel){
		return self.objetosQueSuperanPeligrosidad(nivel).isEmpty()
	}

//AGREGAR AL CAMION

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({cosa => cosa.peso()>=min and cosa.peso()<=max})
	}

	method cosaMasPesada(){
		return cosas.maxIfEmpty({cosa => cosa.peso()}, {})
	}

	method pesos(){
		return cosas.map({cosa => cosa.peso()})
	}
	method totalBultos() {
		return cosas.sum({cosa => cosa.bulto()})
		}

	method llegadaAAlmacen() {
		cosas.map({cosa => almacen.agregar(cosa)})
		cosas.clear()
	}

	method trasportar(destino, camino){
		self.verificaTransportar(destino,camino)
	}
	method verificaTransportar(destino,camino){
		if(not self.puedeTransportar(destino,camino)){
				self.error("No puede transportar a destino")
		}
	}
	method puedeTransportar(destino,camino){
		return destino.puedeCircular(self.pesoTotal()) and not self.excedidoDePeso()/*no se si es peso max del camion o del camino*/ and self.alcanzanLosCuposEn(destino)
	}
	method alcanzanLosCuposEn(destino){
		return destino.espacioDisponibleBultos() > self.totalBultos()
	}

}
object ruta9{
	var property pesoMaximoSoportado = 100
	method nivelPeligrosidad()  {return 11}

	method puedeCircularEnRuta(nivelMaximoPeligrosidad){
		return
	}
}

object caminoVecinal {
  
}
object almacen {
	const almacenaje = []
	var property bultosMax = 3

	method agregar(cosa) {
		almacenaje.add(cosa)
	}
	method espacioDisponibleBultos(){
		return bultosMax - almacenaje.size()
	}
}

