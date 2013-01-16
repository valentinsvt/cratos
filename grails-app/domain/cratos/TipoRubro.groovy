package cratos
class TipoRubro implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'tprb'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tprb__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tprb__id'
            codigo column: 'tprbcdgo'
            descripcion column: 'tprbdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: true, nullable: true, attributes: [title: 'codigo'])
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripcion'])
    }
    String toString() {
        descripcion
    }
}
