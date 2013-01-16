package cratos
class FormaDePago implements Serializable {

    String codigo
    String descripcion

    static auditable = true
    static mapping = {
        table 'frpg'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'frpg__id'
        id generator: 'identity'
        version false
        columns {

            codigo column: 'frpgcdgo'
            descripcion column: 'frpgdscr'
        }
    }
    static constraints = {
        codigo(size: 4..4, blank: false, attributes: [title: 'codigo 4 letras'])
        descripcion(blank: true, nullable: true, size: 1..31, attributes: [title: 'descripción de la forma de pago'])
    }
}