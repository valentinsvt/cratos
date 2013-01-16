package cratos
class ModificacionPresupuestaria implements Serializable {
    double monto
    int numero
    AsignacionPresupuestaria asignacionPresupuestaria
    ReformaPresupuestaria reformaPresupuestaria
    double dcrm
    static mapping = {
        table 'mfpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mfpr__id'
        id generator: 'identity'
        version false
        columns {
            monto column: 'mfprmnto'
            numero column: 'mfprnmro'
            asignacionPresupuestaria column: 'asignacion'
            reformaPresupuestaria column: 'rfpr__id'
            dcrm column: 'mfprdcrm'
        }
    }
    static constraints = {
        monto(blank: false, attributes: [title: 'monto'])
        numero(blank: false, attributes: [title: 'numero'])
        asignacionPresupuestaria(blank: true, nullable: true, attributes: [title: 'asignacionPresupuestaria'])
        reformaPresupuestaria(blank: true, nullable: true, attributes: [title: 'reformaPresupuestaria'])
        dcrm(blank: false, attributes: [title: 'dcrm'])
    }
}