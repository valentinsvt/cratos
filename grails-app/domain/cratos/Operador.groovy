package cratos
class Operador implements Serializable {
    String descripcion
    String signo
    static mapping = {
        table 'oprd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'oprd__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'oprddscr'
            signo column: 'oprdsgno'
        }
    }
    static constraints = {
        descripcion(size: 1..15, blank: true, nullable: true, attributes: [title: 'descripcion'])
        signo(blank: false, maxSize: 7, attributes: [title: 'signo'])
    }
}