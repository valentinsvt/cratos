package cratos
class TipoPago implements Serializable {

    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'tppg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tppg__id'
        id generator: 'identity'
        version false
        columns {

            codigo column: 'tppgcdgo'
            descripcion column: 'tppgdscr'
        }
    }
    static constraints = {
        codigo(size: 1..1, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: true, nullable: true, size: 1..40, attributes: [title: 'descripción'])
    }
}