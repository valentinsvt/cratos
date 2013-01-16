package cratos

class DocumentoProveedor implements Serializable {

    Proceso proceso
    TipoDocumentoProveedor tipoDepartamento
    String numero
    String autorizacionSRI

    static mapping = {
        table 'dcpr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcpr__id'
        id generator: 'identity'
        version false
        columns {
            proceso column: 'prcs__id'
            tipoDepartamento column: 'descripcion'
            numero column: 'dcprnmro'
            autorizacionSRI column: 'dcprasri'
        }
    }
    static constraints = {
        proceso(blank: false, attributes: [title: 'proceso'])
        tipoDepartamento(blank: false, attributes: [title: 'tipoProveedor departamento'])
        numero(blank: false, maxSize: 15, attributes: [title: 'numero'])
        autorizacionSRI(blank: false, maxSize: 10, attributes: [title: 'autorizacion sri'])
    }
}