package cratos
class Fuente implements Serializable {
    String descripcion
    static mapping = {
        table 'fnte'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fnte__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'fntedscr'
        }
    }
    static constraints = {
        descripcion(blank: false, maxSize: 40, attributes: [title: 'descripcion'])
    }
}