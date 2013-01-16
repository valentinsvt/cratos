package cratos
class TipoTarjeta implements Serializable {
    String descripcion

    static mapping = {
        table 'tptj'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tptj__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tptj__id'
            descripcion column: 'tptjdscr'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripción'])
    }
}