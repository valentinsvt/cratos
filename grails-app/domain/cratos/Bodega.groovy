package cratos
class Bodega implements Serializable {
    CentroCosto centroCosto
    String codigo
    String descripcion

    static mapping = {

        table 'bdga'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'bdga__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'bdga__id'
            centroCosto column: 'cncs__id'
            codigo column: 'cncscdgo'
            descripcion column: 'bdgadscr'
        }
    }
    static constraints = {
        centroCosto(blank: true, nullable: true, attributes: [title: 'centroCosto'])
        codigo(blank: true, nullable: true, size: 1..8, attributes: [title: 'código de la bodega, máximo 8 letras'])
        descripcion(blank: true, nullable: true, size: 1..40, attributes: [title: 'descripcion'])
    }
}