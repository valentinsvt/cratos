package cratos
class TipoPersona implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'tppr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppr__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpprcdgo'
            descripcion column: 'tpprdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 15, attributes: [title: 'descripcion'])
    }
}