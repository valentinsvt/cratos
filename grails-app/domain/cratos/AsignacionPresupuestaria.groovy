package cratos
class AsignacionPresupuestaria implements Serializable {
    Contabilidad contabilidad
    Presupuesto presupuesto
    double asignacion
    static mapping = {
        table 'aspr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'aspr__id'
        id generator: 'identity'
        version false
        columns {
            contabilidad column: 'cont__id'
            presupuesto column: 'prsp__id'
            asignacion column: 'asprasgn'
        }
    }
    static constraints = {
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
        presupuesto(blank: true, nullable: true, attributes: [title: 'presupuesto'])
        asignacion(blank: false, attributes: [title: 'asignacion'])
    }
}