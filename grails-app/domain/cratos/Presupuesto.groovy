package cratos
class Presupuesto implements Serializable {
    String padre
    String codigo
    Empresa empresa
    Nivel nivel
    String descripcion
    static mapping = {
        table 'prsp'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prsp__id'
        id generator: 'identity'
        version false
        columns {
            padre column: 'prsppdre'
            codigo column: 'prspcdgo'
            empresa column: 'empr__id'
            nivel column: 'nvel__id'
            descripcion column: 'prspdscr'
        }
    }
    static constraints = {
        padre(size: 1..20, blank: true, nullable: true, attributes: [title: 'padre'])
        codigo(size: 1..20, blank: true, nullable: true, attributes: [title: 'codigo'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        nivel(blank: true, nullable: true, attributes: [title: 'nivel'])
        descripcion(blank: true, maxSize: 127, attributes: [title: 'descripcion'])
    }
}