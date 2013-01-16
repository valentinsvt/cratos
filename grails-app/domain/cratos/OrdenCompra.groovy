package cratos
class OrdenCompra implements Serializable {

    CentroCosto centroCosto
    String descripcion
    double valor
    Date fecha
    String estado   //N: no registrada, R: Registrada, C: comprada completamente
    String observaciones

    String numero

    static auditable = true

    static mapping = {
        table 'odcp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'odcp__id'
        id generator: 'identity'
        version false
        columns {
            centroCosto column: 'cncs__id'
            descripcion column: 'odcpdscr'
            valor column: 'odcpvlor'
            fecha column: 'odcpfcha'
            estado column: 'odcpetdo'
            observaciones column: 'odcpobsr'

            numero column: 'odcpnmro'
        }
    }
    static constraints = {
        centroCosto(blank: false, attributes: [title: 'centroCosto'])
        descripcion(blank: false, maxSize: 127, attributes: [title: 'descripcion'])
        valor(blank: false, attributes: [title: 'valor'])
        fecha(blank: true, attributes: [title: 'fecha'])
        estado(blank: true, attributes: [title: 'estado'])
        observaciones(blank: true, attributes: [title: 'observaciones'])

        numero(blank: true, nullable: true, attributes: [title: 'numero'])
    }
}