package cratos
class Operacion implements Serializable {
    String campo
    String tipo
    String descripcion
    int orden
    FechaSri fechaSri
    Cuenta cuenta
    Operador operador
    double valor
    static mapping = {
        table 'oprc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'oprc__id'
        id generator: 'identity'
        version false
        columns {
            campo column: 'oprccmpo'
            tipo column: 'oprctipo'
            descripcion column: 'oprcdscr'
            orden column: 'oprcordn'
            fechaSri column: 'fsri__id'
            cuenta column: 'cnta__id'
            operador column: 'oprd__id'
            valor column: 'oprcvlor'
        }
    }
    static constraints = {
        campo(blank: true, nullable: true, attributes: [title: 'campo'])
        tipo(size: 1..1, blank: true, nullable: true, attributes: [title: 'tipoProveedor'])
        descripcion(size: 1..31, blank: true, nullable: true, attributes: [title: 'descripcion'])
        orden(blank: true, nullable: true, attributes: [title: 'orden'])
        fechaSri(blank: true, nullable: true, attributes: [title: 'fechaSri'])
        cuenta(blank: true, nullable: true, attributes: [title: 'cuenta'])
        operador(blank: false, attributes: [title: 'operador'])
        valor(blank: false, attributes: [title: 'valor'])
    }
}