package cratos.sri
class TipoTransaccion implements Serializable {

    String descripcion
    String codigo

    static mapping = {
        table 'tptr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tptr__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tptrcdgo'
            descripcion column: 'tptrdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 31, attributes: [title: 'descripcion'])
    }
}