package cratos
class ReformaPresupuestaria implements Serializable {
    Date fecha
    String macta
    String resumen
    String observaciones
    static mapping = {
        table 'rfpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rfpr__id'
        id generator: 'identity'
        version false
        columns {
            fecha column: 'rfprfcha'
            macta column: 'rfprmacta'
            resumen column: 'rfprrsmn'
            observaciones column: 'rfprobsr'
        }
    }
    static constraints = {
        fecha(blank: false, attributes: [title: 'fecha'])
        macta(size: 1..10, blank: false, attributes: [title: 'macta'])
        resumen(size: 1..1023, blank: false, attributes: [title: 'resumen'])
        observaciones(blank: true, maxSize: 127, attributes: [title: 'observaciones'])
    }
}