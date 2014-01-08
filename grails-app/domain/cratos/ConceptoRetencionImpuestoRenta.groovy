package cratos

class ConceptoRetencionImpuestoRenta implements Serializable {
    String codigo
    String descripcion
    double porcentaje

    static auditable = true
    static mapping = {
        table 'crir'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crir__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'crircdgo'
            descripcion column: 'crirdscr'
            porcentaje column: 'crirpctj'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 63, attributes: [title: 'descripcion'])
        porcentaje(blank: true, nullable:true, attributes: [title: 'porcentaje'])
    }
}