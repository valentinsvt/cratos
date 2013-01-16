package cratos
class Nivel implements Serializable {
    String descripcion
    static mapping = {
        table 'nvel'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'nvel__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'nveldscr'
        }
    }
    static constraints = {
        descripcion(blank: false, maxSize: 16, attributes: [title: 'descripcion'])
    }
}