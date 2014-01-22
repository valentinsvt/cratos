package cratos
class TipoComprobanteSri implements Serializable {
    String codigo
    String descripcion
    String secuenciales /*Código Secuenciales Transacción*/
    String sustento /*Sustento tributario*/
    static auditable = true
    static mapping = {
        table 'tpcp_sri'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpcp__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'tpcpcdgo'
            descripcion column: 'tpcpdscr'
            secuenciales column: 'tpcpsecu'
            sustento column: 'tpcpsust'
        }
    }
    static constraints = {
        codigo(size: 1..4, blank: false, attributes: [title: 'codigo'])
        descripcion(blank: false, maxSize: 520, attributes: [title: 'descripcion'])
        secuenciales(blank: true,nullable: true,size: 1..120)
        sustento(blank: true,nullable: true,size: 1..120)
    }
}