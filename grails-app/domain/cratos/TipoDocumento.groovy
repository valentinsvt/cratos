package cratos
class TipoDocumento implements Serializable {
    String codigo
    String descripcion

    static mapping = {
        table 'tpdc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpdc__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpdccdgo'
            descripcion column: 'tpdcdscr'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, nullable: false, attributes: [title: 'Descripción'])
    }
}