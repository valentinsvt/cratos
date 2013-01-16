package cratos.seguridad

class Accn {
	
    String accnNombre
    String accnDescripcion
    int accnAuditable
    Ctrl control
    Modulo modulo
    Tpac tipo
    
    static hasMany = [permisos: Prms]
    static searchable = true
	                  
    static mapping = {
        table 'accn'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'
        control sort: ['ctrlNombre': 'asc']
        columns {
            id column:              'accn__id'
            accnNombre column:      'accnnmbr'
            accnDescripcion column: 'accndscr'
            accnAuditable column:   'accnaudt'
            control column:         'ctrl__id'
            modulo column:          'mdlo__id'
            tipo column:            'tpac__id'
        }
    }
	
	
    static constraints = {
        accnNombre(blank:false,size:0..50)
        accnAuditable(blank:true, nullable:true)
    }
    
    String toString(){
        "${this.control.ctrlNombre} : ${this.accnNombre} "
    }
}
