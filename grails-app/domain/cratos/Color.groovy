package cratos
class Color  implements Serializable {

    String descripcion
    static auditable = true

    static mapping = {
        table 'clor'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'clor__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'clor__id'
            descripcion column: 'clordscr'
        }
    }
    static constraints = {
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripción'])
    }




}