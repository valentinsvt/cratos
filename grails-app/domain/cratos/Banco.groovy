package cratos
class Banco implements Serializable {
    String descripcion
    String codigo
    Empresa empresa
    static mapping = {
        table 'bnco'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'bnco__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'bncodscr'
            codigo column: 'bncocdgo'
            empresa column: 'empr__id'
        }
    }
    static constraints = {
        descripcion(size: 1..40, blank: false, attributes: [title: 'descripcion'])
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
    }
}