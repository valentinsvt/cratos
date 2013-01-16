package cratos
class EjecucionPresupuestaria implements Serializable {
    String registro
    Date fechaFin
    Date fechaInicio
    Date fecha
    String descripcion
    Contabilidad contabilidad
    String observaciones
    static mapping = {
        table 'ejpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ejpr__id'
        id generator: 'identity'
        version false
        columns {
            registro column: 'ejprrgst'
            fechaFin column: 'ejprfcfn'
            fechaInicio column: 'ejprfcin'
            fecha column: 'ejprfcha'
            descripcion column: 'ejprdscr'
            contabilidad column: 'cont__id'
            observaciones column: 'ejprobsr'
        }
    }
    static constraints = {
        registro(size: 1..1, blank: true, nullable: true, attributes: [title: 'registro'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'fechaFin'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        contabilidad(blank: true, nullable: true, attributes: [title: 'contabilidad'])
        observaciones(blank: true, maxSize: 127, attributes: [title: 'observaciones'])
    }
}