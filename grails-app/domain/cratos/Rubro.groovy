package cratos
class Rubro implements Serializable {
    double porcentaje
    String editable
    String decimo
    String iess
    String gravable
    String descripcion
    TipoRubro tipoRubro
    double valor

    static mapping = {
        table 'rbro'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rbro__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'rbro__id'
            porcentaje column: 'rbropcnt'
            editable column: 'rbroedit'
            decimo column: 'rbrodcmo'
            iess column: 'rbroiess'
            gravable column: 'rbrogrvb'
            descripcion column: 'rbrodscr'
            tipoRubro column: 'tprb__id'
            valor column: 'rbrovlor'
        }
    }
    static constraints = {
        tipoRubro(blank: false, nullable: false, attributes: [title: 'tipoRubro'])
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
        porcentaje(blank: true, nullable: true, attributes: [title: 'porcentaje'])
        editable(size: 1..1, blank: false, nullable: false, attributes: [title: 'editable'])
        decimo(size: 1..1, blank: false, nullable: false, attributes: [title: 'decimo'])
        iess(size: 1..1, blank: false, nullable: false, attributes: [title: 'iess'])
        gravable(size: 1..1, blank: false, nullable: false, attributes: [title: 'grabable'])
        valor(blank: true, nullable: true, attributes: [title: 'valor predefinido'])
    }
    String toString() {
        "${tipoRubro}: ${descripcion}"
    }
}