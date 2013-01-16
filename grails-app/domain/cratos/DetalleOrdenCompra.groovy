package cratos
class DetalleOrdenCompra implements Serializable {
    OrdenCompra ordenCompra
    Item item
    double cantidad
    double precioUnitario

    static auditable = true
    static mapping = {
        table 'dtoc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtoc__id'
        id generator: 'identity'
        version false
        columns {
            ordenCompra column: 'odcp__id'
            item column: 'item_id'
            cantidad column: 'dtoccntd'
            precioUnitario column: 'dtocpcun'
        }
    }
    static constraints = {
        ordenCompra(blank: false, attributes: [title: 'ordenCompra'])
        item(blank: false, attributes: [title: 'item'])
        cantidad(blank: false, attributes: [title: 'cantidad'])
        precioUnitario(blank: false, attributes: [title: 'precioUnitario'])
    }
}