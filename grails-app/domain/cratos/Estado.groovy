package cratos
class Estado implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'etdo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'etdo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'etdo__id'
            codigo column: 'etdocdgo'
            descripcion column: 'etdodscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: true, nullable: true, attributes: [title: 'codigo'])
        descripcion(blank: true, nullable: true, size: 1..63, attributes: [title: 'descripción'])
    }
}