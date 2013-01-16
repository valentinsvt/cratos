package cratos
class TipoFactura implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'tpfc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpfc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpfc__id'
            codigo column: 'tpfccdgo'
            descripcion column: 'tpfcdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: true, nullable: true, attributes: [title: 'codigo'])
        descripcion(blank: true, nullable: true, size: 1..15, attributes: [title: 'descripción'])
    }
}