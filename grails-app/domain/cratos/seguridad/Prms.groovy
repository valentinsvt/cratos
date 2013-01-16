package cratos.seguridad

class Prms implements Serializable{
		
    Accn accion
    Prfl perfil
    static auditable=[ignore:[]]
	
    static mapping = {
        table 'prms'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'
        
        columns {
            id column: 'prms__id'
            accion column:'accn__id'
            perfil column:'prfl__id'
        }
    }
	
    static constraints = {
    }
}
