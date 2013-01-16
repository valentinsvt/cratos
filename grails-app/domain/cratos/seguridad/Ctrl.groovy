package cratos.seguridad

class Ctrl {
	
    String ctrlNombre
    static hasMany = [acciones: Accn]
	
    static mapping = {
        table 'ctrl'
        cache usage:'read-write', include:'non-lazy'
        version false
        id generator: 'identity'
        sort ctrlNombre: "asc"
        columns {
            id column : 'ctrl__id'
            ctrlNombre column: 'ctrlnmbr'
        }
    }
	
    static constraints = {
        ctrlNombre(blank:false, size:0..50)
    }

    String toString(){
        "${this.ctrlNombre}"
    }
}
