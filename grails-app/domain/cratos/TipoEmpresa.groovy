package cratos
class TipoEmpresa implements Serializable {
    String descripcion

    static mapping = {
        table 'tpem'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpem__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpem__id'
            descripcion column: 'tpemdscr'
        }
    }
    static constraints = {
        descripcion(blank: true, attributes: [title: 'Descripción'])
    }

    String toString() {
        return this.descripcion
    }
}