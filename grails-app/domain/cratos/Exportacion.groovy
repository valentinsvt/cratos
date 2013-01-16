package cratos
class Exportacion implements Serializable {
    TipoComprobante tipoComprobante
    TipoExportacion tipoExportacion
    TipoComprobanteId tipoComprobanteId
    Proveedor proveedor

    static mapping = {
        table 'expt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'expt__id'
        id generator: 'identity'
        version false
        columns {
            tipoComprobante column: 'tpcp__id'
            tipoExportacion column: 'tpex__id'
            tipoComprobanteId column: 'tcti__id'
            proveedor column: 'prve__id'
        }
    }
    static constraints = {
        tipoComprobante(blank: false, attributes: [title: 'tipoComprobante'])
        tipoExportacion(blank: false, attributes: [title: 'tipoExportacion'])
        tipoComprobanteId(blank: false, attributes: [title: 'tipoComprobanteId'])
        proveedor(blank: false, attributes: [title: 'proveedor'])
    }
}