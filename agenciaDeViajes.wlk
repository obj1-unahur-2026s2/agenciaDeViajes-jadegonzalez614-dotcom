class Pack{
    const duracionDeDias 
    const precioBase
    const beneficiosEspeciales = []
    var coordinador

    method duracionDeDias() = duracionDeDias
    method precioBase() = precioBase
    method beneficiosEspeciales() = beneficiosEspeciales
    method cantDeBeneficios() = beneficiosEspeciales.size() 
    method beneficiosVigentes() = beneficiosEspeciales.count({b => b.estaVigente()})
    method coordinador() = coordinador

    method valorTotalBeneficios() = beneficiosEspeciales.sum({b => b.costo()}) 
    method valorFinal() = precioBase +  self.valorTotalBeneficios()

    method esPrimium() 

}

class PackNacionales inherits Pack{
    const provincia
    const actividades = []

    method provincia() = provincia
    method actividades() = actividades 

    override method esPrimium() = duracionDeDias > 10 and coordinador.estaCalificado()
}

class PackProvinciales inherits PackNacionales{
    var cantDeCiudad

    method cantDeCiudad() = cantDeCiudad 

    override method esPrimium(){
        return self.cantDeBeneficios() >= 4 and cantDeCiudad > 5 and self.beneficiosVigentes() > 3
    }

    override method valorFinal(){
        if(self.esPrimium()){
            return super() * 1.05
        }else{
            return super()
        }
    }

    
}

class PackInternacionales inherits Pack{
    const pais
    const cantDeEscalas
    const esDeInteres

    method pais() = pais
    method cantDeEscalas() = cantDeEscalas
    method esDeInteres() = esDeInteres  

    override method valorFinal() = super() * 1.2 

    override method esPrimium() = self.esDeInteres() and duracionDeDias > 20 and cantDeEscalas == 0
}

/*-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-..-.-.-.-.-.-.-..-.-.-.-.-.-..--.-*/
class Coordinadores{
    var cantDeViajes
    var estaMotivado
    var aniosDeExperiencia
    var rol  //str

    method cantDeViajes() = cantDeViajes
    method estaMotivado() = estaMotivado
    method aniosDeExperiencia() = aniosDeExperiencia
    method rol() = rol 
    

    method cambiarDeRol(unRol){
      const listaAComparar = ["guia", "asistenteLogistico", "acompañante"]  
      if(listaAComparar.contains(unRol) ){
        rol = unRol
      }else{
        self.error("Este rol no esta disponible")
      }
    
    }  

    method estaCalificado() = cantDeViajes > 20 
}

class Guia inherits Coordinadores{ 
  override method estaCalificado() = super() and self.estaMotivado()  
}

class AsistenteLogistico inherits Coordinadores{
  override method estaCalificado() = super() and self.aniosDeExperiencia() >= 3 
}

class Acompañante inherits Coordinadores{

}


/*-.-.-.-.-.-.-.-.-.-.-.-.--.-.--.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-..-.-..-.-*/
class BeneficiosEspeciales{
    const tipo //str
    const costo //int
    const estaVigente //bool

    method tipo() = tipo
    method costo() = costo
    method estaVigente() = estaVigente 
}