package cratos
class DetalleFactura implements Serializable {
    double descuento
    double precioUnitario
    double cantidad
    Bodega bodega
    Item item
    Factura factura
    String observaciones
    static auditable = true
    static mapping = {
        table 'dtfc'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtfc__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtfc__id'
            descuento column: 'dtfcdsct'
            precioUnitario column: 'dtfcpcun'
            cantidad column: 'dtfccntd'
            item column: 'item__id'
            factura column: 'fctr__id'
            observaciones column: 'dtfcobsr'
            bodega column: 'bdga__id'
        }
    }
    static constraints = {
        descuento(blank: true, nullable: true, attributes: [title: 'descuento'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'precioUnitario'])
        cantidad(blank: false, attributes: [title: 'cantidad'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        factura(blank: true, nullable: true, attributes: [title: 'factura'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: 'observaciones'])
        bodega(blank:true,nullable: true)
    }
}