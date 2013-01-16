package cratos
class Adquisiciones implements Serializable {

    String registro
    Date fechaPago
    String estado
    int estadoCheque
    String cheque
    String facturaSerie1
    String facturaSerie2
    String facturaNumero
    Date fecha = new Date()
    Empresa empresa
    TipoPago tipoPago
//    Bodega bodega
    Proveedor proveedor
    String observaciones
    OrdenCompra orden

    String descripcion

    Gestor gestor

    static mapping = {
        table 'adqc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'adqc__id'
        id generator: 'identity'
        version false
        columns {
//            id column: 'adqco__id'
            registro column: 'adqcrgst'
            fechaPago column: 'adqcfcpg'
            estado column: 'adqcetdo'
            estadoCheque column: 'adqcesch'
            cheque column: 'adqcchqe'
            facturaSerie1 column: 'adqcfcs1'
            facturaSerie2 column: 'adqcfcs2'
            facturaNumero column: 'adqcfcnm'
            fecha column: 'adqcfcha'
            empresa column: 'empr__id'
            tipoPago column: 'tppg__id'
            proveedor column: 'prve__id'
            observaciones column: 'adqcobsr'
            gestor column: 'gstr__id'
            orden column: 'odcp__id'

            descripcion column: 'adqcdscr'
        }
    }
    static constraints = {
        registro(blank: true, nullable: true, attributes: [title: 'registro'])
        fechaPago(blank: true, nullable: true, attributes: [title: 'fechaPago'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        estadoCheque(blank: true, nullable: true, attributes: [title: 'estadoCheque'])
        cheque(size: 1..15, blank: true, nullable: true, attributes: [title: 'cheque'])
        facturaSerie1(maxSize: 3, blank: true, nullable: true, attributes: [title: 'factura serie 1'])
        facturaSerie2(maxSize: 3, blank: true, nullable: true, attributes: [title: 'factura serie 2'])
        facturaNumero(maxSize: 33, blank: true, nullable: true, attributes: [title: 'factura numero'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        tipoPago(blank: true, nullable: true, attributes: [title: 'tipoPago'])
        proveedor(blank: true, nullable: true, attributes: [title: 'proveedor'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
        gestor(blank: false, nullable: false, attributes: [title: 'gestor contable'])
        orden(blank: true, nullable: true)
        descripcion(blank: true, nullable: true)
    }

    double totalAdq() {
        def total = 0
        DetalleAdquisicion.findAllByAdquisiciones(this).each {
            total += (it.subtotal + it.iva + it.ice)
        }
        return total
    }
}