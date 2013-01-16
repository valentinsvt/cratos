package cratos
class ReporteLinea implements Serializable {
    String descripcion
    Rpgr rpgr /*CM*/
    int numero
    static mapping = {
        table 'rpln'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rpln__id'
        id generator: 'identity'
        version false
        columns {
            descripcion column: 'rplndscr'
            rpgr column: 'rpgr__id'
            numero column: 'rplnnmro'
        }
    }
    static constraints = {
        descripcion(size: 1..127, blank: false, attributes: [title: 'descripcion'])
        rpgr(blank: true, nullable: true, attributes: [title: 'rpgr?'])
        numero(blank: false, attributes: [title: 'numero'])
    }
}