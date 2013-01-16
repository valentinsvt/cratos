package cratos
class ComprobantesAnulados implements Serializable {
    TipoComprobante tipoComprobante
    TipoComprobanteId tipoComprobanteId
    Proveedor proveedor
    String serial01
    String serial02
    int secuencialdesde
    int secuencialhasta
    String autorizacion

    static mapping = {
        table 'anld'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'anld__id'
        id generator: 'identity'
        version false
        columns {
            tipoComprobante column: 'tpcp__id'
            tipoComprobanteId column: 'tcti__id'
            proveedor column: 'prve__id'
            serial01 column: 'anldsr01'
            serial02 column: 'anldsr02'
            secuencialdesde column: 'anldscds'
            secuencialhasta column: 'anldschs'
            autorizacion column: 'anldatrz'
        }
    }
    static constraints = {
        tipoComprobante(blank: false, attributes: [title: 'tipoComprobante'])
        tipoComprobanteId(blank: false, attributes: [title: 'tipoComprobanteId'])
        proveedor(blank: false, attributes: [title: 'proveedor'])
        serial01(blank: true, attributes: [title: 'serial01'])
        serial02(blank: true, attributes: [title: 'serial02'])
        secuencialdesde(blank: true, attributes: [title: 'secuencialdesde'])
        secuencialhasta(blank: true, attributes: [title: 'secuencialhasta'])
        autorizacion(blank: true, attributes: [title: 'autorizacion'])


    }
}