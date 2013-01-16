package cratos
class Grupo implements Serializable {
    String codigo
    Cuenta cuenta
    String descripcion

    static mapping = {
        table 'grpo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'grpo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'grpo__id'
            codigo column: 'grpocdgo'
            cuenta column: 'cnta__id'
            descripcion column: 'grpodscr'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: true, nullable: true, attributes: [title: 'codigo'])
        cuenta(blank: true, nullable: true, attributes: [title: 'cuenta'])
        descripcion(blank: true, nullable: true, size: 1..63, attributes: [title: 'descripcion'])
    }
}