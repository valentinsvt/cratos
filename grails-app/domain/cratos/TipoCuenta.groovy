package cratos
class TipoCuenta implements Serializable {
    String tipoCuenta
    static mapping = {
        table 'tpcn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpcn__id'
        id generator: 'identity'
        version false
        columns {
            tipoCuenta column: 'tpcndscr'
        }
    }
    static constraints = {
        tipoCuenta(blank: false, attributes: [title: 'Tipo de Cuenta Bancaria'])
    }
}