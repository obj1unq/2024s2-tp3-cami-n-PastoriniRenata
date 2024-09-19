object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

object bumblebee {
	var property estado = auto // o robot

	method peso() { return 800 }
	method nivelPeligrosidad() { return estado.nivelPeligrosidad() }
}

object auto{
	method nivelPeligrosidad(){ return 15 }
}

object robot{
	method nivelPeligrosidad(){ return 30 }
}

object paqueteDeLadrillos {
	var property cantLadrillos = 0

	method peso() { return cantLadrillos * 2 }
	method nivelPeligrosidad() { return 2 }

}

object arenaAGranel {
	var property peso = 0

	method nivelPeligrosidad() { return 1 }
}

object bateriaAntiaerea {
	var property estado = tieneMisil //noTieneMisil
	method peso() { return 200 + estado.peso() }
	method nivelPeligrosidad() { return estado.nivelPeligrosidad()  }


}

object tieneMisil{
	method peso() { return 100 }
	method nivelPeligrosidad() { return 100 }

}

object noTieneMisil{
	method peso() { return 0 }
	method nivelPeligrosidad() { return 0 }

}


object contenedor {
	const cosas = #{}
	method peso() { return 100 + self.pesoTotalCosas() }
	method nivelPeligrosidad() { return self.objetoMasPeligroso().nivelPeligrosidad()}

	method pesoTotalCosas(){
		return cosas.sum({cosa => cosa.peso()})
	}
	method objetoMasPeligroso(){
		return  cosas.max({cosa => cosa.nivelPeligrosidad()})
	}
}














