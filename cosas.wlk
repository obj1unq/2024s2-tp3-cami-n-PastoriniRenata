object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bulto(){ return 1}
	method cambio(){	}
}

object bumblebee {
	var property estado = auto // o robot

	method peso() { return 800 }
	method nivelPeligrosidad() { return estado.nivelPeligrosidad() }
	method bulto(){ return 2}
	method cambio(){estado = robot	}	
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
	method bulto(){ return self.bultoPorLadrillos()}

	method bultoPorLadrillos() {
		if( cantLadrillos<101){
			return 1
		}else{
			if(cantLadrillos<301){
				return 2
			}else{
				return 3
			}
		}
	}
	method cambio(){cantLadrillos += 12}



}

object arenaAGranel {
	var property peso = 0

	method nivelPeligrosidad() { return 1 }
	method bulto(){ return 1}
	method cambio(){peso += 20	}


}

object bateriaAntiaerea {
	var property estado = tieneMisil //noTieneMisil
	method peso() { return 200 + estado.peso() }
	method nivelPeligrosidad() { return estado.nivelPeligrosidad()  }
	method bulto(){return estado.bulto()}
	method cambio(){estado = tieneMisil	}

}

object tieneMisil{
	method peso() { return 100 }
	method nivelPeligrosidad() { return 100 }
	method bulto(){ return 2}

}

object noTieneMisil{
	method peso() { return 0 }
	method nivelPeligrosidad() { return 0 }
	method bulto(){ return 1}

}


object contenedor {
	const cosas = [paqueteDeLadrillos,bateriaAntiaerea]

	method peso() { return 100 + self.pesoTotalCosas() }
	method nivelPeligrosidad() { return self.mayorNivelDePeligrosidad()}


	method pesoTotalCosas(){
		return cosas.sum({cosa => cosa.peso()})
	}
	method mayorNivelDePeligrosidad(){
		return  self.nivelesDePeligrosidad().maxIfEmpty({0})
	}
	method nivelesDePeligrosidad() {
		return cosas.map({cosa => cosa.nivelPeligrosidad()})
	  
	}
	method bulto(){ return 1 + self.bultosDelContenedor()}

	method bultosDelContenedor(){
		return cosas.sum({cosa => cosa.bulto()})

	}

}

object residuosRadioactivos {
	var property peso = 0
	method nivelPeligrosidad() { return 200}  
	method bulto(){ return 1}
	method cambio(){peso += 15}

}


object embalajeDeSeguridad {
	var property cosa = residuosRadioactivos //o cualquier cosa

	method peso() {return cosa.peso()}
	method nivelPeligrosidad() {return cosa.nivelPeligrosidad()/2}
	method bulto(){ return 2}
	method cambio(){	}

}









