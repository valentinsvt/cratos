package cratos
class Responsable implements Serializable {
    Empleado empleado
    ActivoFijo activoFijo

    static mapping = {
        table 'rspn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rspn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rspn__id'
            empleado column: 'empl__id'
            activoFijo column: 'acfj__id'
        }
    }
    static constraints = {
        empleado(blank: true, nullable: true, attributes: [title: 'empleado'])
        activoFijo(blank: true, nullable: true, attributes: [title: 'activo fijo'])
    }
}