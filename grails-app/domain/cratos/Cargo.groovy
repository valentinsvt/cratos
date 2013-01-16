package cratos
class Cargo implements Serializable {
    String descripcion
    Empresa empresa
    Departamento departamento
    double sueldo

    static mapping = {
        table 'crgo'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crgo__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'crgo__id'
            descripcion column: 'crgodscr'
            empresa column: 'empr__id'
            departamento column: 'dpto__id'
            sueldo column: 'crgosldo'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, nullable: false, attributes: [title: 'descripcion'])
        empresa(blank: false, nullable: false, attributes: [title: 'empresa'])
        departamento(blank: true, nullable: true, attributes: [title: 'departamento'])
        sueldo(blank: false, nullable: false, attributes: [title: 'crgosldo'])
    }
    String toString() {
        descripcion
    }
}