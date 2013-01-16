package cratos

class ParametrosAuxiliares {

    Double iva


    static mapping = {
        table 'paux'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'paux__id'
        id generator: 'identity'
        version false
        columns {
            iva column: "paux_iva"
        }
    }

    static constraints = {
        iva(blank: false, nullable: false)
    }

    String toString() {
        return this.iva
    }
}
