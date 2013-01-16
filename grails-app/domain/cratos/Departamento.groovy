package cratos
class Departamento implements Serializable {
    Empresa empresa
    String descripcion
    static mapping = {
        table 'dpto'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dpto__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dpto__id'
            empresa column: 'empr__id'
            descripcion column: 'dptodscr'
        }
    }
    static constraints = {
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        descripcion(blank: true, nullable: true, attributes: [title: 'descripcion'])
    }
    String toString() {
        descripcion
    }
}