package cratos
class TipoSoporte implements Serializable {
    String codigo
    String descripcion
    static auditable = true
    static mapping = {
        table 'tpst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpst__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpstcdgo'
            descripcion column: 'tpstdscr'
        }
    }
    static constraints = {
        codigo(size: 1..2, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 127, attributes: [title: 'tipoSoporte'])
    }
}