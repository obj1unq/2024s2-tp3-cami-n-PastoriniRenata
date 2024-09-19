import cosas.*

object camion {
	const property cosas = #{}
	const tara = 1000
	const pesoMax = 2500
		
	method cargar(unaCosa) {
		cosas.add(unaCosa)
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
}

