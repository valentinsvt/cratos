package cratos
class Genera implements Serializable {
    double valor
    double porcentajeImpuestos
    double porcentaje
    TipoComprobante tipoComprobante
    Cuenta cuenta
    Gestor gestor
    String debeHaber
    static auditable = true
    static mapping = {
        table 'gnra'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'gnra__id'
        id generator: 'identity'
        version false
        columns {
            valor column: 'gnravlor'
            porcentajeImpuestos column: 'gnrapcim'
            porcentaje column: 'gnrapcnt'
            tipoComprobante column: 'tpcp__id'
            cuenta column: 'cnta__id'
            gestor column: 'gstr__id'
            debeHaber column: 'gnradbhb'
        }
    }
    static constraints = {
        valor(blank: true, nullable: true, attributes: [title: 'valor'])
        porcentajeImpuestos(blank: true, nullable: true, attributes: [title: 'porcentajeImpuestos'])
        porcentaje(blank: true, nullable: true, attributes: [title: 'porcentaje'])
        tipoComprobante(blank: false, attributes: [title: 'tipoProveedor'])
        cuenta(blank: true, nullable: true, attributes: [title: 'cuenta'])
        gestor(blank: true, nullable: true, attributes: [title: 'gestor'])
        debeHaber(blank: false, maxSize: 1, attributes: [title: 'debe o haber'])
    }
}