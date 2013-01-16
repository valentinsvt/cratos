package cratos
class Consumo implements Serializable {

    double precioUnitario
    double descuento
    double cantidad
    Item item
    Factura factura
    String observaciones
    static auditable = true
    static mapping = {
        table 'cnsm'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cnsm__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cnsm__id'

            precioUnitario column: 'cnsmpcun'
            descuento column: 'cnsmdsct'
            cantidad column: 'cnsmcntd'
            item column: 'item__id'
            factura column: 'fctr__id'
            observaciones column: 'cnsmobsr'
        }
    }
    static constraints = {

        precioUnitario(blank: true, nullable: true, attributes: [title: 'precioUnitario'])
        descuento(blank: true, nullable: true, attributes: [title: 'descuento'])
        cantidad(blank: false, attributes: [title: 'cantidad'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        factura(blank: true, nullable: true, attributes: [title: 'factura'])
        observaciones(blank: true, nullable: true, size: 1..63, attributes: [title: 'observaciones'])
    }
}