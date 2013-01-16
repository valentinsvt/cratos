package cratos
class Asiento implements Serializable {
    double haber=0
    double debe=0
    String numero
    Cuenta cuenta
    Comprobante comprobante
    String retencion
    static auditable = true
    static mapping = {
        table 'asnt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'asnt__id'
        id generator: 'identity'
        version false
        columns {
            haber column: 'asnthber'
            debe column: 'asntdebe'
            numero column: 'asntnmro'
            cuenta column: 'cnta__id'
            comprobante column: 'cmpr__id'
            retencion column: 'asntrtnc'
        }
    }
    static constraints = {
        haber(blank: true, nullable: true, attributes: [title: 'haber'])
        debe(blank: true, nullable: true, attributes: [title: 'debe'])
        numero(blank: false, attributes: [title: 'numero'])
        cuenta(blank: false, attributes: [title: 'cuenta'])
        comprobante(blank: false, attributes: [title: 'comprobante'])
        retencion(blank: true,nullable: true, attributes: [title: 'si es o no parte de la retención'])
    }

    def suma(){
        def total = 0
        def aux = Auxiliar.findAllByAsiento(this)
        aux.each {
            total += it.debe-it.haber
        }
        return Math.abs(total)

    }
}