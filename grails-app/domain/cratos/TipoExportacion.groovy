package cratos
class TipoExportacion implements Serializable {

    String descripcion
    static mapping = {
        table 'tpex'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpex__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'tpexdscr'
        }
    }
    static constraints = {
        descripcion(blank: false, maxSize: 63, attributes: [title: 'descripcion'])
    }
}