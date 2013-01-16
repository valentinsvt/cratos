package cratos
class ReporteCuenta implements Serializable {
    Empresa empresa
    String descripcion

    static mapping = {
        table 'rpcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rpcn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rpcn__id'
            empresa column: 'empr__id'
            descripcion column: 'rpcndscr'
        }
    }
    static constraints = {
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        descripcion(blank: false, attributes: [title: 'descripcion'])
    }
}