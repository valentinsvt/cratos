package cratos
class Profesion implements Serializable {
    String descripcion
    String sigla

    static mapping = {
        table 'prof'
        cache usage: 'read-write', include: 'non-lazy'

        id column: 'prof__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prof__id'
            descripcion column: 'profdscr'
            sigla column: 'profsgla'
        }
    }
    static constraints = {
        descripcion(blank: false, size: 1..63, attributes: [title: 'descripcion'])
        sigla(blank: false, size: 1..7, attributes: [title: 'Sigla o Abreviatura'])
    }
    String toString() {
        descripcion
    }
}