package cratos
class TipoContrato implements Serializable {

    String descripcion

    static mapping = {
        table 'tpct'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpct__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpct__id'
            descripcion column: 'tpctdscr'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripcion'])
    }
}