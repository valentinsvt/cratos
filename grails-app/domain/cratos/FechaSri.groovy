package cratos
class FechaSri implements Serializable {
    String numero
    String descripcion
    static mapping = {
        table 'fsri'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fsri__id'
        id generator: 'identity'
        version false
        columns {
            numero column: 'fsrinmro'
            descripcion column: 'fsridscr'
        }
    }
    static constraints = {
        numero(size: 1..7, blank: false, attributes: [title: 'numero'])
        descripcion(blank: false, maxSize: 63, attributes: [title: 'descripcion'])
    }
}