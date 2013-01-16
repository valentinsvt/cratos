package cratos
class Gestor implements Serializable {
    String estado
    Date fecha
    String descripcion
    String nombre
    Empresa empresa
    Fuente fuente
    String observaciones
    static auditable = true
    static hasMany = [movimientos: Genera]
    static mapping = {
        table 'gstr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'gstr__id'
        id generator: 'identity'
        version false
        columns {
            estado column: 'gstretdo'
            fecha column: 'gstrfcha'
            descripcion column: 'gstrdscr'
            nombre column: 'gdtrnmbr'
            empresa column: 'empr__id'
            fuente column: 'fnte__id'
            observaciones column: 'gstrobsr'
        }
    }
    static constraints = {
        estado(size: 1..1, blank: false, attributes: [title: 'estado'])
        fecha(blank: true, nullable: true, attributes: [title: 'fecha'])
        descripcion(size: 1..255, blank: false, attributes: [title: 'descripcion'])
        nombre(size: 1..127, blank: false, attributes: [title: 'nombre'])
        empresa(blank: true, nullable: true, attributes: [title: 'empresa'])
        fuente(blank: true, nullable: true, attributes: [title: 'fuente'])
        observaciones(blank: true, maxSize: 127, attributes: [title: 'observaciones'])
    }
}