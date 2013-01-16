package cratos
class Parametros implements Serializable {
    String descripcion
    String valor
    static mapping = {
        table 'prmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prmt__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'prmtdscr'
            valor column: 'prmtvlor'
        }
    }
    static constraints = {
        descripcion(blank: false, size:1..50 , attributes: [title: 'descripcion'])
        valor(blank: false, size:1..50 , attributes: [title: 'valor'])
    }
}