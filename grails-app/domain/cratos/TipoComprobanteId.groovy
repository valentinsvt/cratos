package cratos
class TipoComprobanteId implements Serializable {
    TipoIdentificacion tipoIdentificacion
    TipoComprobanteSri tipoComprobanteSri

    static auditable = true
    static mapping = {
        table 'tcti'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tcti__id'
        id generator: 'identity'
        version false
        columns {
            tipoIdentificacion column: 'tpid__id'
            tipoComprobanteSri column: 'tpcp__id'
        }
    }
    static constraints = {
        tipoIdentificacion(blank: false, attributes: [title: 'tipoIdentificacion'])
        tipoComprobanteSri(blank: false, attributes: [title: 'tipoComprobanteSRI'])

    }

    String toString(){
       "${this.tipoComprobanteSri.descripcion}"
    }
}