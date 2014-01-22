package cratos.sri
class TipoDePagoSri implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'tpge'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpge__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpgecdgo'
            descripcion column: 'tpgedscr'
        }
    }
    static constraints = {
        codigo(blank:true,nullable: true,size: 1..4)
        descripcion(blank:true,nullable: true,size: 1..120)
    }

    String toString() {

    }
}
