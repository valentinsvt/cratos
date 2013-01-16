package cratos.seguridad
class Accs implements Serializable {
    
    Date accsFechaInicial
    Date accsFechaFinal
    String accsObservaciones
    
    Usro usuario
    
    static mapping = {
        table 'accs'
        version false	
        id generator: 'identity'
        
        columns {
            id column: 'accs__id'
            usuario column:'usro__id'           
            accsFechaInicial column: 'accsfcin'
            accsFechaFinal column: 'accsfcfn'
            accsObservaciones column: 'accsobsr'
        }
    }
    
    static constraints = {
        accsFechaInicial(blank:false, nullable:false)
        accsFechaFinal(blank:false, nullable:false)
        accsObservaciones(blank:true, nullable:true)
    }
    
    
}
