package cratos
class DetalleTransferencia implements Serializable {
    double cantidad
    Item item
    Transferencia transferencia
    double precioUnitario
    static mapping = {
        table 'dttr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dttr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dttr__id'
            cantidad column: 'dttrcntd'
            item column: 'item__id'
            transferencia column: 'trnf__id'
            precioUnitario column: 'dttrpcun'
        }
    }
    static constraints = {
        cantidad(blank: true, nullable: true, attributes: [title: 'cantidad'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        transferencia(blank: true, nullable: true, attributes: [title: 'transferencia'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'precio unitario'])
    }
}