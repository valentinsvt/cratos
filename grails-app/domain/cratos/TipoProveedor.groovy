package cratos
class TipoProveedor implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'tppv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppv__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tppvcdgo'
            descripcion column: 'tppvdscr'
        }
    }
    static constraints = {
        codigo(size: 1..2, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 40, attributes: [title: 'descripcion'])
    }
}