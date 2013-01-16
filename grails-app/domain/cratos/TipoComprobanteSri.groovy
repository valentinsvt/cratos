package cratos
class TipoComprobanteSri implements Serializable {
    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'tpcp_sri'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpcp__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpcpcdgo'
            descripcion column: 'tpcpdscr'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 63, attributes: [title: 'descripcion'])
    }
}