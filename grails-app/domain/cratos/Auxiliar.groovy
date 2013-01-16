package cratos
class Auxiliar implements Serializable {
    double haber = 0
    double debe = 0
    String descripcion
    Asiento asiento
    Date fechaRegistro = new Date()
    Date fechaPago
    Proveedor proveedor

    static mapping = {
        table 'axlr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'axlr__id'
        id generator: 'identity'
        version false
        columns {
            haber column: 'axlrhber'
            debe column: 'axlrdebe'
            descripcion column: 'axlrdscr'
            asiento column: 'asnt__id'
            fechaRegistro column: 'axlrfcrg'
            fechaPago column: 'axlrfcpg'
            proveedor column: 'prve__id'
        }
    }
    static constraints = {
        haber(blank: false, nullable: false, attributes: [title: 'haber'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [title: 'descripcion'])
        asiento(blank: true, nullable: true, attributes: [title: 'asiento'])
        fechaPago(blank: true, nullable: true)
        fechaRegistro(blank: true, nullable: true)
        proveedor(blank: true, nullable: true)
    }


}