package cratos
class CuentaLinea implements Serializable {
    Cuenta cuenta
    ReporteLinea reporteLinea
    int debeHaber
    static mapping = {
        table 'cnln'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cnln__id'
        id generator: 'identity'
        version false
        columns {
            cuenta column: 'cnta__id'
            reporteLinea column: 'rpln__id'
            debeHaber column: 'cnlndbhb'
        }
    }
    static constraints = {
        cuenta(blank: false, attributes: [title: 'cuenta'])
        reporteLinea(blank: true, nullable: true, attributes: [title: 'reporteLinea'])
        debeHaber(blank: false, attributes: [title: 'debe haber'])
    }
}