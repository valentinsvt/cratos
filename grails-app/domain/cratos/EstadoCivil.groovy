package cratos
class EstadoCivil implements Serializable {

    String descripcion


    static mapping = {
        table 'edcv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'edcv__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'edcv__id'
            descripcion column: 'edcvdscr'
        }
    }
    static constraints = {
        descripcion(blank: false, size: 1..15, attributes: [title: 'descripcion'])
    }
}