package cratos
class TipoDocumentoProveedor implements Serializable {
    String codigo
    String descripcion

    static auditable = true

    static mapping = {
        table 'tpdp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpdp__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpdpcdgo'
            descripcion column: 'tpdpdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 31, attributes: [title: 'descripcion'])
    }
}