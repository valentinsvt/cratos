package cratos
class Nacionales implements Serializable {

    String descripcion

    static mapping = {
        table 'ncnl'
        cache usage: 'read-write', include: 'non-lazy'

        id column: 'ncnl__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'ncnl__id'
            descripcion column: 'ncnldscr'
        }
    }
    static constraints = {
        descripcion(blank: true, size: 1..31, attributes: [title: 'descripcion'])
    }
}