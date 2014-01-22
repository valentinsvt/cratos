package cratos.sri
class IdentificacionProveedor implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'tpip'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpip__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpipcdgo'
            descripcion column: 'tpipdscr'
        }
    }
    static constraints = {
        codigo(blank:true,nullable: true,size: 1..4)
        descripcion(blank:true,nullable: true,size: 1..120)
    }
    String toString() {

    }
}
