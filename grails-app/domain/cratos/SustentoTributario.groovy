package cratos

class SustentoTributario implements Serializable {

    String codigo
    String descripcion

    static mapping = {
        table 'sstr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'sstr__id'
        id generator: 'identity'
        version false
        columns {
            codigo column: 'sstrcdgo'
            descripcion column: 'sstrdscr'
        }
    }

    static constraints = {
        descripcion(maxSize: 127)
    }
}