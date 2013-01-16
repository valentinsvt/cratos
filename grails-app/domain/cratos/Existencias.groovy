package cratos
class Existencias implements Serializable {
    Date fecha
    double cantidad
    Empresa empresa
    Item item
    double existenciaInicial

    Bodega bodega

//    double precio

    static mapping = {
        table 'exst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'exst__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'exst__id'
            fecha column: 'exstfcha'
            cantidad column: 'exstcntd'
            empresa column: 'empr__id'
            item column: 'item__id'
            existenciaInicial column: 'exst_ini'

            bodega column: 'bdga__id'

//            precio column: 'exstprco'
        }
    }
    static constraints = {
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        cantidad(blank: true, nullable: true, attributes: [title: 'cantidad'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        existenciaInicial(blank: true, nullable: true, attributes: [title: 'existencia inicial'])


    }
}