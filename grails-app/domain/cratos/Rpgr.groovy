package cratos
class Rpgr implements Serializable {
    String descripcion
    ReporteCuenta reporteCuenta
    int numero
    static mapping = {
        table 'rpgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rpgr__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'rpgrdscr'
            reporteCuenta column: 'rpcn__id'
            numero column: 'rpgrnmro'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, attributes: [title: 'descripcion'])
        reporteCuenta(blank: true, nullable: true, attributes: [title: 'reporteCuenta'])
        numero(blank: false, attributes: [title: 'numero'])
    }
}