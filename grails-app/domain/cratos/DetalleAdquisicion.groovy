package cratos
class DetalleAdquisicion implements Serializable {
    double subtotal
    double iva
    double ice
    double precioUnitario
    double cantidad
    Adquisiciones adquisiciones
    Item item
    String estado //0: default: no recibido, 1: recibido
    Bodega bodega
    static auditable = true
    static mapping = {
        table 'dtad'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtad__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtad__id'
            subtotal column: 'dtadsbtt'
            iva column: 'dtad_iva'
            ice column: 'dtad_ice'
            precioUnitario column: 'dtadpcun'
            cantidad column: 'dtadcntd'
            adquisiciones column: 'adqc__id'
            item column: 'item__id'
            estado column: 'dtadetdo'
            bodega column: 'bdga__id'
        }
    }
    static constraints = {
        subtotal(blank: true, nullable: true, attributes: [title: 'subtotal'])
        iva(blank: false, attributes: [title: 'iva'])
        ice(blank: false, attributes: [title: 'ice'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'precioUnitario'])
        cantidad(blank: true, nullable: true, attributes: [title: 'cantidad'])
        adquisiciones(blank: true, nullable: true, attributes: [title: 'adquisiciones'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        estado(blank: true, nullable: true, size: 1..1, attributes: [title: 'estado'])
        bodega(blank: true, nullable: true, attributes: [title: 'bodega'])
    }
}