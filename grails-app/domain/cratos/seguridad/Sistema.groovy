package cratos.seguridad
class Sistema implements Serializable{
    String nombre
    String descripcion
    
    static auditable=[ignore:[]]
    static mapping = {
        table 'sstm'
        cache usage:'read-write', include:'non-lazy'
        id column:'sstm__id'
        id generator:'identity'
        version false
        columns {
            id column:'sstm__id'
            nombre column: 'sstnmbr'
            descripcion column: 'sstmdscr'
            
        }
    }
    static constraints = {
        nombre(matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]+$/,size:1..50,blank:false, nullable:false )
        descripcion(matches:/^[a-zA-Z0-9ñÑ .,áéíóúÁÉÍÚÓüÜ#_+-]+$/,size:1..500,blank:true, nullable:true)
    }
    String toString(){
"${this.descripcion}"
    }
}