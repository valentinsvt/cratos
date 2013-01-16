package cratos
class Mes implements Serializable {

    String descripcion

    static mapping = {
        table 'mess'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mess__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mess__id'
            descripcion column: 'messdscr'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..15, attributes: [title: 'descripción'])
    }
}