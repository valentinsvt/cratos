package cratos
class CentroCosto implements Serializable {

    Empresa empresa
    String nombre
    static auditable = true
    static mapping = {
        table 'cncs'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cncs__id'
        id generator: 'identity'
        version false
        columns {
            empresa column: 'empr__id'
            nombre column: 'cncsnmbr'
        }
    }
    static constraints = {
        empresa(blank: false, attributes: [title: 'empresa'])
        nombre(blank: false, maxSize: 127, attributes: [title: 'nombre'])
    }
}