package cratos
class Item implements Serializable {
    Empresa empresa
    int iva

    double ice = 0 //porcentaje de ice q paga el item en decimal: 0.35 para 35%

    double peso
    double stockMaximo
    double stock
    double precioVenta
    double precioCosto
    Date fecha
    String estado
    double precioUnitario
    String nombre
    String codigo
    Unidad unidad
    Marca marca
    Grupo grupo
    String observaciones
    static mapping = {
        table 'item'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'item__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            iva column: 'item_iva'

            ice column: 'item_ice'

            peso column: 'itempeso'
            stockMaximo column: 'itemstmx'
            stock column: 'itemstmn'
            precioVenta column: 'itempcvn'
            precioCosto column: 'itempccs'
            fecha column: 'itemfcha'
            estado column: 'itemetdo'
            precioUnitario column: 'itempcun'
            nombre column: 'itemnmbr'
            codigo column: 'itemcdgo'
            unidad column: 'undd__id'
            marca column: 'mrca__id'
            grupo column: 'grpo__id'
            observaciones column: 'itemobsr'
        }
    }
    static constraints = {
        empresa(blank: false, nullable: false)
        iva(size: 1..1, blank: false, attributes: [title: 'iva'])
        ice(blank: false, attributes: [title: 'ice'])
        peso(blank: true, nullable: true, attributes: [title: 'peso'])
        stockMaximo(blank: true, nullable: true, attributes: [title: 'stockMaximo'])
        stock(blank: true, nullable: true, attributes: [title: 'stock'])
        precioVenta(blank: false, attributes: [title: 'precioVenta'])
        precioCosto(blank: true, nullable: true, attributes: [title: 'precioCosto'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        estado(size: 1..1, blank: true, nullable: true, attributes: [title: 'estado'])
        precioUnitario(blank: true, nullable: true, attributes: [title: 'precioUnitario'])
        nombre(size: 1..127, blank: false, attributes: [title: 'nombre'])
        codigo(size: 1..15, blank: false, attributes: [title: 'codigo'])
        unidad(blank: true, nullable: true, attributes: [title: 'unidad'])
        marca(blank: true, nullable: true, attributes: [title: 'marca'])
        grupo(blank: true, nullable: true, attributes: [title: 'grupo'])
        observaciones(blank: true, nullable: true, size: 1..127, attibutes: [title: 'observaciones'])
    }
}