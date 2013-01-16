package cratos
class ActivoFijo implements Serializable {
    Date fechaInicio
    String modelo
    String serie
    int periodoDepreciacion
    Date fechaAdquisicion
    Color color
    Item item
    String observaciones


    static mapping = {
        table 'acfj'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'acfj__id'
        id generator: 'identity'
        version false
        columns {
            fechaInicio column: 'acfjfcin'
            modelo column: 'acfjmdlo'
            serie column: 'acfjsrie'
            periodoDepreciacion column: 'acfjprdp'
            fechaAdquisicion column: 'acfjfcad'
            color column: 'clor__id'
            item column: 'item__id'
            observaciones column: 'acfjobsr'
        }
    }
    static constraints = {
        fechaInicio(blank: true, nullable: true, attributes: [title: 'fechaInicio'])
        modelo(size: 1..63, blank: true, nullable: true, attributes: [title: 'modelo'])
        serie(size: 1..31, blank: true, nullable: true, attributes: [title: 'serie'])
        periodoDepreciacion(blank: true, nullable: true, attributes: [title: 'periodoDepreciacion'])
        fechaAdquisicion(blank: true, nullable: true, attributes: [title: 'fechaAdquisicion'])
        color(blank: true, nullable: true, attributes: [title: 'color'])
        item(blank: true, nullable: true, attributes: [title: 'item'])
        observaciones(blank: true, nullable: true, size: 1..127, attributes: [title: "Observaciones"])
    }
}