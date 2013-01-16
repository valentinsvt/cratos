package cratos
class Diferencia implements Serializable {
    Date fecha
    Empresa empresa
    Item item
    double cntd
    static mapping = {
        table 'diff'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'diff__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'diff__id'
            fecha column: 'difffcha'
            empresa column: 'empr__id'
            item column: 'item__id'
            cntd column: 'diffcntd'
        }
    }
    static constraints = {
        fecha(blank: false, attributes: [title: 'fecha'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        cntd(blank: true, nullable: true, attributes: [title: 'cntd'])
    }
}