package cratos
class Unidad implements Serializable {
    String codigo
    String descripcion
    static mapping = {
        table 'undd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'undd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'undd__id'
            codigo column: 'unddcdgo'
            descripcion column: 'undddscr'
        }
    }
    static constraints = {
        codigo(size: 1..8, blank: false, attributes: [title: 'Código'])
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'Descripción'])
    }

    String toString() {
        return this.descripcion
    }
}