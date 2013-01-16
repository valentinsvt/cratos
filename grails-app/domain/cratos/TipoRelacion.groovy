package cratos
class TipoRelacion implements Serializable {
    String codigo
    String descripcion
    static auditable = true
    static mapping = {
        table 'tprl'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tprl__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tprlcdgo'
            descripcion column: 'tprldscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 31, attributes: [title: 'descripcion'])
    }
}