package cratos
class DetalleRetencion implements Serializable {
    
    Retencion retencion
    Cuenta cuenta
    Impuesto impuesto
    double porcentaje
    double base
    double total = 0
    ConceptoRetencionImpuestoRenta conceptoRetencionImpuestoRenta


    static mapping = {
        table 'dtrt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtrt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtrt__id'
            retencion column: 'rtcn__id'
            impuesto column: 'impt__id'
            cuenta column: 'cnta__id'
            porcentaje column: 'dtrtpctj'
            base column: 'dtrtbase'
            total column: 'dtrttotl'
            conceptoRetencionImpuestoRenta column: 'crir__id'
        }
    }


    static constraints = {

        conceptoRetencionImpuestoRenta(blank: true, nullable: true, attributes: [title: 'concepto'])


    }

}