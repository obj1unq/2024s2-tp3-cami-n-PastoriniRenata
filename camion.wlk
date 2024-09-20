import cosas.*

object camion {

	const property cosas = #{} 
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
		self.hayAlgunoDeNivel(nivel)
		return cosas.find({cosa => cosa.nivelPeligrosidad() == nivel})
	}
	method hayAlgunoDeNivel(nivel){ //no se si está bien salvar el error
		if (not self.hayAlgunoConNivel(nivel)){
			self.error("No hay elemento con ese nivel de peligrosidad")
		}
	}
	method hayAlgunoConNivel(nivel){
		return cosas.any({cosa => cosa.nivelPeligrosidad() == nivel})
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
		return cosas.map({cosa => cosa.peso()}) // MAP DEVUELVE UNA LISTA
	}
	method totalBultos() {
		return cosas.sum({cosa => cosa.bulto()})
		}

	method llegadaADestino(destino) {
		cosas.forEach({cosa => destino.cargar(cosa)})
		self.vaciarCamion()
	}
	method vaciarCamion(){
			cosas.clear()
		}

	method transportar(destino, camino){
		self.validarTransportar(destino, camino)
		self.llegadaADestino(destino)
	}
	
	method validarTransportar(destino, camino){
		self.verificaPeso()
		self.verificaHayEspacioEnAlmacen(destino)
		self.verificarCamino(camino)
	}
	method verificaPeso(){
		if(self.excedidoDePeso()){
			self.error("No puede transportar a destino porque está excedido de peso")
		}
	}
	method verificaHayEspacioEnAlmacen(destino){
		if(destino.espacioDisponibleBultos() < self.totalBultos()){
			self.error("No puede transportar a destino porque no hay espacio en " + destino)
		}
	}
	method verificarCamino(camino){
		if(camino.puedeCircular(self)){
			self.error("El camino no es apto para el transporte")
		}
	}
}
object ruta9{
	var property pesoMaximoSoportado = 100
	method nivelPeligrosidad()  {return 11}

	method puedeCircular(transporte){
		return transporte.puedeCircularEnRuta(self.nivelPeligrosidad())
	}
}

object caminoVecinal {
	var property pesoSoportado = 5000

	method puedeCircular(transporte) {
	  	return pesoSoportado<= transporte.pesoTotal()
	}
}

object almacen {
	const property almacenaje = #{}
	var property bultosMax = 3

	method cargar(cosa) {
		almacenaje.add(cosa)
	}
	method espacioDisponibleBultos(){
		return bultosMax - self.totalBultos()
	}
	method totalBultos() {
		return almacenaje.sum({cosa => cosa.bulto()})
	  
	}
}

