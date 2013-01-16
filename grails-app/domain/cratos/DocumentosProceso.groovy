package cratos
class DocumentosProceso implements Serializable {

    Proceso proceso
    TipoDocumentoProveedor tipoDocumentoProveedor
    TipoComprobanteId tipoComprobanteId
    String documentosProcesoSerie01
    String documentosProcesoSerie02
    int secuencial
    String autorizacionSRI
    Date fecha


    static auditable = true

    static mapping = {
        table 'dcpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcpr__id'
        id generator: 'identity'
        version false
        columns {
            proceso column: 'prcs__id'
            tipoDocumentoProveedor column: 'tpdp__id'
            tipoComprobanteId column: 'tcti__id'
            documentosProcesoSerie01 column: 'dcprsr01'
            documentosProcesoSerie02 column: 'dcprsr02'
            secuencial column: 'dcprscnc'
            autorizacionSRI column: 'dcprasri'
            fecha column: 'dcprfcha'
        }
    }
    static constraints = {
        proceso(blank: false, attributes: [title: 'proceso'])
        tipoDocumentoProveedor(blank: false, attributes: [title: 'tipoDocumentoProveedor'])
        tipoComprobanteId(blank: false, attributes: [title: 'tipoComprobanteId'])
        documentosProcesoSerie01(blank: true, maxSize: 3, attributes: [title: 'documentosProcesoSerie01'])
        documentosProcesoSerie02(blank: true, maxSize: 3, attributes: [title: 'documentosProcesoSerie02'])
        secuencial(blank: false, attributes: [title: 'secuencial'])
        autorizacionSRI(blank: true, attributes: [title: 'autorizacionSRI'])
        fecha(attributes: [title: 'fecha'])
    }
}