package cratos
class DocumentosProveedor implements Serializable {
    Proveedor proveedor
    TipoDocumentoProveedor tipoDocumentoProveedor
    String documentosProveedorSerie01
    String documentosProveedorSerie02
    String autorizacionSRI
    Date fechaAutorizacionSRI
    Date fechaValidoHasta

    static auditable = true

    static mapping = {
        table 'dcpv'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcpv__id'
        id generator: 'identity'
        version false
        columns {
            proveedor column: 'prve__id'
            tipoDocumentoProveedor column: 'tpdp__id'
            documentosProveedorSerie01 column: 'dcpvsr01'
            documentosProveedorSerie02 column: 'dcpvsr02'
            autorizacionSRI column: 'dcpvasri'
            fechaAutorizacionSRI column: 'dcpvfcas'
            fechaValidoHasta column: 'dcpvfchs'

        }
    }
    static constraints = {
        proveedor(blank: false, attributes: [title: 'proveedor'])
        tipoDocumentoProveedor(blank: false, attributes: [title: 'tipoDocumentoProveedor'])
        documentosProveedorSerie01(blank: true, maxSize: 3, attributes: [title: 'documentosProveedorSerie01'])
        documentosProveedorSerie02(blank: true, maxSize: 3, attributes: [title: 'documentosProveedorSerie02'])
        fechaAutorizacionSRI(attributes: [title: 'fechaAutorizacionSRI'])
        fechaValidoHasta(attributes: [title: 'fechaValidoHasta'])
    }
}